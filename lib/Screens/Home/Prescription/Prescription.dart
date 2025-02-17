import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Home/Prescription/ViewPrescription.dart';
import 'package:allobaby/Screens/Home/Prescription/addprescription.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Prescription extends StatelessWidget {
  const Prescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prescription".tr)),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(
                          left: 20, right: 40, top: 14, bottom: 14)),
                  onPressed: () => Get.to(() => AddPrescription(),
                      transition: Transition.rightToLeft),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.camera),
                      Text("Scan and Add new Prescription.".tr.toUpperCase())
                    ],
                  ))),
          SizedBox(height: 10),
          
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Prescription')
                  .orderBy('createdAt', descending: true)
                  .where('userId', isEqualTo: Storage.getUserID())
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var prescriptions = snapshot.data!.docs;

                if (prescriptions.isEmpty) {
                  return Center(child: Text('No prescriptions found.'.tr));
                }

                return ListView.builder(
                  itemCount: prescriptions.length,
                  itemBuilder: (context, index) {
                    var prescription = prescriptions[index];

                    return Card(
                      elevation: 1,
                      shape: Border(left: BorderSide(color: PrimaryColor, width: 4)),
                      child: InkWell(
                        highlightColor: accentColor.withOpacity(0.1),
                        splashColor: accentColor.withOpacity(0.8),
onTap: () => Get.to(
  () => ViewPrescription(
    prescription: prescription.data() as Map<String, dynamic>,
    id : prescription.id
  ),
  transition: Transition.rightToLeft,
),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, right: 40, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              CachedNetworkImage(
                                imageUrl: prescription['imageUrl'],
                                height: 100,
                                width: 100,
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),

                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   prescription['prescriptionType'],
                                  //   style: TextStyle(
                                  //       fontSize: 20, fontWeight: FontWeight.w500),
                                  // ),
                                  // SizedBox(height: 8),
                                  Text(
                                    
                                    "${prescription['description'].length>30?prescription['description'].substring(0, 30):prescription['description']} ..." ?? 'No description',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    prescription['createdAt'].toDate().toString().split(' ')[0],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
