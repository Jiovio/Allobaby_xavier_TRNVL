

import 'package:allobaby/Screens/Call/CallScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  static CallController get instance => Get.find();
  
  final isCallActive = false.obs;
  
  void showCallScreen({
    required String callerName,
    required String type,
    required String channel,
    required String token,
    required String to,
  }) {

    if (!isCallActive.value) {
      isCallActive.value = true;
      

      
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: CallScreen(
            callerName: callerName,
            type: type,
            channel: channel,
            token: token,
            to: to,
          ),
        ),
        barrierDismissible: false,
        useSafeArea: true,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 200),
        navigatorKey: Get.key,
      );
    }
  }
  
  void endCall() {
    if (isCallActive.value) {
      isCallActive.value = false;
      FlutterRingtonePlayer().stop();
      Get.back();
    }
  }
}
