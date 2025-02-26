import 'package:flutter/material.dart';

class ScreeningReportPage extends StatelessWidget {
  final Map<String, dynamic> reportData = {
    "date": "2025-02-26T12:00:00Z",
    "data": {
      "hemoglobinValue": 14,
      "alphaminePresent": "No",
      "sugarPresent": "No",
      "glucose": 70.0,
      "kickCount": 0,
      "heartRate": 141,
      "fetalPresentation": "Cephalic (at the time of scan)",
      "fetalMovement": "Present",
      "placenta": "More (AFI-16-17 cm)\nPosterior, not low-lying, Grade - II maturity.",
      "vitals": {
        "bloodPressureH": 123,
        "bloodPressureL": 93,
        "temperature": 11.0,
        "hB": 12.5,
        "bmiHeight": 153,
        "bmiWeight": 54.0,
        "bloodGlucoseBF": 147.0
      },
      "symptoms": ["Body pain", "Burning Stomach", "Cold cough"]
    },
    "user": {
      "name": "Vijaya",
      "age": 30
    }
  };

  @override
  Widget build(BuildContext context) {
    final user = reportData["user"];
    final data = reportData["data"];
    final vitals = data["vitals"];

    return Scaffold(
      appBar: AppBar(title: Text("Screening Report")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("User Details"),
            _buildDetailRow("Name", user["name"]),
            _buildDetailRow("Age", "${user["age"]}"),
            Divider(),
            _buildSectionTitle("Vitals"),
            _buildDetailRow("Blood Pressure", "${vitals["bloodPressureH"]}/${vitals["bloodPressureL"]} mmHg"),
            _buildDetailRow("Temperature", "${vitals["temperature"]}°C"),
            _buildDetailRow("Hemoglobin", "${vitals["hB"]} g/dL"),
            _buildDetailRow("BMI", "${vitals["bmiWeight"]} kg / ${vitals["bmiHeight"]} cm"),
            _buildDetailRow("Blood Glucose (BF)", "${vitals["bloodGlucoseBF"]} mg/dL"),
            Divider(),
            _buildSectionTitle("Fetal Data"),
            _buildDetailRow("Heart Rate", "${data["heartRate"]} bpm"),
            _buildDetailRow("Fetal Presentation", data["fetalPresentation"]),
            _buildDetailRow("Fetal Movement", data["fetalMovement"]),
            _buildDetailRow("Placenta", data["placenta"]),
            Divider(),
            _buildSectionTitle("Symptoms"),
            ...data["symptoms"].map<Widget>((symptom) => ListTile(
                  leading: Icon(Icons.warning, color: Colors.red),
                  title: Text(symptom),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
