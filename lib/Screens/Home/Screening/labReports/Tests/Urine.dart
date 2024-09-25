
import 'dart:convert';

import 'package:allobaby/Components/CameraCapture.dart';
import 'package:allobaby/Components/forms.dart';
import 'package:allobaby/Components/textfield.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/Reports/urineTestController.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class Urine extends StatelessWidget {
  const Urine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: 
          GetBuilder<Urinetestcontroller>(
            init: Urinetestcontroller(),
            builder:(controller) => 
          Column(
            children: [

                                      SizedBox(
                              width: double.infinity,
                              child: Text(
                                              "Add Urine Test Report",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
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
                                            ? Text(
                                                "NO IMAGE",
                                                style: TextStyle(
                                                    fontSize: 18, color: White),
                                              )
                                            : Image.memory(base64Decode(
                                                controller.fileImage64)),
                                                
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
                                "Click Add Image Button",
                                style: TextStyle(fontSize: 18),
                              ))
                            : Image.memory(base64Decode(controller.fileImage64)),

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
                                   const Text(
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
                                        child: Image.asset('assets/General/gallery.png',
                                          scale: 16,
                                        )),
                                  ],
                                ),
                              )),
                                                icon:const Icon(Icons.add_a_photo),
                                                label:const Text("Upload Report")),


                                       TextButton.icon(onPressed: (){
                                            Get.to(CameraCapture());
                                         }, 
                                         icon: Icon(Icons.account_tree_sharp),
                                         label: Text("Automatic"),) 
                            ],
                          ),

                              const  SizedBox(
                                height: 10.0,
                              ),

                          dropDown(
                          
                            "Alpamine Present", 
                            ["Yes", "No"],
                            (text) {
                              controller.alphaminePresent = text;
                              controller.update();
                            },
                            controller.alphaminePresent
                            ),

                         

                             const SizedBox(
                                      height: 20.0,
                                    ),

                          dropDown("Sugar Present", ["Yes","No"],
                          (text) {
                              controller.sugarPresent = text;
                              controller.update();
                            },controller.sugarPresent),






                           SizedBox(
                height: 10.0,
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

                            TFField(label: "Description",mLines: 5,
                            txtController: controller.desc,),

               const SizedBox(
                height: 20.0,
              ),


              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: controller.submit,
                  child: Text("ADD REPORT"))






            ],
        ))
          )
        ),

    );
  }



}