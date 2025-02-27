import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/BabyCry/babyCryController.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby/BabycryFailed.dart';
import 'package:allobaby/features/babycry/controller/cry_controller.dart';
import 'package:allobaby/features/babycry/service/audio_classifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lottie/lottie.dart';

class VoiceRecorderNew extends StatefulWidget {
  final Color primaryColor = PrimaryColor;
  final Color backgroundColor = Colors.white;

  const VoiceRecorderNew({
    Key? key,

  }) : super(key: key);

  @override
  State<VoiceRecorderNew> createState() => _VoiceRecorderNewState();
}

class _VoiceRecorderNewState extends State<VoiceRecorderNew> with SingleTickerProviderStateMixin {
  AudioRecorder? _recorder ;
  Timer? _timer;
  Timer? _tipsTimer;
  int _countdown = 0;
  bool _isRecording = false;

  int _currentTipIndex = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool modelLoaded = false;

  CryController controller = Get.put(CryController());

  void prediction(String val, String audioPath, List<String> preds) async {

  bool cry = await calculateDisplayText(preds);

  if(cry){
    controller.detect(val, audioPath);
    controller.uploadDatatoServer(File(audioPath),cry,val);
    _cancelRecording();

  }

  controller.uploadDatatoServer(File(audioPath),cry,val);

  



  }



  AudioClassifier audioClassifier = AudioClassifier();

  List<String> crys = ["Crying, sobbing","Baby cry, infant cry","Crying","sobbing"];

  List<String> listOfCry = [];


    String displayText = "Getting your Baby Sound..";

  bool cryDetected = false;

    Future<bool> calculateDisplayText(List<String> vals) async {
      bool d =false;
      bool babycry = false;
    
    vals.forEach((v){

      if(v=="Silence"){
        displayText = "Inaudible. \n Please move closer to baby.";
        d=true;
      }

      if(v=="Speech"){
        displayText = "Please dont talk while recording .";
        d=true;
      }

      if(crys.contains(v)) {
        cryDetected = true;
        displayText = "Detected Baby Cry.";
        babycry = true;
        d=true;
 
        }
    });


            if(!d){
          displayText = "Checking for Baby Cry.";
        }
                setState(() {
        });


        return babycry;
  }

  void detectCry() async {

    if(_recorder != null){
    final p = await _recorder!.stop();

    // OurFirebase.uploadTestAudioToStorage(classs, p!);


    await audioClassifier.processAudio(p!,prediction );

    
      Directory appDir = await getApplicationDocumentsDirectory();
    const encoder = AudioEncoder.wav;
    const config = RecordConfig(encoder: encoder, numChannels: 1,sampleRate: 16000);
      await _recorder!.start(config, path: '${appDir.path}/${_countdown.toString()}.wav');
    }
  }

  final List<Map<String, dynamic>> _babyTips = [
    {
      'icon': Icons.volume_up,
      'text': 'High-pitched, intense crying often indicates pain or immediate needs.'.tr,
    },
    {
      'icon': Icons.night_shelter,
      'text': 'Rhythmic crying that gets louder and softer might mean your baby is tired.',
    },
    {
      'icon': Icons.restaurant,
      'text': 'Short, low-pitched cries repeated every few seconds usually signal hunger.',
    },
    {
      'icon': Icons.mood_bad,
      'text': 'Whimpering or whining sounds might indicate mild discomfort or wanting attention.',
    },
    {
      'icon': Icons.healing,
      'text': 'Long, high-pitched screams could be signs of colic or stomach pain.',
    },
    {
      'icon': Icons.thermostat,
      'text': 'Sudden, sharp cries might mean your baby is too hot or cold.',
    },
    {
      'icon': Icons.wash,
      'text': 'Persistent crying with leg movement often indicates diaper change needs.',
    },
  ];

  @override
  void initState() {
    super.initState();
    audioClassifier.initializeModel().then((v){
      modelLoaded = true;

      setState(() {
        
      });
    });

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _startRecording();

    _startTipsRotation();
  }

