
import 'package:allobaby/Components/beauty/waiting_for_doctor.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewCheckUpReport extends StatefulWidget {

  dynamic data;
  Map<String,dynamic> reportData;


  NewCheckUpReport({super.key , required this.data , required this.reportData});

  @override
  State<NewCheckUpReport> createState() => _NewCheckUpReportState();
}

class _NewCheckUpReportState extends State<NewCheckUpReport> {
  @override
  Widget build(BuildContext context) {

      List<vitals> vitalsList = [];

      List<String> ls = [];
      List<String> labrequests = [];


      List<dynamic> items = [];
          

      if (widget.data["prescription"] != null) {
              items = widget.data["prescription"];
      }

      if(widget.data["symptoms"]!=null){

        widget.data["symptoms"].forEach((value) {
          ls.add(value);
        });
        

      }

            if(widget.data["labrequest"]!=null){

        widget.data["labrequest"].forEach((value) {
          labrequests.add(value);
        });
        

      }



          if(widget.data["vitals"]!=null){

        vitalsList = [
      vitals(
        title: 'Blood Pressure',
        image: 'assets/blood-pressure-gauge.png',
        value: "${widget.data["vitals"]["bloodPressureL"]}/${widget.data["vitals"]["bloodPressureH"]}",
      ),
      vitals(
        title: 'Temperature',
        image: 'assets/thermometer.png',
        value: "${widget.data["vitals"]["temperature"]} ${widget.data["vitals"]["temperatureMetric"]}",
      ),
      vitals(
        title: 'Blood Saturation',
        image: 'assets/blood.png',
        value: "${widget.data["vitals"]["bloodSaturationBW"]} | ${widget.data["vitals"]["bloodSaturationAW"]}",
      ),
      vitals(
        title: 'Heart Rate',
        image: 'assets/cardiogram.png',
        value: "${widget.data["vitals"]["heartRateBW"]} | ${widget.data["vitals"]["heartRateAW"]}",
      ),
      vitals(
        title: 'Blood Glucose',
        image: 'assets/glucose-meter.png',
        value: "${widget.data["vitals"]["bloodGlucoseBF"]} | ${widget.data["vitals"]["bloodGlucoseAF"]}",
      ),
      vitals(
        title: 'BMI',
        image: 'assets/bmi.png',
        value: "${widget.data["vitals"]["bmiHeight"]} H" +
            " - " +
            "${widget.data["vitals"]["bmiWeight"]} W",
      ),
      vitals(
        title: 'Respiratory Rate',
        image: 'assets/peak-flow-meter.png',
        value: "${widget.data["vitals"]["respiratoryRate"]}",
      ),
      vitals(
        title: 'HB',
        image: 'assets/computer.png',
        value: "${widget.data["vitals"]["hrv"]}",
      )
    ];



          }
      
    return Scaffold(
      appBar: AppBar(
        title:  Text("Checkup Details".tr),
      ),

      body: 
      widget.data == null ?
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

              if(widget.data["checkup_date"]==null)
              const WaitingForDoctorWidget(),
              if(widget.data["checkup_date"]!=null)
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
                        widget.data["doctor"]["name"],
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
                                text: DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.data["checkup_date"])) ,
                                style: const TextStyle(
                                    color: Black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ]))
                    ],
                  ),
                  Column(
                    children: [
                     widget.data["healthStatus"]== null
                          ? Text("")
                          : Image.asset(
                              'assets/Risk/${widget.data["healthStatus"]}.png',
                              scale: 4,
                            ),

                 
                      SizedBox(
                height: 8.0,
              ),



                      Text(
                        "Health Status: ".tr + (widget.data["healthStatus"] ?? "Waiting for Input"),
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
              
              if(widget.data["summary"]!=null)
              Text(
                "Case Summary".tr,
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              if(widget.data["summary"]!=null)
              SizedBox(
                height: 8.0,
              ),
              if(widget.data["summary"]!=null)
              Text(
                widget.data["summary"],
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

              

              if(widget.data["prescription"]!=null)
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

              if(widget.data["nextAppointmentDate"]!=null)
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
                DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.data["nextAppointmentDate"])),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),


                ],
              ),


              if(widget.data["labrequest"]!=null)
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



              if(widget.data["symptoms"]!=null)
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


              

              if(widget.data["vitals"]!=null)
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


  //   Widget _buildInfoSection(BuildContext context) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Expanded(
  //         child: Card(
  //           elevation: 2,
  //           child: Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text(
  //                   'Patient Information',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text('Patient Name: ${widget.patientId}'),
  //                                   const SizedBox(height: 8),
  //                 Text('Patient Age: ${widget.userDetails["age"]}'),
  //                                   const SizedBox(height: 8),
  //                 Text('Blood Group: ${widget.userDetails["bloodGroup"]}'),
  //                                   const SizedBox(height: 8),
  //                 Text('Pregnancy Status:  ${widget.userDetails["pregnancyStatus"]}'),
  //                 const SizedBox(height: 8),
  //                 Text('BMI: ${_calculateBMI().toStringAsFixed(1)}'),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(width: 16),

  //       // Expanded(child: Container(),)
  //       // Expanded(
  //       //   child: Card(
  //       //     elevation: 2,
  //       //     child: Padding(
  //       //       padding: const EdgeInsets.all(12.0),
  //       //       child: Column(
  //       //         crossAxisAlignment: CrossAxisAlignment.start,
  //       //         children: [
  //       //           const Text(
  //       //             'Doctor Information',
  //       //             style: TextStyle(
  //       //               fontWeight: FontWeight.bold,
  //       //               fontSize: 16,
  //       //             ),
  //       //           ),
  //       //           const SizedBox(height: 8),
  //       //           Text('Name: ${doctorDetails['name']}'),
  //       //           const SizedBox(height: 4),
  //       //           Text('Specialization: ${doctorDetails['specialization']}'),
  //       //           const SizedBox(height: 4),
  //       //           Text('License: ${doctorDetails['license']}'),
  //       //         ],
  //       //       ),
  //       //     ),
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }

  Widget _buildSection({required String title, required Widget child}) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildVitalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildAISummary(String summary) {
    return Card(
      elevation: 3,
      // color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Row(
              children: const [
                Icon(Icons.psychology, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'AI Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              // _generateAISummary(),
              summary,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

}

class vitals {
  String title;
  String image;
  String value;
  vitals({required this.title, required this.image,required this.value});
}