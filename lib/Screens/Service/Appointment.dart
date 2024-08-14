import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Service/MyAppointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
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
              // key: _formKey,
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
                        child: DropdownSearch<String>(
                          validator: (v) =>
                              v == null ? "Select Hospital".tr : null,
                          popupProps: PopupProps.modalBottomSheet(
                            modalBottomSheetProps: ModalBottomSheetProps(
                              shape:BeveledRectangleBorder(borderRadius: BorderRadius.zero)
                            ),
                            showSearchBox: true,
                            showSelectedItems: true,
                          ),
                          
                          // label: "Select Doctor",
                          items: ["JioVio", "Savemom"],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                             dropdownSearchDecoration:InputDecoration(
                              border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey),
                            ),
                            labelText: "Select Hospital".tr,
                            labelStyle: const TextStyle(color: Black),
                          )
                          )
                         ,
                          // maxHeight: Get.height * 0.15,
                          onChanged: (value) {
                            // controller.doctor = value;
                            // int index = controller.doctorsList.indexOf(value!);
                            // print(index);
                            // controller.doctorId =
                            //     controller.doctorsIDList[index];
                            // controller.update();
                          },
                        ),
                          )),
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
                        child: DropdownSearch<String>(
                          validator: (v) =>
                              v == null ? "Select Doctor".tr : null,
                          popupProps: PopupProps.modalBottomSheet(
                            modalBottomSheetProps: ModalBottomSheetProps(
                              shape:BeveledRectangleBorder(borderRadius: BorderRadius.zero)
                            ),
                            showSearchBox: true,
                            showSelectedItems: true,
                          ),
                          
                          // label: "Select Doctor",
                          items: ["Dr.Senthil kumar", "Dr.Savemom"],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                             dropdownSearchDecoration:InputDecoration(
                              border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.grey),
                            ),
                            labelText: "Select Doctor".tr,
                            labelStyle: const TextStyle(color: Black),
                          )
                          )
                         ,
                          // maxHeight: Get.height * 0.15,
                          onChanged: (value) {
                            // controller.doctor = value;
                            // int index = controller.doctorsList.indexOf(value!);
                            // print(index);
                            // controller.doctorId =
                            //     controller.doctorsIDList[index];
                            // controller.update();
                          },
                        ),
                          )),
                    
                    
                    
                    SizedBox(
                        height: 18,
                      ),
                       TextFormField(
                    // controller: controller.appointmentDate,
                    decoration: InputDecoration(
                        suffix: SizedBox(
                            height: 20,
                            width: 20,
                            child: true
                                ? CircularProgressIndicator()
                                : Container()),
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
                        // final localization = MaterialLocalizations.of(context);
                        // controller.appointmentDate.text =
                        //     DateFormat('dd-MM-yyyy')
                        //         .format(DateTime.parse(selectedDate.toString()))
                        //         .toString();

                        // controller.getDoctorTimeSlot(selectedDate, context);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Appointment Date'.tr;
                      }
                      return null;
                    },
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
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: SingleChildScrollView(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Available slots".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      )),
                                        SizedBox(
                                    height: 10,
                                  ),
                                   Center(
                                      child: Wrap(
                                              spacing: 10.0,
                                              children: List.generate(
                                                1,
                                                (slotIndex) => ChoiceChip(
                                                  shadowColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  label: Text(
                                                    "9:00 : 10:00",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  selectedColor: PrimaryColor,
                                                      // controller.indexTS ==
                                                      //         slotIndex
                                                      //     ? PrimaryColor
                                                      //     : Colors.white,
                                                  // ignore: unrelated_type_equality_checks
                                                  selected: true,
                                                  onSelected: (value) {
                                                    // controller.indexTS =
                                                    //     slotIndex;
                                                    // controller.timeSlotOne =
                                                    //     controller.timeSlotList[
                                                    //             slotIndex]
                                                    //         ['startTime'];
                                                    // controller.timeSlot =
                                                    //     "${controller.timeSlotList[slotIndex]['startTime']} : ${controller.timeSlotList[slotIndex]['endTime']}";
                                                    // controller.update();
                                                  },
                                                  labelStyle: TextStyle(
                                                      // ignore: unrelated_type_equality_checks
                                                      color: White),
                                                ),
                                              ))),
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
                   Wrap(
                    children: [
                      Text(
                        "Start time from selected time slot:".tr,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "9:00-9:30",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Diagnosis Desc".tr,
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                    // controller: controller.diagnostics,
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

                          Get.to(MyAppointment());
                          // if (_formKey.currentState!.validate() &&
                          //     controller.timeSlot != null &&
                          //     controller.timeSlotOne != null &&
                          //     controller.doctor != null &&
                          //     controller.hospital != null &&
                          //     controller.hospital != null &&
                          //     controller.doctorId != null) {
                          //   controller.addAppointment();
                          // } else {
                          //   showSnackBar(
                          //       "All fields are mandatory to book appointment",
                          //       "error");
                          // }
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
