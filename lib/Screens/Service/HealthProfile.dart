import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class Healthprofile extends StatelessWidget {
  const Healthprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Black100,
      appBar: AppBar(
        title: Text("Health Details"),
        actions: [
          Visibility(
                    visible: true,
                    //  controller.date == "Today" ? true : false,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          // backgroundColor: PrimaryColor,
                        ),
                        onPressed: () {
                          // healthProfileController.addDailyRoutineDetails(
                          //     _mainScreenController
                          //         .patientDetails[0].fireBaseID,
                          //     _mainScreenController.difference);
                        },
                        child: Text("Update")),
                  )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                    Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "13-07-24",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.calendar_today_outlined,
                                ),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now(),
                                  ).then((selectedDate) {
                                    final localization =
                                        MaterialLocalizations.of(context);
                                    if (localization
                                            .formatShortDate(selectedDate!) ==
                                        localization
                                            .formatShortDate(DateTime.now())) {
                                      // controller.HealthDate("Today");
                                    } else {
                                      // controller.getHealthDetailsDashboard(
                                      //     DateFormat('yyyy-MM-dd')
                                      //         .format(selectedDate));
                                      // controller.HealthDate(localization
                                      //     .formatShortDate(selectedDate));
                                    }
                                  });
                                }),
                       ],
                    ),
                    
                    
                    SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 36.0,
                    child: Image.asset("assets/General/avatar.png")),
                SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.double_arrow),
                            SizedBox(
                              height: 12,
                            ),
                                  Text(
                                      "280",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                            ),    SizedBox(
                              height: 8,
                            ),
                            Text("PDay",
                                style: TextStyle(
                                    color: Black.withOpacity(0.6),
                                    fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.double_arrow),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Good",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Health Status",
                                style: TextStyle(
                                    color: Black.withOpacity(0.6),
                                    fontSize: 14)),
                          ],
                        ),
                        Column(
                          children: [
                           // TextButton(
                             Icon(Icons.double_arrow),
                            // onPressed: (){
                            //   Get.to(SelfScreening()) ;
                            // },
                           // ),
                            SizedBox(
                              height: 12,
                            ),
                            Text("13-7-24",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Last Screened",
                                style: TextStyle(
                                    color: Black.withOpacity(0.6),
                                    fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                 Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "31",
                                style: TextStyle(fontSize: 26),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("May")
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "What's up today?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                              ],
                            ),
                          )
                        ],
                      )),
                ),
               SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                                child: AlertDialog(
                                  title: Text("Mood"),
                                  content: Center(
                                    heightFactor: 1,
                                    child: Container(
                                      width: double.maxFinite,
                                      
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                height: 110,
                                                child: ListView.separated(
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: emojiList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            emojis(index))
                                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      width: double.infinity,
                      
                      child: Column(
                        children: [
                          Text(
                            "Mood",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Black),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // GetBuilder<HealthProfileController>(
                          //     builder: (controller) =>
                              // controller
                              //             .risk_Selected ==
                              //         0
                              //     ? Container(
                              //         child: Text("None"),
                              //         height: 58,
                              //         width: 58) :
                              Image.asset(
                                      emojiList[0].emoji,
                                      height: 58,
                                      width: 58),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ), 
                 Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Exercise"),
                                  content: Container(
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                height: 80.0,
                                                child: 
                                                        ListView.separated(
                                                            separatorBuilder:
                                                                (BuildContext
                                                                            context,
                                                                        int
                                                                            index) =>
                                                                    SizedBox(
                                                                      width:
                                                                          10,
                                                                    ),
                                                            scrollDirection:
                                                                Axis
                                                                    .horizontal,
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                ExcersiseList.length,
                                                            itemBuilder: (BuildContext
                                                                        context,
                                                                    int index) =>
                                                                OutlinedButton(
                                                                    style: OutlinedButton.styleFrom(
                                                                        side: true ?
                                                                        // controller.exerciseSelected.contains(index) ? 
                                                                        BorderSide(color: PrimaryColor, width: 1.5) : null,
                                                                        padding: EdgeInsets.all(14),
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                                                    onPressed: () {
                                                                      // controller.ExerciseSelect(indexx: index);
                                                                      
                                                                      },
                                                                    child: ExcersiseList[index] == "none" ? Center(child: Text("None")) : Image.asset(ExcersiseList[index], height: 64, width: 64)))),
                                          )
                                        ],
                                      )),
                                ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exercise",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Black),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Black,
                                  size: 18,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            // GetBuilder<HealthProfileController>(
                            //     builder: (controller) =>
                             Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text( 
                                              // controller.exerciseSelected.length == 1 ? controller.exerciseSelected[0] == 0 ?
                                              //   "0/8":
                                              //   "${controller.exerciseSelected.length}/8":"${controller.exerciseSelected.length}/8" ,
                                              "0/8",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: PrimaryColor)),
                                            Text("Achieved",
                                                style: TextStyle(
                                                    color: PrimaryColor)),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                              height: 28.0,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount: 1,
                                                  
                                                  // controller
                                                  //     .exerciseSelected.length,
                                                  itemBuilder: (BuildContext
                                                              context,
                                                          int index) => true
                                                      // controller.exerciseSelected[index] ==
                                                              // 0
                                                          ? Container(
                                                              child:
                                                                  Text("None"),
                                                              height: 58,
                                                              width: 58)
                                                          : Image.asset(
                                                              emojiListImages[1],
                                                              
                                                              
                                                              // [controller.exerciseSelected[index]],
                                                              height: 38,
                                                              width: 38))),
                                        )
                                      ],
                                    )
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Glass of water"),
                                content: Center(
                                  heightFactor: 1,
                                  child: Container(
                                      width: double.maxFinite,
                                      child:
                                        Wrap(
                                          children: [
                                            Container(
                                                height: 38.0,
                                                child: Center(
                                                  child: ListView.separated(
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: 1,



                                                          // glassController.glass,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              Container(
                                                                height: 24,
                                                                width: 24,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/BottomSheet/glass-of-water.png',
                                                                ),
                                                              )),
                                                )),
                                            Slider(
                                              value: 1,
                                              
                                              // glassController.glass
                                              //     .toDouble(),
                                              onChanged: (value) {
                                                // glassController
                                                //     .glassCount(value.toInt());
                                              },
                                              min: 0,
                                              max: 8,
                                              divisions: 8,
                                            ),
                                          ],
                                        )
                                      ),
                                ),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Glass of water",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                              Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text("${controller.glass}/8",
                                          Text("2/8",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: PrimaryColor)),
                                          Text("Achieved",
                                              style: TextStyle(
                                                  color: PrimaryColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 28.0,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                // controller.glass,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int index) =>
                                                    Image.asset(
                                                        "assets/BottomSheet/glass-of-water.png",
                                                        height: 38,
                                                        width: 38))),
                                      )
                                    ],
                                  )
                        ],
                      ),
                    ),
                  ),
                ),
                   SizedBox(
                  height: 8,
                ),
                               Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Medicine"),
                                content: Center(
                                  heightFactor: 1,
                                  child: Container(
                                      width: double.maxFinite,
                                      child:

                                          Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                            height: 80.0,
                                                            child: ListView
                                                                .separated(
                                                                    separatorBuilder: (BuildContext
                                                                                context,
                                                                            int
                                                                                index) =>
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        
                                                                        
                                                                        medicineList
                                                                            .length,
                                                                    itemBuilder: (BuildContext
                                                                                context,
                                                                            int
                                                                                index) =>
                                                                        medicineListView(
                                                                            index,"")
                                                                            )),
                                                      ),
                                                    ],
                                                  )),
                                ),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Medicine",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // GetBuilder<HealthProfileController>()
                          //     builder: (controller) => 
                          Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              // controller.medicineSelected."${length}/4",
                                              "2/4",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: PrimaryColor)),
                                          Text("Achieved",
                                              style: TextStyle(
                                                  color: PrimaryColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 28.0,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                
                                                // controller
                                                //     .medicineSelected.length,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int index) =>
                                                    Image.asset(
                                                        medicineList[0]
                                                            .medicine,
                                                        height: 38,
                                                        width: 38))),
                                      )
                                    ],
                                  )
                        ],
                      ),
                    ),
                  ),
                ),
                 SizedBox(
                  height: 8,
                ),              
                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      final _formKey = GlobalKey<FormState>();
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Sleep Duration"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Form(
                                        key: _formKey,
                                        child: Wrap(
                                          spacing: 4,
                                          children: [
                                            TextFormField(
                                              readOnly: true,
                                              // controller: 
                                                  // healthProfileController
                                                  //     .bedTime,
                                              onTap: () {
                                                // showTimePicker(
                                                //         context: context,
                                                //         initialTime:
                                                //             TimeOfDay.now())
                                                //     .then((selectedTime) {
                                                //   final localization =
                                                //       MaterialLocalizations.of(
                                                //           context);
                                                //   _healthProfileController
                                                //           .bedTime.text =
                                                //       localization
                                                //           .formatTimeOfDay(
                                                //               selectedTime!);
                                                // });
                                                pickDateTime(
                                                    context,
                                                    // healthProfileController,
                                                    "Healthprofile",
                                                    "bed",
                                                    "2");
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Bed Time",
                                                  border: OutlineInputBorder()),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Bed Time';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            TextFormField(
                                              readOnly: true,
                                              // controller:
                                              //     healthProfileController
                                              //         .wakeUpTime,
                                              onTap: () {
                                                // showTimePicker(
                                                //         context: context,
                                                //         initialTime:
                                                //             TimeOfDay.now())
                                                //     .then((selectedTime) {
                                                //   final localization =
                                                //       MaterialLocalizations.of(
                                                //           context);
                                                //   _healthProfileController
                                                //           .wakeUpTime.text =
                                                //       localization
                                                //           .formatTimeOfDay(
                                                //               selectedTime!);
                                                // });
                                                pickDateTime(
                                                    context,
                                                    // healthProfileController,
                                                    "Healthprofile",
                                                    "wake",
                                                    "1");
                                              },
                                              decoration: InputDecoration(
                                                  labelText: "Wake Up Time",
                                                  border: OutlineInputBorder()),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter Wake Up Time';
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ))),
                                actions: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel")),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      onPressed: () {
                                        // if (_formKey.currentState!.validate()) {
                                        //   healthProfileController
                                        //       .SleepDurationHrs();
                                        Navigator.pop(context);
                                        // }
                                      },
                                      child: Text("Update"))
                                ],
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sleep Duration",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "hello",
                              // healthProfileController.sleepDuration.value,
                              style: TextStyle(
                                  fontSize: 18, color: PrimaryColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                 SizedBox(
                  height: 8,
                ),               
                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Symptoms"),
                                content: Container(
                                    width: double.maxFinite,
                                    child:
                                    // GetBuilder<HealthProfileController>(
                                    //     builder: (controller) => 
                                        Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  height: 110.0,
                                                  child:
                                                      // GetBuilder<
                                                      //         HealthProfileController>(
                                                      //     builder: (controller) => 
                                                          
                                                          ListView
                                                              .separated(
                                                                  separatorBuilder:
                                                                      (BuildContext context, int index) =>
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                  scrollDirection: Axis
                                                                      .horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: symptomsList
                                                                      .length,
                                                                  itemBuilder: (BuildContext
                                                                              context,
                                                                          int
                                                                              index) =>
                                                                      OutlinedButton(
                                                                          style:
                                                                              OutlinedButton.styleFrom(
                                                                            side: true
                                                                            
                                                                            // controller.symptomsSelected.contains(index)
                                                                                ? BorderSide(color: PrimaryColor, width: 1.5)
                                                                                : null,
                                                                            padding:
                                                                                EdgeInsets.all(14),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                          onPressed: () {}, 
                                                                          
                                                                          // controller.SymptomSelect(index, symptomsList[index].title),
                                                                          child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  color: true
                                                                                  
                                                                                  // controller.symptomsSelected.contains(index)
                                                                                  
                                                                                   ? PrimaryColor : Colors.grey,
                                                                                ),
                                                                                child: Image.asset(symptomsList[index].image, height: 48, width: 48, color: Colors.white),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 8,
                                                                              ),
                                                                              Text(
                                                                                symptomsList[index].title,
                                                                                style: TextStyle(color: true
                                                                                
                                                                                
                                                                                // controller.symptomsSelected.contains(index) 
                                                                                ? 
                                                                                
                                                                                PrimaryColor : Black),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ],
                                                                          ))),
                                                )),
                                              ],
                                            )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Symptoms",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // GetBuilder<HealthProfileController>(
                          //     builder: (controller) => 
                              
                              
                              Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "2/6",
                                              //  "${controller.symptomsSelected.length}/6",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: PrimaryColor)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                            height: 28.0,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                
                                                // controller
                                                //     .symptomsSelected.length,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int index) =>
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40)),
                                                      child: Image.asset(
                                                          symptomsList[0]
                                                              .image,
                                                          color: Colors.white,
                                                          height: 38,
                                                          width: 38),
                                                    ))),
                                      )
                                    ],
                                  )
                        ],
                      ),
                    ),
                  ),
                ),


                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Blood Pressure"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        NumberPicker(
                                              value: 15,
                                              minValue: 0,
                                              maxValue: 140,
                                              itemHeight: 32,
                                              onChanged: (value) {
                                                // healthProfileController
                                                //     .bloodPressureH
                                                //     .value = value;
                                              },
                                            ),
                                        Text("/"),
                                        NumberPicker(
                                              value: 10,
                                              minValue: 0,
                                              maxValue: 220,
                                              itemHeight: 32,
                                              onChanged: (value) {
                                                // healthProfileController
                                                //     .bloodPressureL
                                                //     .value = value;
                                              },
                                            ),
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Pressure",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    // "${healthProfileController.bloodPressureH.value}/${healthProfileController.bloodPressureL.value}",
                                    "10 / 10",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " mmHg",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                
                SizedBox(
                  height: 8,
                ),


                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Blood Glucose"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Text("mg/dL"),
                                        //     ValueBuilder<bool?>(
                                        //       initialValue: false,
                                        //       builder: (isChecked, updateFn) =>
                                        //           Switch(
                                        //         activeColor: PrimaryColor,
                                        //         value: isChecked!,
                                        //         onChanged: (newValue) {
                                        //           updateFn(newValue);
                                        //         },
                                        //       ),
                                        //     ),
                                        //     Text("mmol/L"),
                                        //   ],
                                        // ),
                                        Text("Fasting"),
                                        Row(
                                          children: [
                                            DecimalNumberPicker(
                                                  value: 20,
                                                  minValue: 0,
                                                  maxValue: 700,
                                                  decimalPlaces: 1,
                                                  onChanged: (value) {
                                                    // healthProfileController
                                                    //     .bloodGlucoseBF
                                                    //     .value = value;
                                                  },
                                                ),
                                            Flexible(child: Text("mg/dl"))
                                          ],
                                        ),
                                        Text("pp"),
                                        Row(
                                          children: [
                                            DecimalNumberPicker(
                                                  value: 20,
                                                  minValue: 0,
                                                  maxValue: 700,
                                                  decimalPlaces: 1,
                                                  onChanged: (value) {
                                                    // healthProfileController
                                                    //     .bloodGlucoseAF
                                                    //     .value = value;
                                                  },
                                                ),
                                            Flexible(child: Text("mg/dl"))
                                          ],
                                        ),
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Glucose",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                             Text(
                                    // "${healthProfileController.bloodGlucoseBF.value} f /${healthProfileController.bloodGlucoseAF.value} pp",
                                    "50 f / 50 pp",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " mg/dl",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                

                SizedBox(
                  height: 8,
                ),

                                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Blood Saturation"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        Text("At rest"),
                                        Row(
                                          children: [
                                            DecimalNumberPicker(
                                                  value:20,
                                                  minValue: 0,
                                                  itemHeight: 32,
                                                  maxValue: 100,
                                                  decimalPlaces: 1,
                                                  onChanged: (value) {
                                                    // healthProfileController
                                                    //     .bloodSaturationBW
                                                    //     .value = value;
                                                  },
                                                ),
                                            Flexible(child: Text("%"))
                                          ],
                                        ),
                                        Text("After Walk"),
                                        Row(
                                          children: [
                                            DecimalNumberPicker(
                                                  value: 10,
                                                  minValue: 0,
                                                  maxValue: 100,
                                                  itemHeight: 32,
                                                  decimalPlaces: 1,
                                                  onChanged: (value) {
                                                    // healthProfileController
                                                    //     .bloodSaturationAW
                                                    //     .value = value;
                                                  },
                                                ),
                                            Flexible(child: Text("%"))
                                          ],
                                        ),
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Blood Saturation",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "96/80",
                                    // "${healthProfileController.bloodSaturationBW.value}/${healthProfileController.bloodSaturationAW.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " %",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),


                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Temperature"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Wrap(
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Text("C"),
                                        //     ValueBuilder<bool?>(
                                        //       initialValue: false,
                                        //       builder: (isChecked, updateFn) =>
                                        //           Switch(
                                        //         activeColor: PrimaryColor,
                                        //         value: isChecked!,
                                        //         onChanged: (newValue) {
                                        //           updateFn(newValue);
                                        //         },
                                        //       ),
                                        //     ),
                                        //     Text("F"),
                                        //   ],
                                        // ),
                                        DecimalNumberPicker(
                                              value: 40,
                                              minValue: 0,
                                              maxValue: 44,
                                              decimalPlaces: 1,
                                              onChanged: (value) {
                                                // healthProfileController
                                                //     .temperature.value = value;
                                              },
                                            ),
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Temperature",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${90}",
                                    // "${healthProfileController.temperature.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " °C",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Weight"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                      DecimalNumberPicker(
                                            minValue: 0,
                                            maxValue: 200,
                                            value: 40,
                                            decimalPlaces: 1,
                                            onChanged: (value) {
                                              // healthProfileController
                                              //     .bmiWeight.value = value;
                                              // healthProfileController
                                              //         .bmi.value =
                                              //     double.parse((healthProfileController
                                              //                 .bmiWeight.value /
                                              //             pow(
                                              //                 healthProfileController
                                              //                         .bmiHeight
                                              //                         .value /
                                              //                     100,
                                              //                 2))
                                              //         .toStringAsFixed(1));
                                            })
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Weight",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${40}",
                                    // "${healthProfileController.bmiWeight.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " kg",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Height"),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                            NumberPicker(
                                            minValue: 50,
                                            maxValue: 230,
                                            value: 60,
                                            onChanged: (value) {
                                              // healthProfileController
                                              //     .bmiHeight.value = value;
                                              // healthProfileController
                                              //         .bmi.value =
                                              //     double.parse((healthProfileController
                                              //                 .bmiWeight.value /
                                              //             pow(
                                              //                 healthProfileController
                                              //                         .bmiHeight
                                              //                         .value /
                                              //                     100,
                                              //                 2))
                                              //         .toStringAsFixed(1));
                                            })
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BMI",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${60}",
                                    // "${healthProfileController.bmi}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " BPM",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Heart Rate",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Black),
                                ),
                                content: Container(
                                    width: double.maxFinite,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: [
                                        Text("At rest"),
                                        Row(
                                          children: [
                                           NumberPicker(
                                                  value: 66,
                                                  minValue: 0,
                                                  itemHeight: 32,
                                                  maxValue: 150,
                                                  onChanged: (value) {
                                                    // healthProfileController
                                                    //     .heartRateBW
                                                    //     .value = value;
                                                  },
                                                ),
                                            Flexible(child: Text("BPM"))
                                          ],
                                        ),
                                        Text("After walk"),
                                        Row(
                                          children: [
                                            NumberPicker(
                                                  value: 50,
                                                  minValue: 0,
                                                  maxValue: 150,
                                                  itemHeight: 32,
                                                  onChanged: (value) {
                                                    // healthProfileController
                                                    //     .heartRateAW
                                                    //     .value = value;
                                                  },
                                                ),
                                            Flexible(child: Text("BPM"))
                                          ],
                                        ),
                                      ],
                                    )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Heart Rate",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "66 / 99",
                                    // "${healthProfileController.heartRateBW.value}/${healthProfileController.heartRateAW.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " BPM",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Respiratory Rate",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Black),
                                ),
                                content: Container(
                                    width: double.maxFinite,
                                    child: NumberPicker(
                                          value: 30,
                                          minValue: 0,
                                          maxValue: 40,
                                          onChanged: (value) {
                                            // healthProfileController
                                            //     .respiratoryRate.value = value;
                                          },
                                        )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Respiratory Rate",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                             Text(
                                    "${66}",
                                    // "${healthProfileController.respiratoryRate.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " beats per minute",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "HRV",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Black),
                                ),
                                content: Container(
                                    width: double.maxFinite,
                                    child: NumberPicker(
                                          value:
                                              100,
                                          minValue: 0,
                                          maxValue: 300,
                                          onChanged: (value) {
                                            // healthProfileController.hrv.value =
                                            //     value;
                                          },
                                        )),
                              ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HRV",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Black),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Black,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Text(
                                    "${50}",
                                    // "${healthProfileController.hrv.value}",

                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                              Text(
                                " MS",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              




              ]
          )                    
    )))
    );
  }
}


 emojis(int index) {
  return TextButton(
          style: TextButton.styleFrom(
              // shape: 
              // (controller.risk_Selected == index)
              //     ? RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //         side: BorderSide(color: PrimaryColor, width: 1.5))
              //     : null,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          onPressed: () {},
          // controller.riskSelected(index),
          child: Column(
            children: [
              emojiList[index].title == "none"
                  ? Center(child: Text("None"))
                  : Image.asset(emojiList[index].emoji, height: 58, width: 58),
              SizedBox(
                height: 10,
              ),
              Text(
                emojiList[index].title,
                style: TextStyle(
                    color: Black
                    // controller.risk_Selected == index
                    //     ? PrimaryColor
                    //     : Black
                        ),
              ),
            ],
          ));
}

List<Emojis> emojiList = [
  // Emojis(title: 'none', emoji: ''),
  Emojis(title: 'Good', emoji: 'assets/BottomSheet/Emojis/good.png'),
  Emojis(title: 'Happy', emoji: 'assets/BottomSheet/Emojis/happy.png'),
  Emojis(title: 'Cool', emoji: 'assets/BottomSheet/Emojis/cool.png'),
  Emojis(title: 'Smile', emoji: 'assets/BottomSheet/Emojis/smile.png'),
  Emojis(title: 'Angry', emoji: 'assets/BottomSheet/Emojis/angry.png')
];

class Emojis {
  String title;
  String emoji;
  Emojis({required this.title, required this.emoji});
}

List ExcersiseList = [
  'none',
  'assets/BottomSheet/Yoga/yoga.png',
  'assets/BottomSheet/Yoga/head.png',
  'assets/BottomSheet/Yoga/extended.png',
  'assets/BottomSheet/Yoga/corpse.png',
  'assets/BottomSheet/Yoga/cobra.png',
  'assets/BottomSheet/Yoga/chair.png',
  'assets/BottomSheet/Yoga/awkward.png',
  'assets/BottomSheet/Yoga/fish.png',
];

List emojiListImages = [
  '',
  'assets/BottomSheet/Yoga/yoga.png',
  'assets/BottomSheet/Yoga/head.png',
  'assets/BottomSheet/Yoga/extended.png',
  'assets/BottomSheet/Yoga/corpse.png',
  'assets/BottomSheet/Yoga/cobra.png',
  'assets/BottomSheet/Yoga/chair.png',
  'assets/BottomSheet/Yoga/awkward.png',
  'assets/BottomSheet/Yoga/fish.png',
];



class MedicineClass {
  String title;
  String medicine;
  MedicineClass({required this.title, required this.medicine});
}

List<MedicineClass> medicineList = [
  // MedicineClass(
  //     title: 'Vitamin C', medicine: 'assets/BottomSheet/Medicine/drug.png'),
  MedicineClass(
      title: 'Folic Acid', medicine: 'assets/BottomSheet/Medicine/drug.png'),
  // MedicineClass(
  //     title: 'Zinc', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(
      title: 'Iron', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(
      title: 'Calcium', medicine: 'assets/BottomSheet/Medicine/vitamins.png'),
  MedicineClass(title: 'Other', medicine:'assets/BottomSheet/Medicine/drug.png'),
  // MedicineClass(
  //     title: 'Anti Viral', medicine: 'assets/BottomSheet/Medicine/vitamin.png'),
];

OutlinedButton medicineListView(int index,  controller) {
  // print(controller.medicineSelected.contains(index) ? "working" : "notworking");
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
          // side: controller.medicineSelected.contains(index)
          //     ? BorderSide(color: PrimaryColor, width: 1.5)
          //     : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      onPressed: () {},
      // controller.MedicineSelect(indexx: index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(medicineList[index].medicine, height: 32, width: 32),
          Text(
            medicineList[index].title,
            style: TextStyle(
                color: true
                // controller.medicineSelected.contains(index)
                    ? PrimaryColor
                    : Black,
                fontSize: 12),
          ),
        ],
      ));
}


