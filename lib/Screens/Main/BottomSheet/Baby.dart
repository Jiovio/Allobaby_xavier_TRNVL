import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/BabyCry/babyCryController.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class Baby extends StatefulWidget {
  Baby({super.key});

  @override
  State<Baby> createState() => _BabyState();
}

class _BabyState extends State<Baby> {
    final Babycrycontroller controller = Get.put(Babycrycontroller());
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isPlayerInitialized = false;
  Duration duration = Duration(seconds: 10);
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    if (controller.audio == null) {
      print("No audio file available");
      return;
    }

    try {
      // Set the audio source
      await _audioPlayer.setFilePath(controller.audio!.path);
      await _audioPlayer.setLoopMode(LoopMode.one);
      
      // Mark player as initialized
      setState(() {
        isPlayerInitialized = true;
      });

      // Set up streams
      _setupAudioStreams();
    } catch (e) {
      print("Error initializing audio player: $e");
      _showErrorSnackbar('Unable to load audio file');
    }
  }

  void _setupAudioStreams() {
    // Player state stream
    _audioPlayer.playerStateStream.listen(
      (playerState) {
        setState(() {
          isPlaying = playerState.playing;
        });
      },
      onError: (error) {
        print("Error in player state stream: $error");
        _showErrorSnackbar('Playback error occurred');
      },
    );

    // Position stream
   _audioPlayer.positionStream.listen(
      (newPosition) {
        setState(() {
          position = newPosition;
          // If position exceeds duration, it will automatically loop due to LoopMode.one
        });
      },
      onError: (error) {
        print("Error in position stream: $error");
      },
    );

    // Duration stream
    _audioPlayer.durationStream.listen(
      (newDuration) {
        if (newDuration != null) {
          setState(() {
            duration = newDuration;
          });
        }
      },
      onError: (error) {
        print("Error in duration stream: $error");
      },
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.red,
      colorText: White,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> playPause() async {
    if (!isPlayerInitialized) {
      _showErrorSnackbar('Audio player not ready');
      return;
    }

    try {
      if (isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      print("Error playing/pausing audio: $e");
      _showErrorSnackbar('Unable to ${isPlaying ? 'pause' : 'play'} audio');
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print("Error seeking: $e");
      _showErrorSnackbar('Unable to seek');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
  
        leading: IconButton(
          onPressed: () {
            Get.offAll(() => MainScreen(), transition: Transition.fade);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Black),
        ),
      ),


      
      
bottomNavigationBar: Container(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  height: 75,
  decoration: BoxDecoration(
    color: PrimaryColor,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: Offset(0, -5),
      ),
    ],
  ),
  child: Row(
    children: [
      // Play/Pause Button
      IconButton(
        onPressed: () {
          if(controller.audio != null) {
            playPause();
          }
        },
        icon: Icon(
          isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
          color: White,
          size: 32,
        ),
      ),
      
      SizedBox(width: 10),
      
      // Current time
      StreamBuilder<Duration>(
        stream: _audioPlayer.positionStream,
        builder: (context, snapshot) {
          return Text(
            formatTime(snapshot.data ?? Duration.zero),
            style: TextStyle(color: White),
          );
        },
      ),
      
      SizedBox(width: 10),
      
      // Audio progress bar
      Expanded(
        child: StreamBuilder<Duration>(
          stream: _audioPlayer.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final maxDuration = duration.inMilliseconds.toDouble();
            
            // Ensure position value doesn't exceed maxDuration
            final validPosition = position.inMilliseconds.toDouble().clamp(0, maxDuration);
            
            return SliderTheme(
              data: SliderThemeData(
                thumbColor: White,
                activeTrackColor: White,
                inactiveTrackColor: White.withOpacity(0.3),
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                min: 0,
                max: maxDuration > 0 ? maxDuration : 1, // Prevent max being 0
                value: validPosition.toDouble(),
                onChanged: (value) {
                  if (value >= 0 && value <= maxDuration) {
                    _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                  }


                },
              ),
            );
          },
        ),
      ),
    ],
  ),
),


      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baby Image Section
              Center(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.1),
                    //     blurRadius: 10,
                    //     spreadRadius: 5,
                    //   ),
                    // ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/BottomSheet/crybaby.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
              // Reason Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: White,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: PrimaryColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.psychology_outlined, 
                            color: PrimaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Probable Reason".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                controller.reason,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Recommendations Section
              Text(
                "Recommendations".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.stepsToComfortTheBaby.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: White,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: PrimaryColor.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PrimaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: PrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.stepsToComfortTheBaby[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Black.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}