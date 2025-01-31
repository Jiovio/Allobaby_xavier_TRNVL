import 'dart:async';
import 'dart:io';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Controller/BabyCry/babyCryController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:record/record.dart';

class Voicerecord extends StatefulWidget {
  const Voicerecord({super.key});

  @override
  State<Voicerecord> createState() => _VoicerecordState();
}

class _VoicerecordState extends State<Voicerecord> {

  final record = AudioRecorder();


  Timer? timer;
  Future check () async {

    

    if (await record.hasPermission()) {
      startRec();

}

  }

  // Maincontroller mc = Get.put(Maincontroller());

  bool rec = true;

  int c = 10;


      void startRec () async {
    // final stream = await record.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
Directory appDirectory = await getApplicationDocumentsDirectory();
    const encoder = AudioEncoder.aacLc;
  const config = RecordConfig(encoder: encoder, numChannels: 1);

   await record.start(config, path: '${appDirectory.path}/rec.aac');


    }

    Babycrycontroller controller = Get.put(Babycrycontroller());

    void stopRec () async {

      if(rec==false){

        return;
      }

      var file =  await record.stop();

      await record.dispose();

      if(rec){

           if(file!=null){
File audioFile = File(file);

print(await audioFile.length());
  controller.babydetect(audioFile);
     }

      }

      setState(() {
        rec=false;
      });
    }

  @override
  void initState() {
    // mc.toggleerec();
    check();

        c = 10;
      timer =   Timer.periodic(const Duration(seconds: 1),(timer){

          if(c>0){
          c--;
          setState(() {
            
          });

          }

          
        });



    // Schedule the function to run after 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      stopRec();

    });

    super.initState();
  }


  @override
  void dispose() {
    if(timer!=null)
    timer!.cancel();
    super.dispose();
  }
  
  // Widget loading = Column(
  //   children: [


  //   ],
  // );


  @override
  Widget build(BuildContext context) {
      return rec?Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,

    children: [

       Image.asset("assets/BottomSheet/voiceTrans.gif",height: 130,),
      
      SizedBox(height: 10,),

      Text("Baby Voice is Recording".tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,
      color: PrimaryColor),),


      SizedBox(height: 20,),

      Text("${c}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 28),),

      SizedBox(height: 20,),

      
        ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          // backgroundColor: PrimaryColor,
                          textStyle: TextStyle(color: White),
                        ),
                        onPressed: () {
                          rec=false;
                          setState(() {
                            
                          });

                          




                          // Navigator.pop(context);
          
                        },
                        child: Text("STOP".tr),
                      )
    ],
  ):Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,

    children: [

       Image.asset("assets/BottomSheet/voiceTrans.gif",height: 130,),
      SizedBox(height: 20,),
      Center(
        child: Text("Click the Record Button to Start Recording".tr,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,
        color: PrimaryColor),),
      ),
      
      SizedBox(
        height: 20,
      ),


        SizedBox(
          width: 150,
          child: ElevatedButton(
            
                          style: ElevatedButton.styleFrom(
                            
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // backgroundColor: PrimaryColor,
                            textStyle: TextStyle(color: White),
                          ),
                          onPressed: () {
                            rec=true;
                            c=10;
                            setState(() {
                              
                            });
                                Future.delayed(Duration(seconds: 10), () {
      stopRec();

    });
            
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Record".tr),
                              Icon(Icons.mic)
                            ],
                          ),
                        ),
        )
    ],
  );
  }
}

