import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/features/appointment/appointment_selfscreening_loader.dart';
import 'package:allobaby/features/selfscreening/details_self_screening.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';

class Consultation extends StatelessWidget {
  dynamic data;
  Consultation({super.key, required this.data});

  Selfscreeningcontroller controller = Get.put(Selfscreeningcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "View Appointment",
          style: TextStyle(
            color: Black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: PrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Doctor Appointment Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: PrimaryColor.withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: PrimaryColor.withOpacity(0.12),
                              radius: 28,
                              child: Text(
                                data["doctor"]["name"].substring(0, 1),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: PrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. ${data["doctor"]["name"]}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Black,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Appointment Details",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(
                        thickness: 1,
                        color: PrimaryColor.withOpacity(0.1),
                      ),
                      SizedBox(height: 16),
                      _buildInfoRowWithIcon(
                        Icons.calendar_today_outlined, 
                        "Date", 
                        "${data["appointment_date"]}",
                        iconColor: PrimaryColor,
                      ),
                      SizedBox(height: 12),
                      _buildInfoRowWithIcon(
                        Icons.access_time_outlined, 
                        "Time", 
                        "${data["start_time"]}",
                        iconColor: PrimaryColor,
                      ),
                      SizedBox(height: 12),
                      _buildInfoRowWithIcon(
                        Icons.info_outline, 
                        "Status", 
                        "${data["status"]}",
                        iconColor: PrimaryColor,
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: PrimaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.medical_information_outlined,
                                  size: 20,
                                  color: PrimaryColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Diagnosis",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${data["reason"]}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[800],
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Self Screening Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.12),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: PrimaryColor.withOpacity(0.1),
                  onTap: () {

                      controller.appointmentid = data["id"];

                      Get.to(()=> AppointmentSelfscreeningLoader(id: data["id"]));

                     
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: PrimaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            "assets/labReports/symptoms.png",
                            width: 42,
                            height: 42,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Self Screening".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                "Add Symptoms and Vitals".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PrimaryColor.withOpacity(0.08),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: PrimaryColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Video Consultation Card
              Container(
                decoration: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: PrimaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.white.withOpacity(0.1),
                  onTap: () async {
                    await Permission.microphone.request();
                    await Permission.camera.request();

                    if (await Permission.camera.isGranted &&
                        await Permission.microphone.isGranted) {
                      print("Call Triggered");
                      print(data);
                      String myid = localStorage.getItem("uid")!;
                      await OurFirebase.createCall(
                          (data["doctor"]["uid"]).toString(), myid, "Patient");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            "assets/General/avatar.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Connect with Doctor".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Video Consultation".tr,
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.white.withOpacity(0.9),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.videocam_rounded,
                            color: PrimaryColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRowWithIcon(IconData icon, String label, String value, {Color? iconColor}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor ?? PrimaryColor,
        ),
        SizedBox(width: 12),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// This is a stub class for the SelfScreening page - no changes to functionality
class SelfScreening extends StatelessWidget {
  final String id;
  
  const SelfScreening({Key? key, required this.id}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Self Screening",
          style: TextStyle(
            color: Black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: PrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text("Self Screening Page for ID: $id"),
      ),
    );
  }
}