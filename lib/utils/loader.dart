

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Loader {


  // static void start() {

  //   Get.showOverlay(asyncFunction:() {
      
  //   },
  //   loadingWidget: Dialog());
  // }


  static showLoader (){

    Get.showOverlay(
  asyncFunction: () async {
    return await Future.delayed(const Duration(seconds: 2));
  },
  loadingWidget: Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Custom animated loading indicator
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                Center(
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return CircularProgressIndicator(
                        value: null,
                        strokeWidth: 3,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue.withOpacity(value),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Icon(
                          Icons.sync,
                          color: Colors.blue,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Animated loading text
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: const Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
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