import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Screens/AI/Allobot.dart';
import 'package:allobaby/Screens/Call/CallScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PickUpLayout extends StatelessWidget {
  final Widget scaffold;
  final StopWatchTimer stopWatchTimer = StopWatchTimer(); 

  PickUpLayout({Key? key, required this.scaffold}) : super(key: key);


  Stream<DatabaseEvent> listenForCall() {
    final String userid = Storage.getUserID().toString();
    final String uid = "P$userid";

    DatabaseReference ref = FirebaseDatabase.instance.ref("calls/$uid");

    // Listen to real-time changes in the calls/$uid node
    return ref.onValue;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: listenForCall(),
      builder: (context, snapshot) {
        // If we have call data available
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          final dynamic callData = snapshot.data!.snapshot.value;

          if(callData!=null){

           if(callData["call"]){
            // FlutterRingtonePlayer().playRingtone(); // Play ringtone for video call
// FlutterRingtonePlayer().stop();
            return CallScreen(callerName: callData["callerName"],
            type: "Doctor",
            );


             // Play ringtone for video call



          }else{

            
          }


          }




          return scaffold;

          // If it's an incoming video call and the user hasn't dialed
          if (!callData['hasDialled'] && callData['callType'] == "video") {
            FlutterRingtonePlayer().playRingtone(); // Play ringtone for video call
            // return VideoPickupScreen(call: callData);
          } 
          // If it's an incoming voice call and the user hasn't dialed
          else if (!callData['hasDialled'] && callData['callType'] == "voice") {
            FlutterRingtonePlayer().playRingtone(); // Play ringtone for voice call
            // return VoicePickupScreen(call: callData);
          } 
          // If the call is outgoing or has been answered, show the normal UI
          else {
            // stopWatchTime .onExecute.add(StopWatchExecute.reset); // Reset stopwatch
            FlutterRingtonePlayer().stop(); // Stop the ringtone
            return scaffold;
          }

          return scaffold;
        } 
        // If no call data is available, return the default scaffold (normal UI)
        else {
          // stopWatchTimer.onExecute.add(StopWatchExecute.reset); // Reset stopwatch
          FlutterRingtonePlayer().stop(); // Stop the ringtone
          return scaffold;
        }
      },
    );
  }
}
