

import 'dart:convert';

import 'package:allobaby/Components/forms.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/Reports/ultraSoundController.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class Ultrasound extends StatelessWidget {
  const Ultrasound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: 
      GetBuilder<Ultrasoundcontroller>(
        init: Ultrasoundcontroller(),
        builder:(controller) => 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [

  
              SizedBox(
                              width: double.infinity,
                              child: Text(
                                              "Ultra Sound",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                            ),
              SizedBox(
                height: 15,
              ),


              GestureDetector(
                onTap: () => showDialog(
                            context: context,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Black,
                              child: Material(
                                color: Colors.transparent,
                                child: Stack(
                                  children: [
                                    InteractiveViewer(
                                      child: Center(
                                        child: 
                                        controller.fileImage64 == null
                                            ?const Text(
                                                "NO IMAGE",
                                                style: TextStyle(
                                                    fontSize: 18, color: White),
                                              )
                                            : Image.memory(base64Decode(
                                                controller.fileImage64)),

                                                
                                      ),
                                    ),
                                    Padding(
                                      padding:const EdgeInsets.all(10),
                                      child: IconButton(
                                          icon:const Icon(
                                            Icons.arrow_back,
                                            color: White,
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: 
                              const Center(
                                child: Text(
                                "Click Add Image Button",
                                style: TextStyle(fontSize: 18),
                              ))

                      ),
              ),

                        const SizedBox(
                height: 10.0,
              ),


                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () => showModalBottomSheet(
                                                    context: context,
                                builder: (context) => Container(
                                height: MediaQuery.of(context).size.height / 5,
                                color: White,
                                padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Choose photo from :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    FloatingActionButton(
                                        elevation: 0,
                                        tooltip: "Camera",
                                        onPressed: () => 
                                            controller.getImageFromCamera(),
                                        backgroundColor: Colors.amberAccent,
                                        child: Image.asset(
                                          'assets/General/camera.png',
                                          scale: 16,
                                        )),
                                    FloatingActionButton(
                                        elevation: 0,
                                        focusColor: Colors.greenAccent,
                                        tooltip: "Gallery",
                                        onPressed: () => 
                                            controller.getImageFromGallery(),
                                        backgroundColor: Colors.indigoAccent,
                                        child: Image.asset(
                                          'assets/General/gallery.png',
                                          scale: 16,
                                        )),
                                  ],
                                ),
                              )),
                                                icon: Icon(Icons.add_a_photo),
                                                label: Text("Upload Report")),


                                       TextButton.icon(onPressed: (){
                                          
                                         }, 
                                         icon: Icon(Icons.account_tree_sharp),
                                         label: Text("Automatic"),) 
                            ],
                          ),

                                SizedBox(
                height: 10.0,
              ),

                          dropDown("Fetal Presentation", ["Cephalic", "Breech","Shoulder","Compound"],(t){}),

            SizedBox(
                height: 20.0,
              ),

               dropDown("Fetal Movement", ["Present","Absent"],(t){}),


              SizedBox(
                height: 20.0,
              ),

                          dropDown("Placenta", 
                          ["Posterior","Anterior","Fundal","Lateral","Low-lying"],(t){}),

                           SizedBox(
                height: 20.0,
              ),


                                        ListTile(
                            leading: Image.asset("assets/labReports/heart.png"),
                            title: Text("Heart Rate : 60 BPM"),
                            subtitle: Text("Tap to Change "),
                            shape: OutlineInputBorder(borderSide: BorderSide(
                              color: Colors.grey
                            )),

                            onTap: () {
                              showDialog(context: context, builder:(context) {
                                return AlertDialog(
                                  title: Text("Heart Rate "),

                                  content: Row(
                                    children: [
                                      NumberPicker(
                                                      
                                            value: 40,
                                                          minValue: 30,
                                                          itemHeight: 32,
                                                          maxValue: 150,
                                                          onChanged: (value) {
                                                          
                                                          },
                                                        ),

                                                        SizedBox(width: 10,),

                                                        Text("BPM",
                                                        style: TextStyle(fontSize: 14),)
                                    ],
                                  ),);
                              },);
                            },
                          ),




                                           SizedBox(
                height: 10.0,
              ),

              //               TextFormField(
              //   // controller: reportController.reportDesc,
              //   decoration: InputDecoration(
              //       labelText: "Write Description",
              //       border: OutlineInputBorder()),
              //   keyboardType: TextInputType.text,
              //   maxLines: 5,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter Description';
              //     }
              //     return null;
              //   },
              // ),
                                            const SizedBox(
                height: 20.0,
              ),

               TextFormField(
                          decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                            
                          maxLines: 5
                        ),
                


              const SizedBox(
                height: 20.0,
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () => {},
                  child: Text("ADD REPORT"))






            ],
          ),
          )
        )),

    );
  }



}