  void _startTipsRotation() {
    _tipsTimer?.cancel();
    _tipsTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _currentTipIndex = (_currentTipIndex + 1) % _babyTips.length;
        });
      }
    });
  }

  Future<void> _startRecording() async {

    _recorder = AudioRecorder();


    if(_recorder != null){
    
    if (await _recorder!.hasPermission()) {
      Directory appDir = await getApplicationDocumentsDirectory();
    const encoder = AudioEncoder.wav;
    final config = RecordConfig(encoder: encoder, numChannels: 1,sampleRate: 16000);

      await _recorder!.start(config, path: '${appDir.path}/${_countdown.toString()}.wav');
      setState(() {

        _isRecording = true;
        _countdown = 0;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

        if(_countdown > 0 && _countdown % 7 == 0){

         detectCry();
        }

        //  setState(() {
        //     _countdown++;
        //   });

        if(_countdown >22){
          Get.to(()=> const Babycryfailed());
          _cancelRecording();

        }else{

          setState(() {
            _countdown++;
          });
        }
      });
    }
    }


  }

  // Babycrycontroller controller = Get.put(Babycrycontroller());

  Future<void> _stopRecording() async {
    _timer?.cancel();

    if (_isRecording) {
      final path = await _recorder!.stop();

      await _recorder!.dispose();
      setState(() => _isRecording = false);
      
      if (path != null ) {

        print(path);

        final pred = await audioClassifier.processAudio(path,prediction);

        print(pred);

        // File audioFile = File(path);
        // controller.babydetect(audioFile);
        // print(path);

      }
    }
  }

  Future<void> _cancelRecording() async {
    _timer?.cancel();
    if (_isRecording) {
      await _recorder!.stop();
      await _recorder!.dispose();
      setState(() => _isRecording = false);
    }
    // Get.back();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tipsTimer?.cancel();

    if(_recorder!=null){
    _recorder?.dispose();
    }
    _pulseController.dispose();
    audioClassifier.dispose();
    super.dispose();
  }

  Widget _buildControlButtons() {
    if (_isRecording) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          if(cryDetected && _countdown >6)
          AnimatedContainer(
            duration:const Duration(milliseconds: 300),
            child: ElevatedButton.icon(
              onPressed: _stopRecording,
              icon: const Icon(Icons.stop, color: Colors.white),
              label: Text(
                'STOP'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: widget.primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(width: 20),
          // Cancel Button
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: ElevatedButton.icon(
              onPressed: _cancelRecording,
              icon: Icon(Icons.close, color: Colors.white),
              label: Text(
                'Cancel'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor.withOpacity(0.7),
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                shadowColor: widget.primaryColor.withOpacity(0.3),
              ),
            ),
          ),
        ],
      );
    } else {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: ElevatedButton.icon(
          onPressed: _startRecording,
          icon: Icon(
            Icons.mic,
            size: 28,
            color: Colors.white,
          ),
          label: Text(
            'Start Recording'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 8,
            shadowColor: widget.primaryColor.withOpacity(0.5),
          ),
        ),
      );
    }
  }

  Widget _buildTipCard() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<int>(_currentTipIndex),
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                _babyTips[_currentTipIndex]['icon'],
                color: widget.primaryColor,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                _babyTips[_currentTipIndex]['text'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !modelLoaded ? CircularProgressIndicator() : Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.primaryColor,
              widget.primaryColor.withOpacity(0.8),
              widget.primaryColor.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // if (_isChecking) ...[
                    //   Lottie.asset(
                    //     'assets/animations/Ani5.json',
                    //     width: 120,
                    //     height: 120,
                    //   ),
                    //   const SizedBox(height: 20),
                    //   Text(
                    //     'Checking microphone\nPlease wait',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 24,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ] else
                     if (_isRecording) ...[
                      // Recording indicator
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: PrimaryColor,
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                           const SizedBox(width: 12),
                            Text(
                              'Recording'.tr + ' ${_countdown}s',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Animation
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.asset(
                            'assets/animations/Ani7.json',
                            width: 250,
                            height: 250,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Text(listOfCry.toString(),),
                      Text(
                        displayText.tr,
                        
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        cryDetected ?
                        "Baby Cry Detected" + "\n" + "Tap stop to detect." :
                        'Try to avoid background noise'.tr,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ] else ...[
                      Lottie.asset(
                        'assets/animations/Ani6.json',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 24),
                    ],
                    
                    // Control Buttons
                    _buildControlButtons(),
                  ],
                ),
              ),
              
              
              // if (_isRecording)
              //   Padding(
              //     padding: EdgeInsets.only(bottom: 24),
              //     child: _buildTipCard(),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}