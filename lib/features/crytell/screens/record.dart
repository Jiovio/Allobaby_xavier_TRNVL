import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lottie/lottie.dart';

class VoiceRecorderNew extends StatefulWidget {
  final Function(File)? onRecordingComplete;
  final Color primaryColor;
  final Color backgroundColor;

  const VoiceRecorderNew({
    Key? key,
    this.onRecordingComplete,
    this.primaryColor = PrimaryColor,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  State<VoiceRecorderNew> createState() => _VoiceRecorderNewState();
}

class _VoiceRecorderNewState extends State<VoiceRecorderNew> with SingleTickerProviderStateMixin {
  final AudioRecorder _recorder = AudioRecorder();
  Timer? _timer;
  int _countdown = 10;
  bool _isRecording = false;
  bool _isChecking = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  Future<void> _startRecording() async {
    setState(() => _isChecking = true);
    
    if (await _recorder.hasPermission()) {
      Directory appDir = await getApplicationDocumentsDirectory();
      final config = RecordConfig(
        encoder: AudioEncoder.aacLc,
        numChannels: 1,
        sampleRate: 16000,
      );

      await _recorder.start(config, path: '${appDir.path}/recording.aac');
      setState(() {
        _isChecking = false;
        _isRecording = true;
        _countdown = 10;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_countdown > 0) {
          setState(() => _countdown--);
        } else {
          _stopRecording();
        }
      });
    }
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    if (_isRecording) {
      final path = await _recorder.stop();
      setState(() => _isRecording = false);
      
      if (path != null && widget.onRecordingComplete != null) {
        widget.onRecordingComplete!(File(path));
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  margin: EdgeInsets.all(8),
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
                    if (_isChecking) ...[
                      Lottie.asset(
                        'assets/animations/Ani5.json', // Loading animation
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Checking for\n\nPlease wait',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ] else if (_isRecording) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Recording ${_countdown}s',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Lottie.asset(
                            'assets/animations/Ani7.json', // Sound wave animation
                            width: 250,
                            height: 250,
                          ),
                          // Container(
                          //   width: 40,
                          //   height: 40,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(8),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black.withOpacity(0.2),
                          //         blurRadius: 10,
                          //         spreadRadius: 2,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                       
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Listening...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Try to avoid background noise',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ] else ...[
                      Lottie.asset(
                        'assets/animations/Ani6.json', // Microphone animation
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 24),
                      // ElevatedButton.icon(
                      //   onPressed: _startRecording,
                      //   icon: Icon(Icons.mic),
                      //   label: Text(
                      //     'Start Recording',
                      //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.white,
                      //     foregroundColor: widget.primaryColor,
                      //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     elevation: 8,
                      //   ),
                      // ),
                      


                      ElevatedButton.icon(
  onPressed: _startRecording,
  icon: Icon(
    Icons.mic,
    size: 24,
    color: widget.primaryColor,
  ),
  label: Text(
    'Start Recording',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: widget.primaryColor,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: widget.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50), // Made more circular
    ),
    elevation: 4, // Reduced elevation for softer look
    shadowColor: widget.primaryColor.withOpacity(0.3), // Softer shadow
    side: BorderSide( // Added cute border
      color: widget.primaryColor.withOpacity(0.2),
      width: 2,
    ),
  ),
),
                   
                    ],
                  ],
                ),
              ),
              
              // Tips section
              if (_isRecording)
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    // backdropFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(Icons.tips_and_updates,
                            color: widget.primaryColor, size: 24),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'A cry with very short pauses for breath is likely caused by discomfort or pain',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}