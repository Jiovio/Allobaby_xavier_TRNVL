import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/forms.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/utils/camera.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {


    String? image;

    String? reportType;

    File? imageFile;

    bool validReport = true;


    TextEditingController description = TextEditingController();

      Future<void> submit () async {

        if(validReport==false){

          print("Invalid Report");

          // showToast("Please Upload Correct Report", false);

          Fluttertoast.showToast(msg: "Please Upload Correct Report");

          return;

        }

        //          if(image==null){
        //   showToast("Please Upload Image", false);
        //   return;
        // }

        if(reportType==null){
          showToast("Please select Report Type", false);
          return;
        }

        // if(desc.text==""){
        //   showToast("Please Update Description", false);
        //   return;
        // }


  // return ;
    Map<String,dynamic> reportData = {
     

    };

    



    
    Map<String,dynamic> data = {
      "reportType":reportType,
      // "details":reportData,
      "imageurl":image,
      "description":description.text,
    };
      await Reportapi().addReports(data);


      // showToast("Added Report Successfully", true);

      Fluttertoast.showToast(msg: "Added Report Successfully".tr);

      Get.back();

      

  }

  

    Future<void> processImage() async {

      final prompt = "This is my medical report ,dont give my name and details, summarize with important details in 4 lines, respond in schema {valid : bool,summary : text , reportType : get from image} , if the report is related to medical , return valid true else false";

      if(imageFile!=null){

      final summary = await OurFirebase.askVertexAi(imageFile!,prompt);

      final data = jsonDecode(summary);

      validReport = data["valid"];

      description.text = data["summary"];

      reportType = data["reportType"];

      print(data);


      setState(() {
        
      });

      }

      
      
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Report".tr),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(

            children: [

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
                                            image==null?  Text(
                                                "NO IMAGE".tr,
                                                style: const TextStyle(
                                                    fontSize: 18, color: White),
                                              ):
                                              CachedNetworkImage(imageUrl: image!)
                                                
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
                        
                             image==null ?  Center(
                                child: Text(
                                "Click Add Image Button".tr,
                                style: TextStyle(fontSize: 18),
                              )) :
                              CachedNetworkImage(imageUrl: image!)

                      ),
              ),

                        const SizedBox(
                height: 10.0,
              ),


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
                                    onPressed: () async {
                                    final url = await  Imageutils().getImageFromCamera("reports");
                                    setState(() {
                                      image = url![0] as String;
                                      imageFile = url[1] as File;
                                    });


                                    Loadingbar.use("AnalyzingReport",processImage);

                                    
                                    

                                    },
                                    backgroundColor: Colors.amberAccent,
                                    child: Image.asset(
                                      'assets/General/camera.png',
                                      scale: 16,
                                    )),
                                FloatingActionButton(
                                    elevation: 0,
                                    focusColor: Colors.greenAccent,
                                    tooltip: "Gallery",
                                    onPressed: () async {
                                         final url = await  Imageutils().getImageFromGallery("reports");
                                    setState(() {
                                      image = url![0] as String;
                                      imageFile = url[1] as File;
                                    });


                                    Loadingbar.use("AnalyzingReport",processImage);
                                    },
                                        // reportController.getImageFromGallery(),
                                    backgroundColor: Colors.indigoAccent,
                                    child: Image.asset(
                                      'assets/General/gallery.png',
                                      scale: 16,
                                    )),
                              ],
                            ),
                          )),
                  icon:const Icon(Icons.add_a_photo),
                  label: Text("ADD IMAGE".tr)),

                                SizedBox(
                height: 10.0,
              ),

                          // searchBox("Report of ?",["Mother", "Child"],(v){
                              
                          // }),

                           SizedBox(
                height: 10.0,
              ),

              dropDown("Select Type of Report", [
                  "ECG",
                  "Blood Test",
                  "HCG",
                  "Lab Test",
                  "x-ray",
                  "Ultrasound Scan",
                  "CT Scan",
                  "Mammogram",
                  "MRI",
                  "Others"
                ],(v){

                  reportType = v;

                  setState(() {
                    
                  });

                },

                reportType
                
                ),

                                           SizedBox(
                height: 10.0,
              ),

                            TextFormField(
                controller: description,
                decoration: InputDecoration(
                    labelText: "Write Description".tr,
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.text,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Description'.tr;
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 20.0,
              ),

              ElevatedButton(

                

                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  onPressed: () async {
                    await Loadingbar.use("Uploading Report ...", submit);
                    // Get.back();
                    
                  }
                     ,
                  
                  child: Text(validReport? "ADD REPORT".tr:"Invalid Report".tr))






            ],
          ),
          )
        ),

    );
  }
}