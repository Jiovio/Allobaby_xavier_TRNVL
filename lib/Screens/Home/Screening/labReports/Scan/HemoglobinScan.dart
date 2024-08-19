
import 'package:allobaby/Components/CameraCapture.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Hemoglobinscan extends StatelessWidget {
   Hemoglobinscan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: SingleChildScrollView(

          child: Container(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Column(
              children: [

                Image.asset("assets/labReports/glucose.png",height: 70,),

                              SizedBox(height: 20,),

                Text("Hemoglobin Test", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,),


              SizedBox(height: 20,),
          
                Text("Easily get your Reading by Performing the scans below",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,),



                SizedBox(height: 20,),

                listOfScans()
              ],
              
              ),
          ),
      ),
    );
  }


  listOfScans() {
    List title = ["Eye Scan","Nail Scan","Tongue Scan"];

    List icons = [Icon(Icons.remove_red_eye_outlined),Icon(Icons.back_hand_rounded),
    Icon(Icons.face)
    ];

    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20,),
      shrinkWrap: true,
      itemCount: title.length,
      itemBuilder: (context,index) {
        return ListTile(
          onTap: () {
            Get.to(CameraCapture());
          },
          splashColor: PrimaryColor.withOpacity(0.2),
          iconColor: PrimaryColor,
          titleTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Black),

          title: Text(title[index]),
          leading: icons[index],
          trailing: Icon(Icons.arrow_circle_right_rounded),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: darkGrey)
          )
        );
      } 
      
      );
  }
}