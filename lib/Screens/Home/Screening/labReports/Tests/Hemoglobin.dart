

import 'dart:convert';

import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/textfield.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/Reports/hemoglobinController.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Scan/HemoglobinScan.dart';
import 'package:allobaby/Screens/Home/Screening/labReports/Widgets/selectorWidgets.dart';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';


class Hemoglobin extends StatelessWidget {
  Hemoglobin({super.key});

  Hemoglobincontroller controller = Get.put(Hemoglobincontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<Hemoglobincontroller>(
                              init: Hemoglobincontroller(),
                              builder:(controller) => 
                              Column(

            children: [

                                      SizedBox(
                              width: double.infinity,
                              child: Text(
                                              "Add Hemoglobin Report".tr,
                                              style: TextStyle(
                                                fontSize: 20,
                                                
                                              ),
                                            ),
                            ),

                            SizedBox(height: 10,),

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
                                      child:Center(
                                        child: 
                                        
                                        controller.fileImage64 == null
                                            ? Text(
                                                "NO IMAGE".tr,
                                                style: TextStyle(
                                                    fontSize: 18, color: White),
                                              )
                                            : Image.memory(base64Decode(
                                                controller.fileImage64)),

                                              // Text(
                                              //   "NO IMAGE",
                                              //   style: TextStyle(
                                              //       fontSize: 18, color: White),
                                              // )
                                                
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
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
                        controller.fileImage64 == null
                            ? Center(
                                child: Text(
                                "Click Add Image Button".tr,
                                style: TextStyle(fontSize: 18),
                              ))
                            : Image.memory(
                                base64Decode(controller.fileImage64)),
                              // const Center(
                              //   child: Text(
                              //   "Click Add Image Button",
                              //   style: TextStyle(fontSize: 18),
                              // ))

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
                                      "Choose photo from :".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                    FloatingActionButton(
                                        elevation: 0,
                                        tooltip: "Camera",
                                        onPressed: () => controller.getImageFromCamera(context) ,
                                            
                                        backgroundColor: Colors.amberAccent,
                                        child: Image.asset(
                                          'assets/General/camera.png',
                                          scale: 16,
                                        )),
                                    FloatingActionButton(
                                        elevation: 0,
                                        focusColor: Colors.greenAccent,
                                        tooltip: "Gallery",
                                        onPressed:()=>controller.getImageFromGallery(context),
                                        backgroundColor: Colors.indigoAccent,
                                        child: Image.asset(
                                          'assets/General/gallery.png',
                                          scale: 16,
                                        )),
                                  ],
                                ),
                              )),
                                                icon: Icon(Icons.add_a_photo),
                                                label: Text("Upload Report".tr)),

                                        //  TextButton.icon(onPressed: (){
                                        //   Get.to(Hemoglobinscan());
                                        //  }, 
                                        //  icon: Icon(Icons.account_tree_sharp),
                                        //  label: Text("Automatic"),)       
                            ],
                          ),



                                SizedBox(
                height: 10.0,
              ),

                          // searchBox("Report of ?",["Mother", "Child"]),


                          ListTile(
                            leading: Image.asset("assets/labReports/hemoglobin.png"),
                            title: 
                            Text("Hemoglobin Value : ${controller.hemoGlobinValue ?? "_"}".tr,
                            ),
                            
                            
                            
                            subtitle: Text("Tap to Change".tr),
                            shape: OutlineInputBorder(borderSide: BorderSide(
                              color: Colors.grey
                            )),

                            onTap: () {
                              showDialog(context: context, builder:(context) {
                                return AlertDialog(
                                  title: Text("Hemoglobin Value".tr),

                                  content: HemoglobinSelector());
                              },);
                            },
                          ),

                          



              
                        
                       const SizedBox(height: 20,),




                            TFField(label: "Description",mLines: 5,
                            txtController: controller.desc,
                            ),

              const SizedBox(
                height: 20.0,
              ),

              ElevatedButton(
                

                  style: ElevatedButton.styleFrom(
                      fixedSize:const Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: controller.submit,
                  child: Obx(()=>
                    controller.loading.value?
                    const Center(child: CircularProgressIndicator(color: White,)):
                    controller.created.value?
                    Text("REPORT ADDED".tr) :
                    Text("ADD REPORT".tr)
                    
                    
                    ))






            ],
          ),
          )),
        ),

    );
  }



}