
import 'package:allobaby/API/Requests/ReportAPI.dart';
import 'package:allobaby/Components/Loadingbar.dart';
import 'package:allobaby/Components/show_custom_dialog.dart';
import 'package:allobaby/Components/snackbar.dart';
import 'package:allobaby/Screens/Settings/EditProfile.dart';
import 'package:allobaby/features/Report/EditReport.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

class ViewReport extends StatelessWidget {
  final Map<String, dynamic> reportDetails;

  const ViewReport({super.key, required this.reportDetails});



  void deleteReport() async {

   bool req =  await Reportapi.deleteReport(reportDetails["id"]);

   if(req){
    Get.back();
    showToast("Deleted Successfully !", true);
   }else {
    showToast("Unable to Delete !", false);
   }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> details = 
    reportDetails["details"] 
    ?? {};
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Details'.tr),
        elevation: 0,
        actions: [
          IconButton(onPressed:(){

            showCustomDialog(context: context, title: "Delete Report", subtitle: "Are you sure to delete this report ?", onActionPressed: ()async{
           await  Loadingbar.use("Deleting Report", deleteReport);
            Navigator.of(context).pop();
            });


          }, icon: const Icon(Icons.delete)),

          IconButton(onPressed: ()=> Get.to(()=> EditReport(reportDetails: reportDetails,)), icon: const Icon(Icons.edit)),
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            GestureDetector(
              onTap: () => _showFullScreenImage(context),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                        reportDetails['imageurl'] ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error, size: 40, color: Colors.grey),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.zoom_in, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Report Type
                  Text(
                    reportDetails['report_type'] ?? 'Unknown Report Type',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Date and Phone
                  Row(
                    children: [
                      Expanded(
                        child: 
                        _buildInfoCard(
                          icon: Icons.calendar_today,
                          title: 'Date'.tr,
                          content: _formatDate(reportDetails['created']),
                        ),
                      ),
                      SizedBox(width: 16),
                      // Expanded(
                      //   child: _buildInfoCard(
                      //     icon: Icons.phone,
                      //     title: 'Phone',
                      //     content: reportDetails['phone'] ?? 'N/A',
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Description
                  _buildSection(
                    title: 'Description'.tr,
                    content: reportDetails['description']==null || reportDetails['description']=="" ? 'No description available'.tr
                    : reportDetails['description']
                    ,
                  ),
                  SizedBox(height: 16),

                  // Details
                  if (details.isNotEmpty) ...[
                    Text(
                      'Test Results'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...details.entries.map((entry) => _buildDetailItem(
                      key: entry.key,
                      value: entry.value.toString(),
                    )).toList(),
                    SizedBox(height: 16),
                  ],

                  // Action Buttons
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: OutlinedButton.icon(
                  //         icon: Icon(Icons.delete, color: Colors.red),
                  //         label: Text('DELETE'),
                  //         style: OutlinedButton.styleFrom(
                  //           foregroundColor: Colors.red,
                  //           side: BorderSide(color: Colors.red),
                  //           padding: EdgeInsets.symmetric(vertical: 12),
                  //         ),
                  //         onPressed: () => _showDeleteConfirmation(context),
                  //       ),
                  //     ),
                  //     SizedBox(width: 16),
                  //     Expanded(
                  //       child: ElevatedButton.icon(
                  //         icon: Icon(Icons.edit),
                  //         label: Text('EDIT'),
                  //         style: ElevatedButton.styleFrom(
                  //           padding: EdgeInsets.symmetric(vertical: 12),
                  //         ),
                  //         onPressed: () {
                  //           // Implement edit functionality
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

Widget _buildDetailItem({required String key, required String value}) {
  // Convert the key to a more readable format
  String formattedKey = key
    .split(RegExp('(?=[A-Z])'))
    .map((word) => word.toUpperCase())
    .join(' ');

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            formattedKey,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

  void _showFullScreenImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: Stack(
          children: [
            InteractiveViewer(
              child: Center(
                child: reportDetails['imageurl'] !=null ? Image.network(reportDetails['imageurl']):
                Text("Image Not Uploaded"),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Report'),
        content: Text('Are you sure you want to delete this report?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              // Implement delete functionality
              Navigator.pop(context);
            },
            child: Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}