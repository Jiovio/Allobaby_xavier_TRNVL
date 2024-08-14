import 'dart:async';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Main/BottomSheet/Baby.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading extends StatefulWidget {
   Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


      List<String> ls = ["Analyzing Emotions","Correcting Audio","Predicting Recommendations"];

      int i = 0;

      @override
      void initState (){

        

        i = 0;
        Timer.periodic(Duration(seconds: 2),(timer){

          if(i<ls.length-1){
          
          setState(() {
            i++;
          });
          }else {
                      setState(() {
            i=0;
          });
            }

          
        });


            Future.delayed(Duration(seconds: 5), () {
      Get.to(Baby(),transition: Transition.downToUp);
      
      });

        super.initState();
      }




  @override
  Widget build(BuildContext context) {




    return Scaffold(

      body:Container(
          color: White,
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
            Center(
              child: SizedBox(
                      height: 130,
                      width: 130,
                      child: CircularProgressIndicator()),
            ),
      
        SizedBox(height: 20,),
      
        Text(ls[i], style: TextStyle(fontSize: 20, color: PrimaryColor),)
      
      
          ],),
        )
    );
  }
}