import 'package:allobaby/Components/appbar.dart';
import 'package:allobaby/Screens/Service/Appointment.dart';
import 'package:allobaby/Screens/Service/HealthProfile.dart';
import 'package:allobaby/temp/CallView.dart';
import 'package:flutter/material.dart';
import 'package:allobaby/Config/Color.dart';

import 'package:get/get.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Services", context: context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          width: double.infinity,
          child: Column(children: [
             Image.asset(
              "assets/Services/customer.png",
              scale: 8,
            ),
                SizedBox(
              height: 20,
            ),
               Text(
              "As a companion in your pregnancy we help you with the following",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
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
                    onTap: () {
                      Get.to(() => Appointment(),
                          transition: Transition.rightToLeft);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ListTile(
                        leading: Image.asset(
                          "assets/Services/Appointment/medical_report.png",
                          scale: 6,
                        ),
                        title: Text(
                          "Book An Appointment",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_rounded, color: Black),
                      ),
                    ))),
                          SizedBox(
                            height: 14,
                          ),
                          Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Black)),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                    highlightColor: accentColor.withOpacity(0.1),
                    splashColor: accentColor.withOpacity(0.8),
                    onTap: () {
                      Get.to(()=>Healthprofile());

                    },
                    // onTap: () => Get.to(() => HealthProfileDetails(),
                    //     transition: Transition.rightToLeft),

                    // => mainScreenController
                    //             .patientDetails[0].quarantineStartDate !=
                    //         ""
                    //     ? Get.to(() => QuarantineMonitoring(),
                    //         transition: Transition.rightToLeft)
                    //     : Get.to(() => QuarantineRegister(),
                    //         transition: Transition.rightToLeft),
                     child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ListTile(
                        leading: Image.asset(
                          "assets/Services/ultrasound.png",
                          scale: 6,
                        ),
                        title: Text(
                          "Pregnancy Monitoring",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios_rounded, color: Black),
                      ),
                    ))),
                    SizedBox(
                    height: 14,
                  ),
                   Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Black)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  highlightColor: accentColor.withOpacity(0.1),
                  splashColor: accentColor.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/Services/technical-support.png",
                        scale: 12,
                      ),
                      title: Text(
                        "Help Line",
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Black,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Help Line"),
                        content: Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.call),
                              title: Text("105"),
                              onTap: () {
                                // _makePhoneCall("105");
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.call),
                              title: Text("0452 - 2851454"),
                              onTap: () {
                                // _makePhoneCall("04522851454");
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
                SizedBox(
                  height: 14,
                ),


                ElevatedButton(onPressed: (){
                  Get.to(Callview());
                }, child: Icon(Icons.abc))
          ]
          
          ),
       ),
      ),
  );
  }
}