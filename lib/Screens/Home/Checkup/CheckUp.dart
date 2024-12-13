import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Checkup/CheckUpReport.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckUp extends StatelessWidget {
  const CheckUp({super.key});

  String getCheckupStatus(Map<String, dynamic> checkup) {
    if (checkup['doctorInputDate'] != null) {
      return "Checkup Completed".tr;
    } else if (checkup['symptoms'] != null && checkup['vitals'] != null) {
      return "Waiting for Doctor Feedback".tr;
    } else {
      return "Checkup need to be done".tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Checkup".tr)),
      body: FutureBuilder(
        future: Userapi.getCheckups(),
        builder: (context, dynamic snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final checkups = snapshot.data ?? [];

          if (checkups.isEmpty) {
            return  Center(child: Text("No Checkup Found".tr));
          }

          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 10,
            ),
            itemCount: checkups.length,
            itemBuilder: (BuildContext context, int index) {
              final checkup = checkups[index];
              final createdDate = DateTime.parse(checkup['createdDate']);
              

              return Card(
                elevation: 2,
                shape: Border(left: BorderSide(color: PrimaryColor, width: 4)),
                child: InkWell(
                  highlightColor: accentColor.withOpacity(0.1),
                  splashColor: accentColor.withOpacity(0.8),
                  onTap: () => Get.to(
                    () => CheckUpReport(data: checkup,),
                    transition: Transition.rightToLeft,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 20,
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Column(
                            children: <Widget>[
                              Text(
                                DateFormat.d().format(createdDate),
                                style: TextStyle(
                                  color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DateFormat.MMM().format(createdDate),
                                style: TextStyle(
                                  color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 28.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                               Text(
                                "Checkup Details".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                getCheckupStatus(checkup),
                                style: TextStyle(color: Black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}