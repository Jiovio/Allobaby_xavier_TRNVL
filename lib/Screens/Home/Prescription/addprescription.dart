import 'dart:convert';
import 'dart:io';

import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Components/forms.dart';
import 'package:allobaby/Components/image_viewer.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:allobaby/utils/camera.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPrescription extends StatefulWidget {
  const AddPrescription({super.key});

  @override
  State<AddPrescription> createState() => _AddPrescriptionState();
}

class _AddPrescriptionState extends State<AddPrescription> {
  String? imageUrl;
  String? prescriptionType;
  int? userId;
  bool isLoading = false;

  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> prescriptionTypes = [
    "ECG",
    "Blood Test",
    "HCG",
    "Lab Test",
    "X-Ray",
    "Ultrasound Scan",
    "CT Scan",
    "Mammogram",
    "MRI",
    "Others"
  ];

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadUserId() async {
    final id = await Storage.getUserID();
    setState(() => userId = id);
  }

  Future<void> _addPrescription() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (imageUrl == null) {
      Get.snackbar(
        "Error", 
        "Please add an image",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
      );
      return;
    }

    // if (prescriptionType == null) {
    //   Get.snackbar(
    //     "Error", 
    //     "Please select prescription type",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red.withOpacity(0.1),
    //   );
    //   return;
    // }

    setState(() => isLoading = true);

    try {
      await OurFirebase.addPrescription(
        userId: userId!,
        imageUrl: imageUrl!,
        prescriptionType: prescriptionType ?? "",
        description: descriptionController.text,
      );

      Get.snackbar(
        "Success", 
        "Prescription added successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
      );
      
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add prescription: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _showImagePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 5,
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Choose photo from:",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            _ImagePickerButton(
              icon: 'assets/General/camera.png',
              color: Colors.amberAccent,
              tooltip: 'Camera',
              onPressed: () => _getImage(true),
            ),
            _ImagePickerButton(
              icon: 'assets/General/gallery.png',
              color: Colors.indigoAccent,
              tooltip: 'Gallery',
              onPressed: () => _getImage(false),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(bool fromCamera) async {


    Navigator.pop(context);

    if(fromCamera){

          final imgUrl = await Imageutils().getImageFromCamera(
      "prescription",
    );
    if (imgUrl != null) {
      setState(() => imageUrl = imgUrl[0] as String);

      askAI(imgUrl[1] as File);
    }
    }else{

               final imgs = await Imageutils().getImageFromGallery(
      "prescription"
    );

    if(imgs==null) return;

    if (imgs[0] != null) {
      setState(() => imageUrl = imgs[0] as String);
    }

    askAI(imgs[1] as File);

      
    }


  }



        Future<void> askAI(File imgs) async {

      String prompt = """This is a prescription . 
      give me the general summary of the prescription mainly medicine name , timing and doctor name in the schema 
      {summary:string}""";
      dynamic res = json.decode(await OurFirebase.askVertexAi(imgs!, prompt));
      
      descriptionController.text=res["summary"];
      print(res);
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Add Prescription".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _ImagePreview(
                  imageUrl: imageUrl,
                  onTap: (){
                    showImage(context, imageUrl!);
                  },
                ),

                const SizedBox(height: 10),

                Row(children: [
                  TextButton.icon(onPressed: _showImagePicker, 
                   icon: Icon(Icons.add_a_photo),
                                                label: Text("Upload Report".tr)
                  )
                ],),
                
                // searchBox(
                //   "Select Type of Prescription",
                //   prescriptionTypes,
                //   (value) => setState(() => prescriptionType = value),
                // ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration:  InputDecoration(
                    labelText: "Write Description".tr,
                    border:const OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter description'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _addPrescription,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: isLoading
                      ? const CircularProgressIndicator()
                      :  Text("ADD PRESCRIPTION".tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagePickerButton extends StatelessWidget {
  final String icon;
  final Color color;
  final String tooltip;
  final VoidCallback onPressed;

  const _ImagePickerButton({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      tooltip: tooltip,
      onPressed: onPressed,
      backgroundColor: color,
      child: Image.asset(
        icon,
        scale: 16,
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;

  const _ImagePreview({
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(imageUrl!=null){
        showImage(context, imageUrl!);}
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: imageUrl == null
            ?  Center(
                child: Text(
                  "Click to Add Image".tr,
                  style: TextStyle(fontSize: 18),
                ),
              )
            : CachedNetworkImage(
                imageUrl : imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) => const Center(
                  child: Text("Error loading image"),
                ),
              ),
      ),
    );
  }
}