import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Viewhospital extends StatelessWidget {
  const Viewhospital({super.key});
  
  get icon => null;

  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
    
        appBar: AppBar(
        title: Text("JioVio Hospital"),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
              })
        ],
      ),

      floatingActionButton: 
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          FloatingActionButton(
            child: Icon(Icons.check ,size: 30 , color: Black,),
            onPressed: (
  
            
            ) {
              
            },
          ),

            
          SizedBox(height: 20,),
          FloatingActionButton(
            child: Icon(Icons.cancel_rounded ,size: 30 , color: Black,),
            onPressed: (
  
            
            ) {
              
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          
          Image.asset("assets/Hospital/hospital.png"),

          

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              Text("JioVio Hospital For Women And Childrens",
              style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20,color: PrimaryColor),

              ),

SizedBox(height: 10,),

              Row(
                
                  children: [
                    
                    Text("4.6",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(width: 7,),

                    Icon(Icons.star,color: const Color.fromARGB(255, 239, 216, 1),),
                    Icon(Icons.star,color: const Color.fromARGB(255, 239, 216, 1),),
                    Icon(Icons.star,color: const Color.fromARGB(255, 239, 216, 1),),
                     Icon(Icons.star,color: const Color.fromARGB(255, 239, 216, 1),),
               
                  ],
                  

                ),

                SizedBox(height: 15,),
                
              
              
             
                  SizedBox(
                    width: double.infinity,
                    child: Text("Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
               
             

                    Text("Rio Maternity and Childrens Hospital Tuticorin Ring Road, Near Maruti Suzuki True Value,Opposite to Annamalaiar School Madurai 625 020"),

SizedBox(height: 10,),

            
                Row(                
                  children: [
                    
                    Text("Phone",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(width: 25,),

                    Text("+91 77083 18222",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                    SizedBox(width: 7,),

                  ],
                ),                
SizedBox(height: 10,),
                  Row(                
                  children: [
                    
                    Text("Hours",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(width: 25,),

                    Text("Opens for 24 hours",
                    style: TextStyle(fontWeight: FontWeight.w400)),
                    
                  ],
                ),

                SizedBox(height: 10,),
               
               Row(                
                  children: [
                    
                    Text("Website",
                    style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(width: 15,),

                    Text("www.jioviohospital.com",
                    style: TextStyle(fontWeight: FontWeight.w400)),

                    SizedBox(height: 10,),

        
                    

                  ],
                ),


          
            
             

            ],)
          ),
        ],
      ),

     

     ); 
  }
}