import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reportData = Get.arguments;

    String camelToProperCase(String camelCaseStr) {
  // This regex splits the string by uppercase letters
  final splitString = camelCaseStr.replaceAllMapped(
    RegExp(r'(?<!^)(?<!^)[A-Z]'),
    (Match match) => ' ${match.group(0)}',
  );

  // Capitalize the first letter of each word
  final capitalizedString = splitString
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');

  return capitalizedString;
}

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports List'),
      ),
      body: ListView.builder(
        itemCount: reportData.length,
        itemBuilder: (context, index) {
          final report = reportData[index];
          final image = base64Decode(report['reportFile']); 
          Map<String, dynamic> reportdetails = jsonDecode(report["details"]);

          List<String> keys = reportdetails.keys.toList();

          // print(report["reportId"]);

          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: Image.memory(image, width: 60, height: 60), 
              title: Text(report['reportType'],style: TextStyle(fontWeight: FontWeight.bold,fontSize:18),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in keys) 
                    Text("${camelToProperCase(item)} : ${reportdetails[item]}", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8), 
                  Text('Created: ${report['created']}'),
                  Text('Synced: ${report['synced'] == 1 ? 'Yes' : 'No'}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}
