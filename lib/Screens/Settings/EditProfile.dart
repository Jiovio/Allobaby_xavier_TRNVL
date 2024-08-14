// import 'package:Allobaby/Config/Color.dart';
// import 'package:Allobaby/Screens/MainScreen/Controller/MainScreenController.dart';
// import 'package:Allobaby/Screens/Settings/Controller/SettingsController.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  // final user = FirebaseAuth.instance.currentUser;
  // final _formKey = GlobalKey<FormState>();
  // SettingsController settingsController = Get.put(SettingsController());
  // MainScreenController mainScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    // final localization = MaterialLocalizations.of(context);
    // settingsController.age.text =
    //     settingsController.patientDetails[0].age.toString();
    // settingsController.pinCode.text =
    //     settingsController.patientDetails[0].pinCode;
    // settingsController.gender.value =
    //     settingsController.patientDetails[0].gender;
    // settingsController.healthStatus.value =
    //     settingsController.patientDetails[0].healthStatus;
    // settingsController.quarantineStatus.value =
    //     settingsController.patientDetails[0].quarantineStatus;
    // settingsController.bloodGroup.value =
    //     settingsController.patientDetails[0].bloodGroup;
    // settingsController.address.text =
    //     settingsController.patientDetails[0].address;

    // settingsController.qStartDate =
    //     settingsController.patientDetails[0].quarantineStartDate == ""
    //         ? ""
    //         : settingsController.patientDetails[0].quarantineStartDate;
    // settingsController.qEndDate =
    //     settingsController.patientDetails[0].quarantineEndDate == ""
    //         ? ""
    //         : settingsController.patientDetails[0].quarantineEndDate;

    // settingsController.quarantineStartDate.text =
    //     settingsController.patientDetails[0].quarantineStartDate == ""
    //         ? ""
    //         : localization.formatShortDate(DateTime.parse(
    //             settingsController.patientDetails[0].quarantineStartDate));

    // settingsController.quarantineEndDate.text =
    //     settingsController.patientDetails[0].quarantineEndDate == ""
    //         ? ""
    //         : localization.formatShortDate(DateTime.parse(
    //             settingsController.patientDetails[0].quarantineEndDate));
    // settingsController.name.text = settingsController.patientDetails[0].name;
    // settingsController.parentType =
    //     settingsController.patientDetails[0].parentType!;
    // print(settingsController.parentType);
    // settingsController.partnerName.text =
    //     settingsController.patientDetails[0].partnerName!;
    // settingsController.partnerMobileNumber.text =
    //     settingsController.patientDetails[0].partnerMobileNumber!;
    // settingsController.fileImage64 =
    //     settingsController.patientDetails[0].imageUrl;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                // settingsController
                //     .updateProfile(mainScreenController.patientDetails[0].pid);
              })
        ],
      ),
      
      
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          // GetBuilder<SettingsController>(
                              // builder: (controller) => 
                              GestureDetector(
                                  onTap: () {},
                                  // onTap: () => showDialog(
                                  //       builder: (BuildContext context) =>
                                  //           Container(
                                  //               height: Get.height / 2,
                                  //               width: Get.width / 2,
                                  //               child: Image.memory(
                                  //                   base64Decode(controller
                                  //                       .fileImage64))),
                                  //       context: context,
                                  //     ),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 64.0,
                                      child: Image.asset(
                                          "assets/General/avatar.png")
                                      // MemoryImage(
                                      //   base64Decode(controller.fileImage64),
                                      // )
                                      )),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              heroTag: "image",
                              elevation: 0,
                              child:
                                  Icon(Icons.camera_alt_rounded, color: White),
                              backgroundColor: PrimaryColor,
                              onPressed: () {
                                // Get.bottomSheet(
                                //     Container(
                                //       padding: EdgeInsets.only(
                                //           top: 18.0, bottom: 18.0),
                                //       color: White,
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceEvenly,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.center,
                                //         children: [
                                //           Text(
                                //             "Choose photo from :",
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.w700,
                                //                 fontSize: 18),
                                //           ),
                                //           FloatingActionButton(
                                //               elevation: 0,
                                //               tooltip: "Camera",
                                //               onPressed: () =>
                                //                   settingsController
                                //                       .getImageFromCamera(),
                                //               backgroundColor:
                                //                   Colors.amberAccent,
                                //               child: Image.asset(
                                //                 'assets/camera.png',
                                //                 scale: 16,
                                //               )),
                                //           FloatingActionButton(
                                //               elevation: 0,
                                //               focusColor: Colors.greenAccent,
                                //               tooltip: "Gallery"
                                //                   "",
                                //               onPressed: () =>
                                //                   settingsController
                                //                       .getImageFromGallery(),
                                //               backgroundColor:
                                //                   Colors.indigoAccent,
                                //               child: Image.asset(
                                //                 'assets/General/gallery.png',
                                //                 scale: 16,
                                //               )),
                                //         ],
                                //       ),
                                //     ),
                                //     barrierColor:
                                //         Colors.black12.withOpacity(0.5));
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        " patientname@gmail.com",
                        // mainScreenController.patientDetails[0].emailId,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        " +91 90745 74893",
                        // mainScreenController.patientDetails[0].mobileNo,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  'General Details',
                  style: TextStyle(
                    fontSize: 18,
                    color: PrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  // controller: settingsController.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Name", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropdownSearch<String>(
                        validator: (v) =>
                            v == null ? "Please Select Gender" : null,
                            popupProps: PopupProps.menu(
                              showSelectedItems: true
                            ),

                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Gender",
                                border: OutlineInputBorder()
                              )
                            ),
                        // mode: Mode.MENU,
                        // showSelectedItem: true,
                        // selectedItem: settingsController.gender.value,
                        items: ["Male", "Female"],
                        // label: "Gender",
                        // maxHeight: 120,
                        // onChanged: (value) {
                        //   settingsController.gender.value = value!;
                        // },
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Flexible(
                      child: TextFormField(
                        // controller: settingsController.age,
                        decoration: InputDecoration(
                            labelText: "age", border: OutlineInputBorder()),
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
                    // mode: Mode.MENU,
                    // selectedItem: settingsController.bloodGroup.value,
                    // showSelectedItem: true,
                    items: BG,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText:  "Blood Group",
                                border: OutlineInputBorder()
                              )
                            ),
                    // label: "Blood Group",
                    onChanged: (value) {
                      // settingsController.bloodGroup.value = value!;
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                DropdownSearch<String>(
                  validator: (v) =>
                      v == null ? "Please Select Health Status" : null,
                  // mode: Mode.MENU,
                  // selectedItem: settingsController.healthStatus.value,
                  // showSelectedItem: true,
                  items: ["Normal", "Low", "High"],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText:  "Health Status",
                                border: OutlineInputBorder()
                              )
                            ),
                  // label: "Health Status",
                  // maxHeight: 160,
                  onChanged: (value) {
                    // settingsController.healthStatus.value = value!;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Partner Details',
                  style: TextStyle(
                    fontSize: 18,
                    color: PrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  // controller: settingsController.partnerName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Partner Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Partner Name", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  // controller: settingsController.partnerMobileNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Partner Mobile Number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Partner Mobile Number",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 16.0,
                ),
                DropdownSearch<String>(
                  validator: (v) =>
                      v == null ? "Please Select Parent Type" : null,
                  // mode: Mode.MENU,
                  // showSelectedItem: true,
                  // selectedItem: settingsController.parentType,
                  items: ["Dad", "Mom"],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText:  "Parent Type",
                                border: OutlineInputBorder()
                              )
                            ),
                  // label: "Parent Type",
                  // maxHeight: 160,
                  onChanged: (value) {
                    // settingsController.parentType = value!;
                    // settingsController.update();
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Pregnancy Details',
                  style: TextStyle(
                    fontSize: 18,
                    color: PrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Form(
                  // key: _formKey,
                  child: TextFormField(
                    readOnly: true,
                    // controller: settingsController.quarantineStartDate,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 305)),
                        lastDate: DateTime.now(),
                      ).then((selectedDate) {
                        // settingsController.qStartDate = selectedDate.toString();
                        // settingsController.qEndDate =
                            selectedDate!.add(Duration(days: 280)).toString();
                        final localization = MaterialLocalizations.of(context);
                        var startDate = selectedDate;
                        // settingsController.quarantineEndDate.text =
                            localization.formatShortDate(
                                startDate.add(Duration(days: 280)));
                        // settingsController.quarantineStartDate.text =
                            localization.formatShortDate(selectedDate);
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "LMP Date", border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter LMP Date';
                      }
                      return null;
                    },
                  ),
                ),
                // TextFormField(
                //   // readOnly: true,
                //   controller: settingsController.quarantineStartDate,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter LMP Date';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //       labelText: "LMP Date", border: OutlineInputBorder()),
                // ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  enabled: false,
                  // controller: settingsController.quarantineEndDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ED date';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "ED Date", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 12.0,
                ),
                DropdownSearch<String>(
                  validator: (v) =>
                      v == null ? "Please Select Pregnant Status" : null,
                  // mode: Mode.MENU,
                  // showSelectedItem: true,
                  // selectedItem: settingsController.quarantineStatus.value,
                  items: ["Not Pregnant", "Got Pregnant", "Baby Delivered"],
                  dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText:  "Status",
                                border: OutlineInputBorder()
                              )
                            ),
                  // label: "Status",
                  // maxHeight: 160,
                  onChanged: (value) {
                    // settingsController.quarantineStatus.value = value!;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Address Details',
                  style: TextStyle(
                    fontSize: 18,
                    color: PrimaryColor,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  // controller: settingsController.address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                      labelText: "Address", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextFormField(
                  // controller: settingsController.pinCode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pincode';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Pincode", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
