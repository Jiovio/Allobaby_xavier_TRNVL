import 'dart:convert';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Main/Home.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class InitialDetails extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return false
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(White),
                backgroundColor: PrimaryColor,
              ))
            : Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: 
                    
                    GetBuilder(
                      init: Signupcontroller(),
                      builder:(controller) => 
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              GestureDetector(
                                        onTap: () => {},
                                        //  showDialog(
                                        //   builder: (BuildContext context) =>
                                        //       Container(
                                        //     height: Get.height / 2,
                                        //     width: Get.width / 2,
                                        //     decoration: BoxDecoration(
                                        //         image: DecorationImage(
                                        //             image: controller
                                        //                         .fileImage64 ==
                                        //                     null
                                        //                 ? AssetImage(
                                        //                     "assets/General/avatar.png",
                                        //                   ) as ImageProvider
                                        //                 : MemoryImage(base64Decode(
                                        //                     controller
                                        //                         .fileImage64)))),
                                        //   ),
                                        //   context: context,
                                        // ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: 
                                          controller.profile_pic == null
                                              ? AssetImage(
                                                  "assets/General/avatar.png",
                                                )
                                              : NetworkImage(controller.profile_pic as String)
                                                  as ImageProvider,
                                          radius: 58,
                                        ),
                                      ),
                              SizedBox(
                                height: 38,
                                width: 38,
                                child: FloatingActionButton(
                                  heroTag: "image",
                                  elevation: 0,
                                  child: Icon(Icons.camera_alt_rounded,
                                      color: White),
                                  backgroundColor: PrimaryColor,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      builder: (BuildContext context) =>
                                          Container(
                                        padding: EdgeInsets.only(
                                            top: 18.0, bottom: 18.0),
                                        color: White,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Choose photo from :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            FloatingActionButton(
                                                elevation: 0,
                                                tooltip: "Camera",
                                                onPressed: () =>
                                                    controller
                                                        .getImageFromCamera(),
                                                backgroundColor:
                                                    Colors.amberAccent,
                                                child: Image.asset(
                                                  'assets/General/camera.png',
                                                  scale: 16,
                                                )),
                                            FloatingActionButton(
                                                elevation: 0,
                                                focusColor: Colors.greenAccent,
                                                tooltip: "Gallery",
                                                onPressed: () => 
                                                    controller
                                                        .getImageFromGallery(),
                                                backgroundColor:
                                                    Colors.indigoAccent,
                                                child: Image.asset(
                                                  'assets/General/gallery.png',
                                                  scale: 16,
                                                )),
                                          ],
                                        ),
                                      ),
                                      barrierColor:
                                          Colors.black12.withOpacity(0.5),
                                      context: context,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "User Name",
                                //   style: TextStyle(
                                //       color: PrimaryColor,
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w500),
                                // ),
                                // SizedBox(
                                //   height: 6,
                                // ),
                                // Text(
                                //   user!.email!.split('@')[0],
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 12,
                                // ),
                                // Text(
                                //   "Email id",
                                //   style: TextStyle(
                                //       color: PrimaryColor,
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w500),
                                // ),
                                SizedBox(
                                  height: 6,
                                ),
                                // Text(
                                //   (user!.email)!,
                                //   style: TextStyle(fontSize: 18),
                                // ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text('+91 ${controller.phone.text}',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Profile Details",
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 14.0,
                        ),
                        detailsForm(_formKey, controller, context),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            onPressed: () async {
                              // Get.to(MainScreen(),transition: Transition.rightToLeft);
                              if (_formKey.currentState!.validate()) {
                              controller.submitUser();
                                // initialDetailsController.fileImage64 == null
                                //     ? ScaffoldMessenger.of(context)
                                //         .showSnackBar(SnackBar(
                                //         content: Text('Pick Image'),
                                //       ))
                                //     :
                                // initialDetailsController.sendInitialDetails();
                              }
                            },
                            child: Text(("Finish").toUpperCase()),
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              );
  }
}

Form detailsForm(
  GlobalKey<FormState> formKey,
  // InitialDetailsController initialDetailsController,
  Signupcontroller initialDetailsController,
  BuildContext context,
) {
  return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: initialDetailsController.name,
            onTap: () {},
            decoration: InputDecoration(
                labelText: "Enter your Name", border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: initialDetailsController.emailID,
            onTap: () {},
            decoration: InputDecoration(
                labelText: "Enter Email Id", border: OutlineInputBorder()),

          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Flexible(
                child: DropdownSearch<String>(
                  validator: (v) => v == null ? "Please Select Gender" : null,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      label: Text("Gender"),
                      border: OutlineInputBorder()
                    )
                  ),
                  // mode: Mode.MENU,
                  // showSelectedItem: true,
                  items: ["Male", "Female"],
                  // label: "Gender",
                  // maxHeight: 120,
                  onChanged: (value) {
                    initialDetailsController.gender = value!;
                  },
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Flexible(
                child: TextFormField(
                  controller: initialDetailsController.age,
                  decoration: InputDecoration(
                      labelText: "Age", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            height: 60.0,
            child: DropdownSearch<String>(
              validator: (v) => v == null ? "Select Blood Group" : null,
              dropdownDecoratorProps:const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                      label: Text("Select Blood Group"),
                      border: OutlineInputBorder()
                    )),
                  
              items: BG,
    
              onChanged: (value) =>
                  initialDetailsController.bloodGroup = value!,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ));
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

List<String> BG = [
  "A+",
  "B+",
  "A-",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-",
  "A1+",
  "A1-"
];
