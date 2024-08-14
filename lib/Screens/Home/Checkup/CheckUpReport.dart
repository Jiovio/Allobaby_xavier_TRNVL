import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUpReport extends StatelessWidget {
  const CheckUpReport({super.key});

  @override
  Widget build(BuildContext context) {

        List<vitals> vitalsList = [
      vitals(
        title: 'Blood Pressure',
        image: 'assets/blood-pressure-gauge.png',
        value: "66",
      ),
      vitals(
        title: 'Temperature',
        image: 'assets/thermometer.png',
        value: "40",
      ),
      vitals(
        title: 'Blood Saturation',
        image: 'assets/blood.png',
        value: "96",
      ),
      vitals(
        title: 'Heart Rate',
        image: 'assets/cardiogram.png',
        value: "10",
      ),
      vitals(
        title: 'Blood Glucose',
        image: 'assets/glucose-meter.png',
        value: "10",
      ),
      vitals(
        title: 'BMI',
        image: 'assets/bmi.png',
        value: "10 H" +
            " - " +
            "10 W",
      ),
      vitals(
        title: 'Respiratory Rate',
        image: 'assets/peak-flow-meter.png',
        value: "100",
      ),
      vitals(
        title: 'HRV',
        image: 'assets/computer.png',
        value: "10",
      )
    ];
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkup Details"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
                    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Doctor Name",
                        style: TextStyle(
                            color: PrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Dr Velmurugan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Date:  ",
                              style: TextStyle(
                                  color: PrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              children: [
                            TextSpan(
                                text: "13-07-24",
                                style: TextStyle(
                                    color: Black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ]))
                    ],
                  ),
                  Column(
                    children: [
                      // serviceController.checkupDetails.healthStatus == null
                      //     ? Text("")
                      //     : Image.asset(
                      //         'assets/Normal.png',
                      //         scale: 4,
                      //       ),

                      Image.network(
                              'https://img.freepik.com/free-vector/hand-drawn-doctor-cartoon-illustration_23-2150680327.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1720828800&semt=ais_user',
                              scale: 4,
                            ),



                      Text(
                        "Health Status: " + "Good",
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
              Text(
                "Case Summary",
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                
                // serviceController.checkupDetails.caseSummary == null
                //     ? ""
                //     : serviceController.checkupDetails.caseSummary,

                "Case Summary",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Prescription",
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12.0,
              ),
              // serviceController.checkupDetails.prescription == null
              //     ? Container()
              //     : 
                  Scrollbar(
                      // isAlwaysShown: true,
                      // controller: _scrollController,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          // controller: _scrollController,
                          child: DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                              (states) => PrimaryColor,
                            ),
                            headingTextStyle: TextStyle(color: White),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Tablets',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Units',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Timing',
                                ),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Paracetamol')),
                                  DataCell(Text('5')),
                                  DataCell(Text('Morning,Night')),
                                ],
                              ),
                            ],
                          ))),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Requested lab supported",
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12.0,
              ),
              // serviceController.checkupDetails.requestedLabReport == null
              //     ? Container()
              //     : 
                  Wrap(
                      spacing: 12.0,
                      children: List.generate(1, (index) {
                        return Chip(
                          backgroundColor:
                              Get.isDarkMode ? darkGrey3 : PrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          label: Text("Symptom"),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: White,
                              fontSize: 18),
                        );
                      }),
                    ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Next Appointment Date",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                // serviceController.checkupDetails.nextAppointmentDate == null
                //     ? ""
                //     : serviceController.checkupDetails.nextAppointmentDate,
                "13-07-24",


                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Next Appointment Time",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                // serviceController.checkupDetails.nextAppointmentTime == null
                //     ? ""
                //     : serviceController.checkupDetails.nextAppointmentTime,
                "13-07-24",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Symptoms",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              
              
              Wrap(
                spacing: 12.0,
                children: List.generate(
                    1, (index) {
                  return Chip(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Get.isDarkMode ? Colors.grey : PrimaryColor,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(4.0)),
                    label: Text("Symptoms"),
                    labelStyle: TextStyle(
                        color: Get.isDarkMode ? White : Black,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Vitals",
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