import 'package:allobaby/features/selfscreening/details_self_screening.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // for formatting the date/time

class SelfScreeningList extends StatelessWidget {
  const SelfScreeningList({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data
    final List<SelfScreeningModel> data = [

      SelfScreeningModel.fromJson(      {
        "id": 1,
        "symptomsId": 1,
        "vitalID": 7,
        "hemoglobinId": null,
        "urineTestId": null,
        "glucoseId": null,
        "fetalTestId": null,
        "ultrasoundId": null,
        "created": "2025-02-18T12:34:56",
        "userId": "user_id_string",
        "updated": "2025-02-18T12:34:56"
      })

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Self Screening List"),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          final createdDate = item.created;
          final formattedDate = DateFormat('dd-MM-yyyy').format(createdDate);
          final formattedTime = DateFormat('hh:mm a').format(createdDate);

          return Card(
            
            margin: const EdgeInsets.all(8),
            child: ListTile(
              onTap: () => Get.to(()=> SelfScreeningDetails(data: item)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                    image("assets/labReports/symptoms.png",item.symptomsId),
                  
                    image("assets/labReports/vitals.png",item.vitalID),
                  
                    image("assets/labReports/hemoglobin.png",item.hemoglobinId),
                  
                    image("assets/labReports/urinetest.png",item.urineTestId),
                  
                    image("assets/labReports/glucose.png",item.glucoseId),
                  
                    image("assets/labReports/fetalmon.png",item.fetalTestId),
                  
                    image("assets/labReports/ultrasound.png",item.ultrasoundId),
                ],
              ),
              title: Text('Date: $formattedDate'),
              subtitle: Text('Time: $formattedTime'),
            ),
          );
        },
      ),
    );
  }
}


image(String img, dynamic id){

  return Container(
    margin: const EdgeInsets.only(right: 5),
    child: Image.asset(img, height: 30, width: 30,
    ));
}
