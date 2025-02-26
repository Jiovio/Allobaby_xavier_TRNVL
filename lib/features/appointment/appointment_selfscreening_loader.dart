

import 'package:allobaby/API/Requests/SelfScreeningAPI.dart';
import 'package:allobaby/Screens/Home/Screening/Controllers/SelfScreeningController.dart';
import 'package:allobaby/features/selfscreening/details_self_screening.dart';
import 'package:allobaby/features/selfscreening/model/self_screening_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentSelfscreeningLoader extends StatelessWidget {
  final int id;
  AppointmentSelfscreeningLoader({super.key , required this.id});

  Selfscreeningcontroller controller = Get.find<Selfscreeningcontroller>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        
        
        future: SelfscreeningApi.getAppointmentSelfScreeningData(id) , 
        
        builder:(context, snapshot) {

          if(snapshot.hasData){

            final data = snapshot.data!;

            if(data.success){


              if(data.item==null){

                controller.setSelfScreeningData(SelfScreeningModel(params: {}));

                return SelfScreeningDetails(data: 
                      SelfScreeningModel(params: {})
                      );
                
              }else{

                controller.setSelfScreeningData(SelfScreeningModel.fromJson(data.item));


               return SelfScreeningDetails(data: 
                      SelfScreeningModel.fromJson(data.item));



              }

            }else{

              return const Text("Network Error");
            }

          }
          
      
          return Center(child: CircularProgressIndicator());
        },),
    );
  }
}