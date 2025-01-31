
import 'package:allobaby/Components/beauty/waiting_for_doctor.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckUpReport extends StatelessWidget {

  dynamic data;
  CheckUpReport({super.key , required this.data});


  
  @override
  Widget build(BuildContext context) {

      List<vitals> vitalsList = [];

      List<String> ls = [];
      List<String> labrequests = [];


      List<dynamic> items = [];
          

      if (data["prescription"] != null) {
              items = data["prescription"];
      }

      if(data["symptoms"]!=null){

        data["symptoms"].forEach((value) {
          ls.add(value);
        });
        

      }

            if(data["labrequest"]!=null){

        data["labrequest"].forEach((value) {
          labrequests.add(value);
        });
        

      }



          if(data["vitals"]!=null){

        vitalsList = [
      vitals(
        title: 'Blood Pressure',
        image: 'assets/blood-pressure-gauge.png',
        value: "${data["vitals"]["bloodPressureL"]}/${data["vitals"]["bloodPressureH"]}",
      ),
      vitals(
        title: 'Temperature',
        image: 'assets/thermometer.png',
        value: "${data["vitals"]["temperature"]} ${data["vitals"]["temperatureMetric"]}",
      ),
      vitals(
        title: 'Blood Saturation',
        image: 'assets/blood.png',
        value: "${data["vitals"]["bloodSaturationBW"]} | ${data["vitals"]["bloodSaturationAW"]}",
      ),
      vitals(
        title: 'Heart Rate',
        image: 'assets/cardiogram.png',
        value: "${data["vitals"]["heartRateBW"]} | ${data["vitals"]["heartRateAW"]}",
      ),
      vitals(
        title: 'Blood Glucose',
        image: 'assets/glucose-meter.png',
        value: "${data["vitals"]["bloodGlucoseBF"]} | ${data["vitals"]["bloodGlucoseAF"]}",
      ),
      vitals(
        title: 'BMI',
        image: 'assets/bmi.png',
        value: "${data["vitals"]["bmiHeight"]} H" +
            " - " +
            "${data["vitals"]["bmiWeight"]} W",
      ),
      vitals(
        title: 'Respiratory Rate',
        image: 'assets/peak-flow-meter.png',
        value: "${data["vitals"]["respiratoryRate"]}",
      ),
      vitals(
        title: 'HB',
        image: 'assets/computer.png',
        value: "${data["vitals"]["hrv"]}",
      )
    ];



          }

      
        
        
        

    






      
    return Scaffold(
      appBar: AppBar(
        title:  Text("Checkup Details".tr),
      ),

      body: 
      data == null ?
      Center(
        child: Text("Checkup Details Not Available".tr),
      )
      :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if(data["checkup_date"]==null)
              const WaitingForDoctorWidget(),
              if(data["checkup_date"]!=null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Doctor Name".tr,
                        style: TextStyle(
                            color: PrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                              SizedBox(
                height: 8.0,
              ),
                      Text(
                        data["doctor"]["name"],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Date:  ".tr,
                              style: TextStyle(
                                  color: PrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              children: [
                            TextSpan(
                                text: DateFormat('dd-MM-yyyy').format(DateTime.parse(data["checkup_date"])) ,
                                style: const TextStyle(
                                    color: Black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ]))
                    ],
                  ),
                  Column(
                    children: [
                     data["healthStatus"]== null
                          ? Text("")
                          : Image.asset(
                              'assets/Risk/${data["healthStatus"]}.png',
                              scale: 4,
                            ),

                 
                      SizedBox(
                height: 8.0,
              ),



                      Text(
                        "Health Status: ".tr + (data["healthStatus"] ?? "Waiting for Input"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              
              if(data["summary"]!=null)
              Text(
                "Case Summary".tr,
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              if(data["summary"]!=null)
              SizedBox(
                height: 8.0,
              ),
              if(data["summary"]!=null)
              Text(
                data["summary"],
                style:const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.15),
                textAlign: TextAlign.justify,
              ),
              
                      SizedBox(
                height: 16.0,
              ),

              if(data["prescription"]!=null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                               SizedBox(
                height: 12.0,
              ),

               
              Text(
                "Prescription".tr,
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12.0,
              ),

                  Scrollbar(

                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                              (states) => PrimaryColor,
                            ),
                            headingTextStyle: TextStyle(color: White),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Tablets'.tr,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Units'.tr,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Timing'.tr,
                                ),
                              ),
                            ],
                            rows: items.map((e) => 
                    DataRow(
                    cells: <DataCell>[
                      DataCell(Text(e["tablets"])),
                      DataCell(Text(e["units"].toString())),
                      DataCell(Text(e["Timings"])),
                    ],
                    ),
                    ).toList(),
                          ))),
              SizedBox(
                height: 16.0,
              ),


                ],
              ),

              
              

              // Text(
              //   "Requested lab supported",
              //   style: TextStyle(
              //       color: PrimaryColor,
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600),
              // ),
              // SizedBox(
              //   height: 12.0,
              // ),
              //     Wrap(
              //         spacing: 12.0,
              //         children: List.generate(1, (index) {
              //           return Chip(
              //             backgroundColor:
              //                 Get.isDarkMode ? darkGrey3 : PrimaryColor,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(4.0)),
              //             label: Text("Symptom"),
              //             labelStyle: TextStyle(
              //                 fontWeight: FontWeight.w600,
              //                 color: White,
              //                 fontSize: 18),
              //           );
              //         }),
              //       ),
              // SizedBox(
              //   height: 18,
              // ),




              if(data["nextAppointmentDate"]!=null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                                Text(
                "Next Appointment Time".tr,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('dd-MM-yyyy').format(DateTime.parse(data["nextAppointmentDate"])),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),


                ],
              ),


              if(data["labrequest"]!=null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                                Text(
                "Lab Requests".tr,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8,),


                Wrap(
                spacing: 12.0,
                children: List.generate(
                    labrequests.length, (index) {
                  return Chip(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(4.0)),
                    label: Text(labrequests[index]),
                    labelStyle: TextStyle(
                        color: Get.isDarkMode ? White : Black,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ),
             const SizedBox(
                height: 18,
              ),


                ],
              ),



              if(data["symptoms"]!=null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                                Text(
                "Symptoms".tr,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 8,),


                Wrap(
                spacing: 12.0,
                children: List.generate(
                    ls.length, (index) {
                  return Chip(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(4.0)),
                    label: Text(ls[index]),
                    labelStyle: TextStyle(
                        color: Get.isDarkMode ? White : Black,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ),
             const SizedBox(
                height: 18,
              ),


                ],
              ),


              

              if(data["vitals"]!=null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                                Text(
                "Vitals".tr,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),


                            GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(vitalsList.length, (index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              vitalsList[index].value,
                              style: TextStyle(
                                fontSize: 18,
                                color: PrimaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              vitalsList[index].title,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
            


                ],
              ),
              



            ],
          ),
        
          )
      ,)


    );
  }

}

class vitals {
  String title;
  String image;
  String value;
  vitals({required this.title, required this.image,required this.value});
}