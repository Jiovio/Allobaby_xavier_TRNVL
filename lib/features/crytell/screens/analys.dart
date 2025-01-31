import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:allobaby/Config/Color.dart';

class AudioAnalysisPage extends StatefulWidget {
  final String audioPath;
  final Color primaryColor;
  final Function(Map<String, dynamic>)? onAnalysisComplete;

  const AudioAnalysisPage({
    Key? key,
    required this.audioPath,
    this.primaryColor = PrimaryColor,
    this.onAnalysisComplete,
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
      'subtitle': 'Preparing audio sample for processing...',
      'animation': 'assets/animations/init_analysis.json',
      'duration': 3,
    },
    {
      'title': 'Analyzing Audio Pattern',
      'subtitle': 'Detecting cry patterns and frequencies...',
      'animation': 'assets/animations/wave_analysis.json',
      'duration': 4,
    },
    {
      'title': 'Processing Pitch',
      'subtitle': 'Evaluating pitch variations and intensity...',
      'animation': 'assets/animations/pitch_analysis.json',
      'duration': 3,
    },
    {
      'title': 'Identifying Patterns',
      'subtitle': 'Matching patterns with known cry types...',
      'animation': 'assets/animations/pattern_match.json',
      'duration': 4,
    },
    {
      'title': 'Generating Results',
      'subtitle': 'Preparing detailed analysis report...',
      'animation': 'assets/animations/results_gen.json',
      'duration': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 17), // Total duration of all stages
    );
    _progressController.forward();
    _startAnalysis();
  }

  void _startAnalysis() {
    int totalDuration = 0;
    _stageTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        totalDuration++;
        int currentStageDuration = _analysisStages[_currentStage]['duration'] as int;
        
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
    
    // Simulate analysis results
    if (widget.onAnalysisComplete != null) {
      widget.onAnalysisComplete!({
        'cryType': 'Hunger Cry',
        'confidence': 0.89,
        'duration': '8.5 seconds',
        'intensity': 'Moderate',
        'recommendation': 'Baby might be hungry. Consider feeding if it\'s been 2-3 hours since the last feed.',
      });
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _stageTimer?.cancel();
    super.dispose();
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
                _analysisStages[_currentStage]['animation'],
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24),
            // Stage Title
            Text(
              _analysisStages[_currentStage]['title'],
              style: TextStyle(
                color: Colors.white,
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
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _progressController.value,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _analysisStages.length,
              (index) => Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index <= _currentStage
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionCard() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: widget.primaryColor,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'Analysis Complete!',
            style: TextStyle(
              color: widget.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap to view detailed results',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'View Results',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
              // Header
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Analyzing Baby\'s Cry',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 48), // For balance
                  ],
                ),
              ),
              
              Expanded(
                child: _isAnalysisComplete
                    ? Center(child: _buildCompletionCard())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildAnalysisStage(),
                          SizedBox(height: 48),
                          _buildProgressIndicator(),
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