import 'dart:io';
import 'dart:math';

import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/forms.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/utils/camera.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

class EditReport extends StatefulWidget {

  final Map<String, dynamic> reportDetails;

  const EditReport({super.key, required this.reportDetails});




  @override
  State<EditReport> createState() => _AddReportState();
}

class _AddReportState extends State<EditReport> {


    String? image;

    String? reportType;

    TextEditingController description = TextEditingController();


    dynamic details = {};



    @override
    void initState(){
      super.initState();

      dynamic data = (widget.reportDetails);

      reportType = data["report_type"];


      if(data["imageurl"]!=""){
        image = data["imageurl"];
      }


      details = data["details"];
      description.text = data["description"];
    }

      Future<void> submit () async {

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


    
    Map<String,dynamic> data = {
      "reportType":reportType,
      "details":details,
      "imageurl":image,
      "description":description.text,
      "id" : widget.reportDetails["id"]
    };


    print(data);
      await Reportapi().updateReport(data);

  }

  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Report".tr),
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
                                    });

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
                                    });
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

               const SizedBox(
                height: 10.0,
              ),



              buildInputs(),

                const SizedBox(
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
                    Get.back();
                    showToast("Added Report Successfully", true);
                  }
                     ,
                  
                  child: Text("SUBMIT".tr))






            ],
          ),
          )
        ),

    );
  }



  buildInputs(){


    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 10,),
      shrinkWrap: true,
      itemCount:details==null? 0 : details.keys.length,
      itemBuilder:(context, index) {
        String val = (details.keys.toList()[index]);
        return TextField(
          onChanged: (value) {
          details[val] = value;
          },
         decoration:  InputDecoration(
                    labelText: "${camelCaseToText(val)} - ${details[val]}",
                    border: const OutlineInputBorder()),
          
        );
      
    },);


  }
}


String camelCaseToText(String camelCase) {
  return camelCase.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (Match match) {
    return '${match.group(1)} ${match.group(2)}';
  }).toLowerCase();
}