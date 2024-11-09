import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Screens/AI/Allobot.dart';
import 'package:allobaby/Screens/Call/CallScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

class PickUpLayout extends StatelessWidget {
  final Widget scaffold;

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
            FlutterRingtonePlayer().playRingtone();

            return CallScreen(callerName: callData["callerName"],
            type: callData["type"],
            channel: callData["p1"],
            token: callData["token"],
            to : callData["p2"]
            );





          }else{
 FlutterRingtonePlayer().stop();
            
          }


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
