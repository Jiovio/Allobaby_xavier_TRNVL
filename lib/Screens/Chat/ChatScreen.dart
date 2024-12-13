import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Components/appbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/ChatController.dart';
import 'package:allobaby/Screens/AI/allobotModal.dart';
import 'package:allobaby/Screens/Chat/Chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});


  Chatcontroller controller = Get.put(Chatcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Chat", context: context),

            body: Container(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        width: double.infinity,
        child: Column(children: [
          Image.asset(
            "assets/Chat/consultation.png",
            scale: 8,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Get Connected with doctors".tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Black)),
              child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  highlightColor: accentColor.withOpacity(0.1),
                  splashColor: accentColor.withOpacity(0.8),
                  onTap: () => 
                  controller.checkHospAndSend("doctor"),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/Chat/doctor.png",
                        scale: 12,
                      ),
                      title: Text(
                        "Connect with Doctor".tr,
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing:
                          Icon(Icons.arrow_forward_ios_rounded, color: Black),
                    ),
                  ))),
          SizedBox(
            height: 20,
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Black)),
              child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  highlightColor: accentColor.withOpacity(0.1),
                  splashColor: accentColor.withOpacity(0.8),
                  onTap: () =>
                controller.checkHospAndSend("healthworker"),

                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/Chat/nurse.png",
                        scale: 12,
                      ),
                      title: Text(
                        "Connect with Health worker".tr,
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Black,
                      ),
                    ),
                  ))),

                            SizedBox(
            height: 20,
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Black)),
              child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  highlightColor: accentColor.withOpacity(0.1),
                  splashColor: accentColor.withOpacity(0.8),
                  onTap: () => allobotModal(context),
                  // Get.to(() => Chat(title: "HealthWorker"),
                  //     transition: Transition.rightToLeft),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/Chat/chatbot.png",
                        scale: 12,
                      ),
                      title: Text(
                        "Connect with AlloBot".tr,
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Black,
                      ),
                    ),
                  ))),
        ]),
      ),
    
    );
  }
}