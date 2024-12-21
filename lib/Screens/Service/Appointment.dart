import 'dart:convert';

import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/AppointmentController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/symptoms.dart';
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
Maincontroller mainc = Get.put(Maincontroller());

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
    // GetBuilder(
    //   init: AppointmentController(),

    //   builder: (controller) => 
    //   DropdownSearch<Hospital>(
      
    //   selectedItem: cont.hospital,
      
    //     popupProps: PopupProps.modalBottomSheet(
    //   modalBottomSheetProps: ModalBottomSheetProps(
    //     shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
    //   ),
    //   showSearchBox: true, 
    //   itemBuilder: (context, item, isSelected) {
    //     return ListTile(
    //       title: Text(item.name),
    //       selected: isSelected,  // Highlight selected item
    //     );
    //   },
    //     ),
      
    //     dropdownBuilder: (context, selectedItem) {
    //   // Show the selected hospital in the dropdown
    //   return Text(selectedItem?.name ?? "Select Hospital");
    //     },
      
    //     // Label and decoration for the dropdown
    //     dropdownDecoratorProps: DropDownDecoratorProps(
    //   dropdownSearchDecoration: InputDecoration(
    //     border: OutlineInputBorder(),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(12)),
    //       borderSide: BorderSide(width: 3, color: Colors.grey),
    //     ),
    //     labelText: "Select Hospital".tr,
    //     labelStyle: const TextStyle(color: Colors.black),  // Ensure proper color reference
    //   ),
    //     ),
      
      
    //     items: controller.hospitals,
    //     onChanged: (value) {
    //   if (value != null) {
      
        
    //       controller.hospital = value;
      
    //      controller. fetchDoctors();
    //   }
    //     },
    // )),
    

    GetBuilder(
  init: AppointmentController(),
  builder: (controller) => 
  
  DropdownSearch<Hospital>(
    selectedItem: controller.hospital,
    popupProps: PopupProps.modalBottomSheet(
      modalBottomSheetProps: ModalBottomSheetProps(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: "Search hospital...",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          title: Text(
            item.name,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Theme.of(context).primaryColor : null,
            ),
          ),
          selected: isSelected,
          selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
        );
      },
      searchDelay: const Duration(milliseconds: 300),
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          "Select Hospital".tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    ),
    dropdownBuilder: (context, selectedItem) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          selectedItem?.name ?? "Select Hospital".tr,
          style: TextStyle(
            fontSize: 16,
            // color: selectedItem != null ? null : Theme.of(context).primaryColor.withOpacity(0.7),
          ),
        ),
      );
    },
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            // color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
        labelText: "Select Hospital".tr,
        labelStyle: TextStyle(
          // color: Theme.of(context).primaryColor,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
    items: controller.hospitals,
    onChanged: (value) {
      if (value != null) {
        controller.hospital = value;
        controller.fetchDoctors();
      }
    },
  ),

)
    
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
                        
    // GetBuilder<AppointmentController>(
    //   builder: (controller) =>  DropdownSearch<Hospital>(
    //   selectedItem: controller.doctor,
    //     popupProps: PopupProps.modalBottomSheet(
    //   modalBottomSheetProps: ModalBottomSheetProps(
    //     shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
    //   ),
    //   showSearchBox: true, 
    //   itemBuilder: (context, item, isSelected) {
    //     return ListTile(
    //       title: Text(item.name),
    //       selected: isSelected,  // Highlight selected item
    //     );
    //   },
    //     ),
    //     dropdownBuilder: (context, selectedItem) {
    //   return Text(selectedItem?.name ?? "Select Doctor");
    //     },
    //     dropdownDecoratorProps: DropDownDecoratorProps(
    //   dropdownSearchDecoration: InputDecoration(
    //     border:const OutlineInputBorder(),
    //     focusedBorder:const OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(12)),
    //       borderSide: BorderSide(width: 3, color: Colors.grey),
    //     ),
    //     labelText: "Select Doctor".tr,
    //     labelStyle: const TextStyle(color: Colors.black),  // Ensure proper color reference
    //   ),
    //     ),
    //     items: controller.doctors,
    //     onChanged: (value) {
    //   if (value != null) {
    //         controller.doctor = value;
    //         controller.update();
    //   }
    //     },
    //   ),
    // ),

