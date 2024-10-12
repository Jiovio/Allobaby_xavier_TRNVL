import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/BabyCry/babyCryController.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Baby extends StatelessWidget {
   Baby({super.key});

  Babycrycontroller controller = Get.put(Babycrycontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: () {

            Get.offAll(()=>MainScreen(),
            transition: Transition.fade);
  
        },
        
        icon: Icon(Icons.arrow_back_ios_new),),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        height: 65,
        color: PrimaryColor,
        child: Row(
          children: [
            Icon(Icons.play_circle,color: White,size: 40,),

            SizedBox(width: 20,),

            Text("Play your Baby Audio",style: TextStyle(color: White),)
          ],),
      ),

     
      body:  SingleChildScrollView(
        child: Stack(
          children: [
        
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
          
              children: [
          
          
                Image.asset("assets/BottomSheet/crybaby.png",width: Get.width*.8,),
          
                SizedBox(height: 10,),
                
                Container(
                  
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: White,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: PrimaryColor)
          
                  ),
                  child:  Column(
                    children: [
                    Row(
                      
                      children: [
                      Icon(Icons.snooze,size: 30,color: Black,),
                      SizedBox(width: 20,),
                      Text(controller.reason,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,
                      color: Black
                      ),)
                      
                    ],),
          
                    Divider(
                      color: PrimaryColor,
              
                      thickness: 2,
          
                    ),
        
                SizedBox(height: 5,),
                ElevatedButton(onPressed:() {
                  
                }, child: Text("Show More"))
                    
                  ],),
                ),
        
                SizedBox(height: 10,),
                Divider(color: accentColor,),
        
                SizedBox(
                  width: double.infinity,
                  child: Text("Recommendations",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: PrimaryColor),))
                  ,
                  
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.stepsToComfortTheBaby.length,
                    itemBuilder:(context, index) {
                      String currentRecommdation = controller.stepsToComfortTheBaby[index];


                      return Text(currentRecommdation);
                    
                  },)
              ],
            ),
          ),
          
                    Positioned(
              right: 10,
              child: 
            
            Container(
              
              // decoration: BoxDecoration(
              //   color: accentColor,
              //   borderRadius: BorderRadius.circular(20)
              // ),
              
              
              // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              // width: 60,
              
              child: Column(children: [
                // const Icon(Icons.check_box,color: PrimaryColor,size: 40,),
                  // SizedBox(height: 10,),
                  // Divider(color: Colors.grey.shade100,),
                      // const Icon(Icons.close_outlined,color: PrimaryColor,size: 40,),
        
        
                      
                      
              
              ],),
        
        
              
            
            
            )
           
           
            ),
          
          ]
        ),
      ),
    );
  }
}