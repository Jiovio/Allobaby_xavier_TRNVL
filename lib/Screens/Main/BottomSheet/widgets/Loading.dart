import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// Optional: Additional UI utilities if needed
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  Timer? timer;
  List<String> loadingTexts = [
    "Analyzing Emotions", 
    "Correcting Audio", 
    "Predicting Recommendations",
    // You can add more descriptive loading texts here
    "Processing Baby's Feedback",
    "Fine-tuning Recommendations"
  ];
  int currentIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // Prevent screen rotation if desired
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Setup animation controller for pulsing effect
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    // Timer to cycle through loading texts
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % loadingTexts.length;
      });
    });
  }

  @override
  void dispose() {
    // Reset system orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lottie animation for a more dynamic loading indicator
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + _animationController.value * 0.1,
                    child: Lottie.asset(
                      'assets/loading_animation.json', // Add a cute loading animation
                      width: 250,
                      height: 250,
                      // Optional: fit options
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Animated text with subtle shadow and gentle bounce
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.blue.shade200,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Text(
                loadingTexts[currentIndex],
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Subtle progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                backgroundColor: Colors.blue.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}