Future pickDateTime(context, controller, type, id) async {
  DateTime? date = await pickDate(context, id);
  if (date == null) return;

  TimeOfDay? time = await pickTime(context);
  if (time == null) return;

  final dateTime =
      DateTime(date.year, date.month, date.day, time.hour, time.minute);
  if (type == "bed") {
    controller.bedTime.text = "${time.hour}:${time.minute}";
    controller.bedDateTime = dateTime;
    if (controller.wakeDateTime != null) {
      int a = controller.wakeDateTime!
          .difference(controller.bedDateTime!)
          .inMinutes;
      print(a);
      double aa = a / 60;
      // int v = int.parse(aa.toStringAsFixed(0));

      // int m = a - (v * 60);
      // print(m);
      // if (m != 0) {
      //   controller.sleepDuration.value = "$v Hrs : $m Mins";
      //   controller.update();
      // } else {
      //   controller.sleepDuration.value = "$v Hrs : $m Mins";
      //   controller.update();
      // }
      if (aa.toString()[2] == '.') {
        // var v = aa.toStringAsFixed(0);
        //   print(v);

        int m = a - (int.parse("${aa.toString()[0]}${aa.toString()[1]}") * 60);
        print(m);
        if (m != 0) {
          controller.sleepDuration.value =
              "${aa.toString()[0]}${aa.toString()[1]} Hrs : $m Mins";
          controller.update();
        } else {
          controller.sleepDuration.value =
              "${aa.toString()[0]}${aa.toString()[1]} Hrs : $m Mins";
          controller.update();
        }
      } else if (aa.toString()[1] == '.') {
        // var v = aa.toStringAsFixed(0);
        // print(v);

        int m = a - (int.parse("${aa.toString()[0]}") * 60);
        print(m);
        if (m != 0) {
          controller.sleepDuration.value = "${aa.toString()[0]} Hrs : $m Mins";
          controller.update();
        } else {
          controller.sleepDuration.value = "${aa.toString()[0]} Hrs : $m Mins";
          controller.update();
        }
      }
      // if (aa.toString().contains(".")) {
      //   List aaa = aa.toString().split(".");
      //   double aaaa =
      //       double.parse("0.${aaa[1].toString()[0]}${aaa[1].toString()[1]}") *
      //           60;

      //   List f = aaaa.toString().split(".");

      //   controller.sleepDuration.value =
      //       "${aaa[0].toString().replaceAll("-", "")} Hrs : ${int.parse(f[0]) + 1} Mins";
      //   controller.update();
      // } else {
      //   List aaa = aa.toString().split(".");

      //   controller.sleepDuration.value =
      //       "${aaa[0].toString().replaceAll("-", "")} Hrs : 0 Mins";
      //   controller.update();
      // }
    }
    // controller.update();
  } else {
    controller.wakeUpTime.text = "${time.hour}:${time.minute}";
    controller.wakeDateTime = dateTime;
    if (controller.bedDateTime != null) {
      int a = controller.wakeDateTime!
          .difference(controller.bedDateTime!)
          .inMinutes;
      print(a);
      double aa = a / 60;
      print(aa);
      // int v = int.parse(aa.toStringAsFixed(0));
      if (aa.toString()[2] == '.') {
        // var v = aa.toStringAsFixed(0);
        //   print(v);

        int m = a - (int.parse("${aa.toString()[0]}${aa.toString()[1]}") * 60);
        print(m);
        if (m != 0) {
          print(aa);
          print("${aa.toString()[0]}${aa.toString()[1]} Hrs : $m Mins");
          controller.sleepDuration.value =
              "${aa.toString()[0]}${aa.toString()[1]} Hrs : $m Mins";
          controller.update();
        } else {
          print(aa);
          print("${aa.toString()[0]}${aa.toString()[1]} Hrs : $m Mins");
          controller.sleepDuration.value =
              "${aa.toString()[0]}${aa.toString()[1]} Hrs : $m Mins";
          controller.update();
        }
      } else if (aa.toString()[1] == '.') {
        // var v = aa.toStringAsFixed(0);
        print(aa);

        int m = a - (int.parse("${aa.toString()[0]}") * 60);
        print(m);
        if (m != 0) {
          print(aa);
          print("${aa.toString()[0]} Hrs : $m Mins");
          var ft = "${aa.toString()[0]} Hrs : $m Mins";
          controller.sleepDuration.value = ft;
          controller.update();
        } else {
          print(aa);
          print("${aa.toString()[0]} Hrs : $m Mins");
          controller.sleepDuration.value = "${aa.toString()[0]} Hrs : $m Mins";
          controller.update();
        }
      }

      // if (aa.toString().contains(".1")) {
      //   List aaa = aa.toString().split(".");
      //   print("${aaa[1].toString()[0]}${aaa[1].toString()[1]}");
      //   double aaaa =
      //       double.parse("0.${aaa[1].toString()[0]}${aaa[1].toString()[1]}") *
      //           60;

      //   List f = aaaa.toString().split(".");

      //   controller.sleepDuration.value =
      //       "${aaa[0].toString().replaceAll("-", "")} Hrs : ${int.parse(f[0]) + 1} Mins";
      //   controller.update();
      // } else {
      //   List aaa = aa.toString().split(".");

      //   controller.sleepDuration.value =
      //       "${aaa[0].toString().replaceAll("-", "")} Hrs : 0 Mins";
      //   controller.update();
      // }
      // print(aa);
    }
    // controller.update();
  }
}
Future<DateTime?> pickDate(context, String id) => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate:
        id == "1" ? DateTime.now() : DateTime.now().subtract(Duration(days: 1)),
    lastDate: DateTime.now());


Future<TimeOfDay?> pickTime(context) =>
    showTimePicker(context: context, initialTime: TimeOfDay.now());
    

List<Symptoms> symptomsList = [
  Symptoms(title: 'Normal', image: 'assets/BottomSheet/Symptoms/normal.png'),
  Symptoms(
      title: 'Body pain', image: 'assets/BottomSheet/Symptoms/boad_pain.png'),
  Symptoms(
      title: 'Burning Stomach',
      image: 'assets/BottomSheet/Symptoms/burning_in_stomach.png'),
  Symptoms(
      title: 'Cold cough', image: 'assets/BottomSheet/Symptoms/cold_cough.png'),
  Symptoms(
      title: 'Dizziness', image: 'assets/BottomSheet/Symptoms/dizziness.png'),
  Symptoms(
      title: 'Headache', image: 'assets/BottomSheet/Symptoms/headache.png'),
  Symptoms(title: 'Vomiting', image: 'assets/BottomSheet/Symptoms/vomiting.png')
];

class Symptoms {
  String title;
  String image;
  Symptoms({required this.title, required this.image});
}
