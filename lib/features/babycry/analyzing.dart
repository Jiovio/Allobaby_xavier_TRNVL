import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:allobaby/Config/Color.dart';

class AudioAnalysisPage extends StatefulWidget {
  final Color primaryColor;

  const AudioAnalysisPage({
    Key? key,
    this.primaryColor = PrimaryColor,
  }) : super(key: key);

  @override
  State<AudioAnalysisPage> createState() => _AudioAnalysisPageState();
}

class _AudioAnalysisPageState extends State<AudioAnalysisPage> with TickerProviderStateMixin {
  late AnimationController _progressController;
  int _currentStage = 0;
  bool _isAnalysisComplete = false;
  Timer? _stageTimer;

  final List<Map<String, dynamic>> _analysisStages = [
    {
      'title': 'Initializing Analysis',
      'subtitle': 'Preparing audio sample for deep processing...',
      'animation': 'assets/animations/init_analysis.json',
      'tips': [
        'Ensuring audio clarity',
        'Calibrating analysis parameters',
        'Preparing intelligent algorithms'
      ]
    },
    {
      'title': 'Audio Pattern Detection',
      'subtitle': 'Analyzing cry frequencies and nuances...',
      'animation': 'assets/animations/wave_analysis.json',
      'tips': [
        'Mapping sound waves',
        'Identifying unique cry characteristics',
        'Processing acoustic signals'
      ]
    },
    {
      'title': 'Pitch & Intensity Analysis',
      'subtitle': 'Evaluating emotional context of cry...',
      'animation': 'assets/animations/pitch_analysis.json',
      'tips': [
        'Measuring pitch variations',
        'Assessing cry intensity',
        'Decoding emotional indicators'
      ]
    },
    {
      'title': 'Pattern Matching',
      'subtitle': 'Correlating with known cry types...',
      'animation': 'assets/animations/pattern_match.json',
      'tips': [
        'Comparing with database',
        'Identifying cry signatures',
        'Machine learning correlation'
      ]
    },
    {
      'title': 'Generating Insights',
      'subtitle': 'Compiling comprehensive analysis...',
      'animation': 'assets/animations/results_gen.json',
      'tips': [
        'Synthesizing data points',
        'Generating actionable insights',
        'Preparing detailed report'
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 17),
    );
    _progressController.forward();
    _startAnalysis();
  }

  void _startAnalysis() {
    int totalDuration = 0;
    _stageTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        totalDuration++;
        
        if (totalDuration >= _getStageStartTime(_currentStage + 1)) {
          if (_currentStage < _analysisStages.length - 1) {
            setState(() {
              _currentStage++;
            });
          } else {
            _completeAnalysis();
            timer.cancel();
          }
        }
      }
    });
  }

  int _getStageStartTime(int stageIndex) {
    int totalTime = 0;
    for (int i = 0; i < stageIndex && i < _analysisStages.length; i++) {
      totalTime += _analysisStages[i]['duration'] as int;
    }
    return totalTime;
  }

  void _completeAnalysis() {
    setState(() {
      _isAnalysisComplete = true;
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _stageTimer?.cancel();
    super.dispose();
  }

  Widget _buildTipsScroller() {
    List<String> currentTips = _analysisStages[_currentStage]['tips'];

    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: currentTips.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.primaryColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                currentTips[index],
                style: TextStyle(
                  color: widget.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnalysisStage() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: Container(
        key: ValueKey(_currentStage),
        child: Column(
          children: [
            // Animation
            Container(
              height: 250,
              width: 250,
              child: Lottie.asset(
                "assets/animations/shareloading.json",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24),
            // Stage Title
            Text(
              _analysisStages[_currentStage]['title'],
              style: TextStyle(
                color: widget.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Stage Subtitle
            Text(
              _analysisStages[_currentStage]['subtitle'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            // Tips Scroller
            _buildTipsScroller(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.close, color: widget.primaryColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Analyzing Baby\'s Cry',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
              
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAnalysisStage(),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}