
import 'dart:convert';

import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/EditprofileController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatelessWidget {

  EditProfile() {
  Get.lazyPut<Editprofilecontroller>(() => Editprofilecontroller());
  }

  @override
  Widget build(BuildContext context) {

      Editprofilecontroller mainc = Get.find<Editprofilecontroller>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile".tr),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {


                if(mainc.age.text.length>2){
                  showToast("Invalid Age , Please Enter Correct Age !",false);
                  return;
                }
              

               await mainc.updateProfile();
              })
        ],
      ),
      
      
      
      body: Obx(()=>
        mainc.loading.value?
        Scaffold(body: Center(child: CircularProgressIndicator(),),)

        : SingleChildScrollView(
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
           
                                GestureDetector(
                                    onTap: () {},
                                   
                                    child: 
                                    CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 64.0,
                                        child: GetBuilder<Editprofilecontroller>(
                                          builder: (controller) => 
                                          controller.profile_pic==null?
                                          Image.asset(
                                            
                                              "assets/General/avatar.png"):

                                              CachedNetworkImage(imageUrl: controller.profile_pic as String)
                                        )
                              
                                        )
                                        
                                        
                                        ),
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
                                  Get.bottomSheet(
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
                                                    mainc
                                                        .getImageFromCamera(context),
                                                backgroundColor:
                                                    Colors.amberAccent,
                                                child: Image.asset(
                                                  'assets/General/camera.png',
                                                  scale: 16,
                                                )),
                                            FloatingActionButton(
                                                elevation: 0,
                                                focusColor: Colors.greenAccent,
                                                tooltip: "Gallery"
                                                    "",
                                                onPressed: () =>
                                                    mainc
                                                        .getImageFromGallery(context),
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
                                          Colors.black12.withOpacity(0.5));
                                
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          mainc.email.text,
                          // mainScreenController.patientDetails[0].emailId,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          " +91 ${mainc.phoneNumber.text}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'General Details'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: PrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: mainc.name,
                    onChanged: (value) {
                      mainc.setUpdateData("name", value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Name".tr, border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: DropdownSearch<String>(
                          validator: (v) =>
                              v == null ? "Please Select Gender".tr : null,
                              popupProps:const PopupProps.menu(
                      constraints: BoxConstraints(maxHeight: 120),
                      showSelectedItems: true
                    ),
        
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "Gender".tr,
                                  border: OutlineInputBorder()
                                )
                              ),
               
                          items: ["Male", "Female"],
                          selectedItem: mainc.gender,
                          onChanged: (value) {
                            mainc.gender = value!;
                      mainc.setUpdateData("gender", value);

                          },
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: TextFormField(
                          maxLength: 2,
                          
                          onChanged: (value) => 
                      mainc.setUpdateData("age", int.parse(value))
                          ,
                          controller: mainc.age,
                          decoration: InputDecoration(
                            counterText: "",
                              labelText: "Age".tr, border: OutlineInputBorder()),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              
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
                      validator: (v) => v == null ? "Select Blood Group".tr : null,
                      selectedItem: mainc.bloodGroup,
                      items: BG,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText:  "Blood Group".tr,
                                  border:const OutlineInputBorder()
                                )
                              ),
                      onChanged: (value) {
                        mainc.bloodGroup = value!;

                      mainc.setUpdateData("blood_group", value);

                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  DropdownSearch<String>(
                    selectedItem: mainc.healthStatus,
                    items: const ["Normal", "Low", "High"],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText:  "Health Status".tr,
                                  border:const OutlineInputBorder()
                                )
                              ),

                    onChanged: (value) {
                      // settingsController.healthStatus.value = value!;
                      mainc.healthStatus = value;
                      mainc.setUpdateData("health_status", value);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Partner Details'.tr,
                    style:const TextStyle(
                      fontSize: 18,
                      color: PrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: mainc.partnerName,

                    onChanged: (value) => 
                      mainc.setUpdateData("partner_name", value)
                    ,
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Partner Name'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Partner Name".tr, border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: mainc.partnerPhone,
                    onChanged: (value) => 
                      mainc.setUpdateData("partner_phone", value)
                    ,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Partner Mobile Number'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Partner Mobile Number".tr,
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  DropdownSearch<String>(
                    enabled: false,
                    validator: (v) =>
                        v == null ? "Please Select Parent Type".tr : null,
                    // mode: Mode.MENU,
                    // showSelectedItem: true,
                    // selectedItem: settingsController.parentType,
                    selectedItem: mainc.gender=="Male"?"Mom":"Dad",
                    items:const ["Dad", "Mom"],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText:  "Parent Type".tr,
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
                    'Pregnancy Details'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: PrimaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),

                    GetBuilder<Editprofilecontroller>
                    (builder:(controller) {



                      return Column(
                        children: [





                                        SizedBox(
                    height: 12.0,
                  ),
                  DropdownSearch<String>(
                    
                    validator: (v) =>
                        v == null ? "Please Select Pregnant Status".tr : null,

                    selectedItem: mainc.pregnancyStatus,
                    items: mainc.pregnancyList,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText:  "Status".tr,
                                  border:const OutlineInputBorder(),

                                )
                              ),
                    popupProps: PopupProps.menu(
                      constraints: BoxConstraints(maxHeight: 200)
                    ),
                    onChanged: (value) {
                      controller.pregnancyStatus = value;
                      controller.setUpdateData("pregnancy_status",value);
                      controller.update();

                    },
                  ),

                  
                  SizedBox(
                    height: 12.0,
                  ),

                          if(controller.pregnancyStatus != controller.pregnancyList[2])
                      TextFormField(
                      readOnly: true,
                      controller: mainc.lmpDate,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(Duration(days: 305)),
                          lastDate: DateTime.now(),
                        ).then((selectedDate) {
                          

                          controller.setUpdateData("lmp_date", selectedDate!.toIso8601String());

                            DateTime endDate =  selectedDate.add(Duration(days: 280));

                            controller.lmpDate.text = DateFormat('dd-MM-yyyy').format(selectedDate);
                            controller.edDate.text = DateFormat('dd-MM-yyyy').format(endDate);


                          controller.setUpdateData("ed_date", endDate.toIso8601String());

                          controller.update();

                              
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "LMP Date".tr, border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter LMP Date'.tr;
                        }
                        return null;
                      },
                    ),
                  

                  if(controller.pregnancyStatus == controller.pregnancyList[1])
                  SizedBox(
                    height: 12.0,
                  ),
                  if(controller.pregnancyStatus == controller.pregnancyList[1])
                  TextFormField(
                    enabled: false,
                    controller: controller.edDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ED date'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "ED Date".tr, border: OutlineInputBorder()),
                  ),

                  if(controller.pregnancyStatus == controller.pregnancyList[0])
                  SizedBox(
                    height: 12.0,
                  ),
                  if(controller.pregnancyStatus == controller.pregnancyList[0])
                  TextFormField(
                    keyboardType: TextInputType.number,
                    
                    controller: controller.averageLengthOfCycles,
                    onChanged: (value) {
                      controller.setUpdateData("average_length_of_cycles", mainc.averageLengthOfCycles.text);
                      
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter between 28 to 41'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Average Length of Cycles".tr, border: OutlineInputBorder()),
                  ),

                  if(controller.pregnancyStatus == controller.pregnancyList[2])
                  SizedBox(
                    height: 12.0,
                  ),


                  if(controller.pregnancyStatus == controller.pregnancyList[2])
                                    TextFormField(
                    readOnly: true,
                    onTap: () {

                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      ).then((selectedDate) {

                        controller.deliveryDate.text = DateFormat('dd-MM-yyyy').format(selectedDate!);
                        controller.setUpdateData("delivery_date", selectedDate.toIso8601String());

                      });
                      
                    },
                    controller: controller.deliveryDate,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Delivery date'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Delivery Date".tr, border: OutlineInputBorder()),
                  ),


                        ],
                      );
                      
                    },),











    
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Address Details'.tr,
                    style: TextStyle(
                      fontSize: 18,
                      color: PrimaryColor,
                    ),
                  ),
                const  SizedBox(
                    height: 16.0,
                  ),
            
                 const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: mainc.doorNo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Door No'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Door No".tr, border: OutlineInputBorder()),

                    onChanged: (value) => 
                    mainc.setUpdateData("door_no",value),
                  ),


                 const SizedBox(
                    height: 12.0,
                  ),


                                 TextFormField(
                    controller: mainc.streetName,
                    onChanged: (value) {
                    mainc.setUpdateData("street_name",value);
                      
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Street name'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Street Name".tr, border: OutlineInputBorder()),
                  ),


                 const SizedBox(
                    height: 12.0,
                  ),


                                 TextFormField(
                                  onChanged: (value) => 
                                  mainc.setUpdateData("area",value),
                    controller: mainc.area,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Area'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Area".tr, border: OutlineInputBorder()),
                  ),


                 const SizedBox(
                    height: 12.0,
                  ),


                  TextFormField(
                    controller: mainc.pincode,
                    maxLength: 6,
                    onChanged: (value) => 
                    mainc.setUpdateData("pincode",value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pincode'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Pincode".tr, border: OutlineInputBorder()),
                  ),
                ],
              ),
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
