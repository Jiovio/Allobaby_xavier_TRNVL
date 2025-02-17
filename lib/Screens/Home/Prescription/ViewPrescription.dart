import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/image_viewer.dart';
import 'package:allobaby/Components/show_custom_dialog.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:get/get.dart';

class ViewPrescription extends StatelessWidget {
  final Map<String, dynamic> prescription;
  final String id;

  const ViewPrescription({
    Key? key,
    required this.prescription,
    required this.id
  }) : super(key: key);


 void deletePrescription() async {


  // print(prescription);

  // final req =  await Userapi.detetePrescription(prescription["id"]);

  try {

  await FirebaseFirestore.instance
                  .collection('Prescription').doc(id).delete();

  Get.back();

   showToast("Deleted Prescription successfully !", true);

   
    
  } catch (e) {

     showToast("Failed to Delete Prescription", true);
    
  }




  // if(req==false){
  //   showToast("Failed to Delete Prescription", true);

    
  // }else{
  //   showToast("Deleted Prescription successfully !", true);
  // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("View Prescription".tr),


        actions: [
          IconButton(onPressed: (){
            showCustomDialog(context: context, 
            title: "Delete Prescription", 
            subtitle: "Are you sure to delete the prescription ?", 
            onActionPressed: () async {
             await  Loadingbar.use("Deleting Prescription", deletePrescription);

             Navigator.of(context).pop();

              
            },);
          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:() {
                  showImage(context, prescription['imageUrl']);
                },
                child: Container(
                  
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    prescription['imageUrl'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>  Center(
                      child: Text("Error loading image".tr),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Prescription Type Box
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(15),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //        Text(
              //         "Prescription Type".tr,
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 12,
              //         ),
              //       ),
              //       const SizedBox(height: 5),
              //       Text(
              //         prescription['prescriptionType'],
              //         style: const TextStyle(
              //           fontSize: 16,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              
              const SizedBox(height: 20),
              
              // Date Added Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Date Added".tr,
                      style:const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      prescription['createdAt'].toDate().toString().split(' ')[0],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Description Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      "Description".tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      prescription['description'] ?? 'No description available'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}