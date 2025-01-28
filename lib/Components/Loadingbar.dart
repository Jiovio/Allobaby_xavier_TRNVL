
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loadingbar {

  static void show(String? name){

        Get.dialog(
          barrierDismissible: false,
          Dialog(

          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(White),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: White.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.hourglass_bottom_rounded,
                              color: White,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  name ??'Loading...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
                ),
        );
  
  }
  



  static void use(String? name, Function fn){

        Get.showOverlay(
          asyncFunction: ()async{
            await fn();
          },
         loadingWidget:  Dialog(

          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 80,
                          width: 80,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(White),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: White.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.hourglass_bottom_rounded,
                              color: White,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 16),
                Text(
                  name ??'Loading...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
                ),
        );
  
  }
  
  
  





  static void close(){
    if (Get.isDialogOpen == true){
    Get.back();}
  }
  }
