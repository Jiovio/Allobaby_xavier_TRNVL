import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Initial/AddressDetails.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';


// ignore: must_be_immutable
class LastCycleUI extends StatelessWidget {

  late DateTime startDate;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Select Last cycle Date",
                  style: TextStyle(
                      color: PrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    readOnly: true,
                    // controller: initialDetailsController.quarantineStartDate,
                    onTap: () {
                      // showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime.now().subtract(Duration(days: 305)),
                      //   lastDate: DateTime.now(),
                      // ).then((selectedDate) {
                      //   initialDetailsController.qStartDate =
                      //       selectedDate.toString();
                      //   initialDetailsController.qEndDate =
                      //       selectedDate!.add(Duration(days:280)).toString();
                      //   final localization = MaterialLocalizations.of(context);
                      //   startDate = selectedDate;
                      //   initialDetailsController.quarantineDueDate.text =
                      //       localization.formatShortDate(
                      //           startDate.add(Duration(days: 280)));
                      //   initialDetailsController.quarantineStartDate.text =
                      //       localization.formatShortDate(selectedDate);
                      // });
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
                SizedBox(
                  height: 20,
                ),
                TextField(
                  enabled: false,
                  // controller: initialDetailsController.quarantineDueDate,
                  decoration: InputDecoration(
                      labelText: "ED Date", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 60.0,
                //   child: DropdownSearch<String>(
                //     validator: (v) =>
                //         v == null ? "Select Family members" : null,
                //     // mode: Mode.MENU,
                //     // showSelectedItem: true,
                //     items: List<String>.generate(10, (i) => (i + 1).toString()),
                //     // label: "No of family members",
                //     onChanged: (value) {
                //       // initialDetailsController.noOfFamilyMember = value!;
                //     },
                //   ),
                // ),
                
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: OutlinedButton(
                          onPressed: () => Get.to(() => AddressDetails(),
                              transition: Transition.rightToLeft),
                          style: ElevatedButton.styleFrom(
                              side: BorderSide(color: PrimaryColor),
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                          child: Text(("Skip").toUpperCase()),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   data.write(
                            //       'Qstartdate',
                            //       initialDetailsController
                            //           .quarantineStartDate.text);
                            //   data.write(
                            //       'Qenddate',
                            //       initialDetailsController
                            //           .quarantineDueDate.text);
                            //   initialDetailsController.quarantineStatus =
                            //       "In Progress";
                              Get.to(() => AddressDetails(),
                                  transition: Transition.rightToLeft);
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: Text(("Continue").toUpperCase()),
                        ),
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