GetBuilder<AppointmentController>(
  builder: (controller) => DropdownSearch<Hospital>(
    selectedItem: controller.doctor,
    popupProps: PopupProps.modalBottomSheet(
      modalBottomSheetProps: const ModalBottomSheetProps(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: "Search doctor...",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: PrimaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      itemBuilder: (context, item, isSelected) {
        return ListTile(
          title: Text(
            item.name,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          selectedTileColor: PrimaryColor.withOpacity(0.1),
        );
      },
      searchDelay: const Duration(milliseconds: 300),
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          "Select Doctor".tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    dropdownBuilder: (context, selectedItem) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          selectedItem?.name ?? "Select Doctor",
          style: const TextStyle(fontSize: 16),
        ),
      );
    },
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2, color: PrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          // borderSide: const BorderSide(color: Colors.grey),
        ),
        labelText: "Select Doctor".tr,
        // labelStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
    items: controller.doctors,
    onChanged: (value) {
      if (value != null) {
        controller.doctor = value;

        if(controller.selDate!=null){
        controller.fetchTimeSlots(controller.selDate);}

        controller.update();
      }
    },
  ),
)                          
                          
                          )),
                    
                    
                    
                    SizedBox(
                        height: 18,
                      ),
                       GetBuilder<AppointmentController>(
                         builder: (controller) =>  TextFormField(
                                             controller: cont.dateController,
                                             
                                             decoration: InputDecoration(
                          labelText: "Appointment Date".tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                          )),
                                             readOnly: true,
                                             onTap: () {
                                               showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days:60)),
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

                                            checkmarkColor: Colors.white,
                                            
                                            shadowColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)
                                            ),
                                            label: Text(
                                              "${c.timeslots[index].start} : ${c.timeslots[index].end}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: c.timeslotInd==index ? White : Black800
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

                                                Navigator.pop(context);
                                              
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
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             GetBuilder<AppointmentController>(
                               builder: (controller) =>  Text(
                                controller.timeslots.isEmpty? "No Slots Available".tr:"View Available Slots".tr,
                                style: TextStyle(fontSize: 18),
                                                       ),
                             ),



                  GetBuilder<AppointmentController>(
                    builder:(c) => 
                  c.timeslotInd !=null?
                  Column(
                    children: [
                     const SizedBox(height: 18,),

                      Wrap(
                        
                        children: [
                      
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                      
                            children: [
                              Text(
                                "Time Slot:    ".tr,
                                style:const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                      
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

                              decoration: BoxDecoration(
                            
                                border: Border.all(),
                              
                                borderRadius: BorderRadius.all( Radius.circular(20)),
                                
                              ),
                              child: Text(
                              "${c.timeslots[c.timeslotInd as int].start}-${c.timeslots[c.timeslotInd as int].end}",
                              style:const TextStyle(fontSize: 14,
                              fontWeight: FontWeight.bold,
                              ),
                             ),
                            ),
                            ],
                          ),
                      
                        ],
                      ),
                    ],
                  ):Container()
                  
                  ),

                           ],
                         )),
                  ),


                  SizedBox(height: 18,),



                  
                  TextFormField(
                  
                    decoration: InputDecoration(
                        labelText: "Add Your Symptoms".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          
                        )),
                    keyboardType: TextInputType.none,
                    controller: cont.symptoms,
                    onTap: () async {

                     await showModalBottomSheet(context: context, builder: (context) {
                        return Container(
                          
                          height: Get.height*0.35,
                          
                          child: symptoms(context));
                        
                      },);

                      cont.symptoms.text = mainc.bottomSheetData["symptoms"].join(" , ");
                      cont.update();
                  
                      
                  
                    },
                       
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select any Symptoms'.tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),

                  
                                    TextFormField(

                    decoration: InputDecoration(
                        labelText: "Diagnosis Description".tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                        )),
                    keyboardType: TextInputType.text,
                    controller: cont.descController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Diagnosis Description'.tr;
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

                      
                      GetBuilder<AppointmentController>(
                        builder: (controller) => 
                        controller.loading.value?Center(child: CircularProgressIndicator(),):
                         ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(MediaQuery.of(context).size.width / 2, 42),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          onPressed: () async {
                        
                            
                        
                        
                            if(formKey.currentState!.validate() &&
                            cont.hospital!=null &&
                            cont.doctor !=null &&
                            cont.selDate !=null &&
                            cont.timeslotInd !=null &&
                            cont.descController.text!=""
                            
                            )  {

                              controller.startLoading();
                             await cont.addAppointment();
                              controller.stopLoading();
                        

                        
                            
                            }else{
                            Get.snackbar(
                                  "All fields are mandatory to book appointment",
                                  "error",
                                  snackPosition: SnackPosition.BOTTOM
                                  );
                        
                            }
                          },
                          child: Text("Book".tr),
                        ),
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




