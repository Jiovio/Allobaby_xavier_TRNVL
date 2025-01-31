import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    "Predicting Recommendations"
  ];
  int currentIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // Animation controller for pulsing effect
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
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated loading circle
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + _animationController.value * 0.1,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue, // Primary color
                        width: 8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        backgroundColor: Colors.blue.shade100,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Animated loading text
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                loadingTexts[currentIndex],
                key: ValueKey<int>(currentIndex),
                style: TextStyle(
                  color: Colors.blue, // Primary color
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
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

            const SizedBox(height: 20),

            // Subtle progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: LinearProgressIndicator(
                backgroundColor: Colors.blue.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}