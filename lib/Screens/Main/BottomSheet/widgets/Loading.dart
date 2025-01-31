import 'dart:async';
import 'dart:math' as math;

import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  Timer? timer;
  List<String> loadingTexts = [
    "Analyzing Baby's Emotions", 
    "Tuning Audio Magic", 
    "Creating Cute Recommendations",
    "Preparing Adorable Insights",
    "Crafting Personalized Moments"
  ];
  int currentIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // Prevent screen rotation
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
    // Primary color with hex 0xffFF626F
    final Color primaryColor = Color(0xffFF626F);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withOpacity(0.1),
              primaryColor.withOpacity(0.2),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cute Lottie animation with pulsing effect
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + _animationController.value * 0.1,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                        ]
                      ),
                      child: Lottie.asset(
                        'assets/animations/Ani8.json',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Animated and adorable loading text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                loadingTexts[currentIndex],
                key: ValueKey<int>(currentIndex),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: primaryColor.withOpacity(0.3),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // Cute progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: LinearProgressIndicator(
                backgroundColor: primaryColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            // Cute additional text
            Text(
              "Almost there...",
              style: TextStyle(
                color: primaryColor.withOpacity(0.7),
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}