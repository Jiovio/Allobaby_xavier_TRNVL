
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Call/CallView.dart';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatelessWidget {
  final String callerName;
  final String? imageUrl;

  final String type;

  final String channel;
  final String token;

  final String to;


  const CallScreen({
    Key? key,
    required this.callerName,
    this.imageUrl,
    required this.type,
    required this.channel,
    required this.token,
    required this.to
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      FlutterRingtonePlayer().playRingtone();



    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade800, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48.0),
                child: Column(
                  children: [
                    _buildCallerAvatar(),
                    const SizedBox(height: 24),
                    Text(
                      callerName,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 12,),

                     Text(
                      type,
                      style:const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                     Text(
                      'Incoming Call'.tr,
                      style:const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.call_end,
                      color: Colors.red.shade400,
                      onPressed: () async {
                       await OurFirebase.cutCall(to);
                       
                       FlutterRingtonePlayer().stop();
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.call,
                      color: Colors.green.shade400,
                      onPressed: () async {
                        await Permission.camera.request();
                        await Permission.microphone.request();


                        // Handle call acceptance
                        // Get.to(Callview(channel: channel, token: token,path: to,));
                       FlutterRingtonePlayer().stop();

                        Get.back();
                        Get.dialog(
                        Callview(channel: channel, token: token,path: to,)
                        );
                      },
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

  Widget _buildCallerAvatar() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackAvatar(),
              )
            : _buildFallbackAvatar(),
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Center(
      child: Text(
        callerName[0].toUpperCase(),
        style: const TextStyle(fontSize: 80, color: Colors.white),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
        backgroundColor: color,
        elevation: 8,
      ),
      child: Icon(icon, size: 40, color: Colors.white),
    );
  }
}