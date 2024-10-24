import 'dart:convert';

import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/AppointmentController.dart';
import 'package:allobaby/Screens/Service/MyAppointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';

class Appointment extends StatelessWidget {
   Appointment({super.key});

AppointmentController cont = Get.put(AppointmentController());

final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment".tr),
      ),
              body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white38.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                       child: Theme(
                        data: ThemeData(
                          textTheme: const TextTheme(
                              titleMedium: TextStyle(color: PrimaryColor)),
                        ),
    child: 
    GetBuilder(
      init: AppointmentController(),

      builder: (controller) => 
      DropdownSearch<Hospital>(
      
      selectedItem: cont.hospital,
      
        popupProps: PopupProps.modalBottomSheet(
      modalBottomSheetProps: ModalBottomSheetProps(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      showSearchBox: true, 
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          title: Text(item.name),
          selected: isSelected,  // Highlight selected item
        );
      },
        ),
      
        dropdownBuilder: (context, selectedItem) {
      // Show the selected hospital in the dropdown
      return Text(selectedItem?.name ?? "Select Hospital");
        },
      
        // Label and decoration for the dropdown
        dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 3, color: Colors.grey),
        ),
        labelText: "Select Hospital".tr,
        labelStyle: const TextStyle(color: Colors.black),  // Ensure proper color reference
      ),
        ),
      
      
        items: controller.hospitals,
        onChanged: (value) {
      if (value != null) {
      
        
          controller.hospital = value;
      
         controller. fetchDoctors();
      }
        },
    )),
    ),

                          
                          ),
                    SizedBox(
                        height: 18,
                    ),
                 
                 
                 
                  Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white38.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                       child: Theme(
                        data: ThemeData(
                          textTheme: const TextTheme(
                              titleMedium: TextStyle(color: PrimaryColor)),
                        ),
                        child: 
                        
    GetBuilder<AppointmentController>(
      
      builder: (controller) =>  DropdownSearch<Hospital>(
      
      selectedItem: controller.doctor,
      
        popupProps: PopupProps.modalBottomSheet(
      modalBottomSheetProps: ModalBottomSheetProps(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      showSearchBox: true, 
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          title: Text(item.name),
          selected: isSelected,  // Highlight selected item
        );
      },
        ),
      
        dropdownBuilder: (context, selectedItem) {
      // Show the selected hospital in the dropdown
      return Text(selectedItem?.name ?? "Select Doctor");
        },
      
        // Label and decoration for the dropdown
        dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 3, color: Colors.grey),
        ),
        labelText: "Select Doctor".tr,
        labelStyle: const TextStyle(color: Colors.black),  // Ensure proper color reference
      ),
        ),
      
      
        items: controller.doctors,
        onChanged: (value) {
      if (value != null) {
          
            controller.doctor = value;

            controller.update();
          
      }
        },
      ),
    ),

                          
                          
                          )),
                    
                    
                    
                    SizedBox(
                        height: 18,
                      ),
                       GetBuilder<AppointmentController>(
                         builder: (controller) =>  TextFormField(
                                             controller: cont.dateController,
                                             
                                             decoration: InputDecoration(
                          // suffix: SizedBox(
                          //     height: 20,
                          //     width: 20,
                          //     child: true
                          //         ? CircularProgressIndicator()
                          //         : Container()),
                          labelText: "Appointment Date".tr,
                          border: OutlineInputBorder()),
                                             readOnly: true,
                                             onTap: () {
                                               showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                                               ).then((selectedDate) {
                         
                          if(selectedDate!=null){
                            print(selectedDate);
                            controller.selDate = selectedDate;
                         
                            controller.dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
                         
                            controller.update();
                            
                            controller.fetchTimeSlots(selectedDate);
                         
                          }
                                               });
                                             },
                                             validator: (value) {
                                               if (value == null || value.isEmpty) {
                          return 'Please select Appointment Date'.tr;
                                               }
                                               return null;
                                             },
                                           ),
                       ),
                   SizedBox(
                    height: 18,
                  ),
                   Visibility(
                    visible: true,
                    child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => 
                            
                            
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: SingleChildScrollView(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Available slots".tr,
                                        style:const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      )),
                                      const  SizedBox(
                                    height: 10,
                                  ),
                                   Center(
                                      child: GetBuilder<AppointmentController>(
                                        
                                        builder: (c) =>  Wrap(
                                                spacing: 10.0,
                                                children: 
                                        List.generate(
                                          c.timeslots.length,
                                          (index) => ChoiceChip(
                                            shadowColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)
                                            ),
                                            label: Text(
                                              "${c.timeslots[index].start} : ${c.timeslots[index].end}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black
                                              ),
                                            ),
                                            selectedColor: PrimaryColor,
                                            backgroundColor: White,
                                            selected: index == c.timeslotInd,
                                            onSelected: (value) {
                                              
                                                if (value) {
                                                  c.timeslotInd = index;
                                                } else {
                                                  c.timeslotInd = null; // Or any invalid ID to deselect
                                                }
                                              
                                              c.update();
                                            },
                                            labelStyle: TextStyle(color: White),
                                          ),
                                        )                             
                                                ),
                                      )),
                                
                                ],
                              )),
                            ),
                          
                          
                          );
                        
                        
                        },
                         child: Text(
                          "View Available Slots",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),

                  GetBuilder<AppointmentController>(
                    builder:(c) => 
                  c.timeslotInd !=null?
                  Wrap(
                    children: [
                      Text(
                        "Start time from selected time slot:".tr,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${c.timeslots[c.timeslotInd as int].start}-${c.timeslots[c.timeslotInd as int].end}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ):Container()
                  
                  )
                   ,

                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(

                    decoration: InputDecoration(
                        labelText: "Diagnosis Desc".tr,
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    controller: cont.descController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Diagnosis Desc'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                        Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.of(context).size.width / 2, 42),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40))),
                        onPressed: () {

                          


                          if(formKey.currentState!.validate() &&
                          cont.hospital!=null &&
                          cont.doctor !=null &&
                          cont.selDate !=null &&
                          cont.timeslotInd !=null &&
                          cont.descController.text!=""
                          
                          ) {

                          cont.addAppointment();

                          
                          }else{
                          Get.snackbar(
                                "All fields are mandatory to book appointment",
                                "error",
                                snackPosition: SnackPosition.BOTTOM
                                );

                          }
                        },
                        child: Text("Book".tr),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
}




