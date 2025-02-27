import 'dart:convert';

import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Config/OurFirebase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class MedicalReportPage extends StatefulWidget {
  final Map<String, dynamic> reportData;
  final String patientId;
  final Map<String, dynamic> appointmentDetails; // Changed to dynamic to match your data structure
  final DateTime date;
  final Map<String, dynamic> userDetails;

  const MedicalReportPage({
    Key? key,
    required this.reportData,
    required this.patientId,
    required this.appointmentDetails,
    required this.date,
    required this.userDetails
  }) : super(key: key);

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  bool loading = true;
  String summary = "No Summary Available";

  void generateSummary() async {
    String prompt = "data : ${json.encode(widget.reportData)} . summarize this data in 100 words..";

    try {
      String? summ = await OurFirebase.getTextResonse(prompt);
      print(summ);
      summary = summ ?? "No Report Available";
    } catch (e) {
      Fluttertoast.showToast(msg: "Network Error");
    }

    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    generateSummary();
  }

  @override
  Widget build(BuildContext context) {
    final symptoms = widget.reportData['symptoms'] == null ? null : widget.reportData['symptoms'] as List<dynamic>;
    final vitals = widget.reportData['vitals'] == null ? null : widget.reportData['vitals'] as Map<String, dynamic>;
    final hemoglobinValue = widget.reportData['hemoglobinValue'];
    final alphaminePresent = widget.reportData['alphaminePresent'];
    final sugarPresent = widget.reportData['sugarPresent'];
    final glucose = widget.reportData['glucose'];
    final kickCount = widget.reportData['kickCount'];
    final heartRate = widget.reportData['heartRate'];
    final fetalPresentation = widget.reportData['fetalPresentation'];
    final fetalMovement = widget.reportData['fetalMovement'];
    final placenta = widget.reportData['placenta'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Screening Report'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              // Generate and share PDF
              final pdfFile = await _generatePDF();

              print(pdfFile);
              if (pdfFile != null) {
                await Share.shareXFiles([XFile(pdfFile.path)], text: 'Medical Report');
              }
            },
          ),
        ],
      ),
      body: Scaffold(
        body: 
        loading ?
        Center(child: CircularProgressIndicator(),) :
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Report header
                _buildHeader(context),
                
                const SizedBox(height: 20),
                
                // Patient and Doctor Info
                _buildInfoSection(context),
                
                const SizedBox(height: 20),
                
                // Appointment Details
                _buildAppointmentDetails(context),
                
                const SizedBox(height: 20),
                
                // AI Summary
                _buildAISummary(summary),
                
                const SizedBox(height: 20),
                
                // Symptoms
                if(symptoms != null)
                _buildSection(
                  title: 'Symptoms',
                  child: Wrap(
                    spacing: 8,
                    children: symptoms.map((symptom) => Chip(
                      label: Text(symptom),
                    )).toList(),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Vital Signs
                if(vitals != null)
                _buildSection(
                  title: 'Vital Signs',
                  child: Column(
                    children: [
                      if(vitals['bloodPressureH'] != null && vitals['bloodPressureL'] != null)
                        _buildVitalRow('Blood Pressure', '${vitals['bloodPressureH']}/${vitals['bloodPressureL']} mmHg'),

                      if(vitals['temperature'] != null && vitals['temperatureMetric'] != null)
                        _buildVitalRow('Temperature', '${vitals['temperature']} ${vitals['temperatureMetric']}'),

                      if(vitals['bloodSaturationBW'] != null && vitals['bloodSaturationAW'] != null)
                        _buildVitalRow('Blood Saturation (Before/After Walking)', '${vitals['bloodSaturationBW']}% / ${vitals['bloodSaturationAW']}%'),

                      if(vitals['heartRateBW'] != null && vitals['heartRateAW'] != null)
                        _buildVitalRow('Heart Rate (Before/After Walking)', '${vitals['heartRateBW']} / ${vitals['heartRateAW']} bpm'),

                      if(vitals['bmiHeight'] != null && vitals['bmiWeight'] != null)
                        _buildVitalRow('BMI Details', 'Height: ${vitals['bmiHeight']} cm, Weight: ${vitals['bmiWeight']} kg'),

                      if(vitals['respiratoryRate'] != null)
                        _buildVitalRow('Respiratory Rate', '${vitals['respiratoryRate']} breaths/min'),

                      if(vitals['hB'] != null)
                        _buildVitalRow('Hemoglobin', '${vitals['hB']} g/dL'),

                      if(vitals['bloodGlucoseBF'] != null && vitals['bloodGlucoseAF'] != null)
                        _buildVitalRow('Blood Glucose (Before/After Food)', '${vitals['bloodGlucoseBF']} / ${vitals['bloodGlucoseAF']} mg/dL'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Additional Tests
                _buildSection(
                  title: 'Additional Tests',
                  child: Column(
                    children: [
                      if(hemoglobinValue != null)
                        _buildVitalRow('Hemoglobin Value', '${hemoglobinValue} g/dL'),
                      if(sugarPresent != null)
                        _buildVitalRow('Sugar Present', sugarPresent),
                      if(glucose != null)
                        _buildVitalRow('Glucose', '${glucose} mg/dL'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Fetal Assessment (if applicable)
                _buildSection(
                  title: 'Fetal Assessment',
                  child: Column(
                    children: [
                      if(kickCount != null)
                        _buildVitalRow('Kick Count', '${kickCount}'),
                      if(heartRate != null)
                        _buildVitalRow('Heart Rate', '${heartRate} bpm'),
                      if(fetalPresentation != null)
                        _buildVitalRow('Fetal Presentation', fetalPresentation),
                      if(fetalMovement != null)
                        _buildVitalRow('Fetal Movement', fetalMovement),
                      if(placenta != null)
                        _buildVitalRow('Placenta', placenta),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Prescription Section
                _buildPrescriptionSection(context),
                
                const SizedBox(height: 20),
                
                // Lab Requests Section
                _buildLabRequestsSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        Text(
          'Self Screening Report',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'Date: ${DateFormat('MMMM dd, yyyy').format(widget.date)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Divider(thickness: 2),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Patient Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Patient Name: ${widget.patientId}'),
                  const SizedBox(height: 8),
                  Text('Patient Age: ${widget.userDetails["age"]}'),
                  const SizedBox(height: 8),
                  Text('Blood Group: ${widget.userDetails["bloodGroup"]}'),
                  const SizedBox(height: 8),
                  Text('Pregnancy Status: ${widget.userDetails["pregnancyStatus"]}'),
                  const SizedBox(height: 8),
                  Text('BMI: ${_calculateBMI().toStringAsFixed(1)}'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildAppointmentDetails(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Appointment Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            
            // Get data safely with null checks
            if(widget.appointmentDetails['doctor'] != null && widget.appointmentDetails['doctor']['name'] != null)
              _buildAppointmentRow('Doctor', widget.appointmentDetails['doctor']['name']),
              
            if(widget.appointmentDetails['appointment_date'] != null)
              _buildAppointmentRow('Appointment Date', widget.appointmentDetails['appointment_date']),
              
            if(widget.appointmentDetails['start_time'] != null && widget.appointmentDetails['end_time'] != null)
              _buildAppointmentRow('Time', '${widget.appointmentDetails['start_time']} - ${widget.appointmentDetails['end_time']}'),
              
            if(widget.appointmentDetails['status'] != null)
              _buildAppointmentRow('Status', widget.appointmentDetails['status']),
              
            if(widget.appointmentDetails['reason'] != null)
              _buildAppointmentRow('Reason', widget.appointmentDetails['reason']),
              
            if(widget.appointmentDetails['healthStatus'] != null)
              _buildAppointmentRow('Health Status', widget.appointmentDetails['healthStatus']),
              
            if(widget.appointmentDetails['summary'] != null)
              _buildAppointmentRow('Doctor\'s Summary', _formatSummary(widget.appointmentDetails['summary'])),
              
            if(widget.appointmentDetails['next_appointment_date'] != null)
              _buildAppointmentRow('Next Appointment', widget.appointmentDetails['next_appointment_date']),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionSection(BuildContext context) {
    // Check if prescription data exists
    if (widget.appointmentDetails['prescription'] == null || 
        !(widget.appointmentDetails['prescription'] is List) || 
        (widget.appointmentDetails['prescription'] as List).isEmpty) {
      return Container(); // Return empty container if no prescription data
    }
    
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medication, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Prescribed Medications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            
            Column(
              children: (widget.appointmentDetails['prescription'] as List).map<Widget>((med) {
                // Handle different possible data structures
                if (med is Map) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Medication: ${med['tablets'] ?? 'Unknown'}', 
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Units per dose: ${med['units'] ?? 'Not specified'}'),
                        const SizedBox(height: 4),
                        Text('Timings: ${med['Timings'] ?? 'Not specified'}'),
                      ],
                    ),
                  );
                } else {
                  return ListTile(title: Text(med.toString()));
                }
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabRequestsSection(BuildContext context) {
    // Check if lab requests data exists
    if (widget.appointmentDetails['labrequest'] == null || 
        !(widget.appointmentDetails['labrequest'] is List) || 
        (widget.appointmentDetails['labrequest'] as List).isEmpty) {
      return Container(); // Return empty container if no lab request data
    }
    
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.science, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Lab Tests Requested',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (widget.appointmentDetails['labrequest'] as List).map<Widget>((test) {
                return Chip(
                  label: Text(test.toString()),
                  backgroundColor: Colors.blue.shade100,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildVitalRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildAISummary(String summary) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'AI Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              summary,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateBMI() {
    if(widget.reportData.containsKey("vitals")
      && widget.reportData["vitals"].containsKey("bmiHeight")
      && widget.reportData["vitals"].containsKey("bmiWeight")
    ) {
      double heightInMeters = ((widget.reportData['vitals']['bmiHeight']) ?? 100) / 100;
      double weightInKg = widget.reportData['vitals']['bmiWeight'];
      return weightInKg / (heightInMeters * heightInMeters);
    }
    return 0.0;
  }

  // Helper method to format the summary text by adding spaces
  String _formatSummary(String rawSummary) {
    // This will format the summary by adding spaces between words if they're concatenated
    if (rawSummary == null) return "No summary available";
    
    // Regular expression to add spaces between words
    return rawSummary.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}'
    );
  }

  // PDF Functions
  Future<File?> _generatePDF() async {
    final pdf = pw.Document();
    
    // Get necessary data
    final symptoms = widget.reportData.containsKey('symptoms') 
        ? (widget.reportData['symptoms'] as List<dynamic>?) ?? []
        : <dynamic>[];
    
    final vitals = widget.reportData.containsKey('vitals')
        ? (widget.reportData['vitals'] as Map<String, dynamic>?) ?? {}
        : <String, dynamic>{};
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'Health Assessment Report',
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Date: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}',
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.Divider(thickness: 2),
                ],
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Patient Info
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Patient Information',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text('Patient ID: ${widget.patientId}'),
                        pw.SizedBox(height: 4),
                        pw.Text('Patient Age: ${widget.userDetails["age"]}'),
                        pw.SizedBox(height: 4),
                        pw.Text('Blood Group: ${widget.userDetails["bloodGroup"]}'),
                        pw.SizedBox(height: 4),
                        pw.Text('Pregnancy Status: ${widget.userDetails["pregnancyStatus"]}'),
                        pw.SizedBox(height: 4),
                        if(widget.reportData.containsKey("vitals"))
                        pw.Text('BMI: ${_calculateBMI().toStringAsFixed(1)}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            pw.SizedBox(height: 20),
            
            // Appointment Details
            _buildPDFSection(
              title: 'Appointment Details',
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if(widget.appointmentDetails['doctor'] != null && widget.appointmentDetails['doctor']['name'] != null)
                    _buildPDFDetailRow('Doctor', widget.appointmentDetails['doctor']['name']),
                    
                  if(widget.appointmentDetails['appointment_date'] != null)
                    _buildPDFDetailRow('Appointment Date', widget.appointmentDetails['appointment_date']),
                    
                  if(widget.appointmentDetails['start_time'] != null && widget.appointmentDetails['end_time'] != null)
                    _buildPDFDetailRow('Time', '${widget.appointmentDetails['start_time']} - ${widget.appointmentDetails['end_time']}'),
                    
                  if(widget.appointmentDetails['status'] != null)
                    _buildPDFDetailRow('Status', widget.appointmentDetails['status']),
                    
                  if(widget.appointmentDetails['reason'] != null)
                    _buildPDFDetailRow('Reason', widget.appointmentDetails['reason']),
                    
                  if(widget.appointmentDetails['healthStatus'] != null)
                    _buildPDFDetailRow('Health Status', widget.appointmentDetails['healthStatus']),
                    
                  if(widget.appointmentDetails['summary'] != null)
                    _buildPDFDetailRow('Doctor\'s Summary', _formatSummary(widget.appointmentDetails['summary'])),
                    
                  if(widget.appointmentDetails['next_appointment_date'] != null)
                    _buildPDFDetailRow('Next Appointment', widget.appointmentDetails['next_appointment_date']),
                ],
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // AI Summary
            _buildPDFSection(
              title: 'AI Summary',
              child: pw.Container(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(summary),
              ),
            ),

            pw.SizedBox(height: 20),
            
            // Symptoms
            if(widget.reportData.containsKey("symptoms"))
            _buildPDFSection(
              title: 'Symptoms',
              child: pw.Wrap(
                spacing: 8,
                children: symptoms.map((symptom) => pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: pw.BoxDecoration(
                    color: const PdfColor(0.8, 0.9, 1.0),
                    borderRadius: pw.BorderRadius.circular(12),
                  ),
                  child: pw.Text(symptom),
                )).toList(),
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            if(widget.reportData.containsKey("vitals")) 
              _buildPDFSection(
                title: 'Vital Signs',
                child: pw.Column(
                  children: [
                    if(vitals['bloodPressureH'] != null && vitals['bloodPressureL'] != null)
                      _buildPDFVitalRow('Blood Pressure', '${vitals['bloodPressureH']}/${vitals['bloodPressureL']} mmHg'),
                    
                    if(vitals['temperature'] != null && vitals['temperatureMetric'] != null)
                      _buildPDFVitalRow('Temperature', '${vitals['temperature']} ${vitals['temperatureMetric']}'),
                    
                    if(vitals['bloodSaturationBW'] != null && vitals['bloodSaturationAW'] != null)
                      _buildPDFVitalRow('Blood Saturation (Before/After Walking)', '${vitals['bloodSaturationBW']}% / ${vitals['bloodSaturationAW']}%'),
                    
                    if(vitals['heartRateBW'] != null && vitals['heartRateAW'] != null)
                      _buildPDFVitalRow('Heart Rate (Before/After Walking)', '${vitals['heartRateBW']} / ${vitals['heartRateAW']} bpm'),
                    
                    if(vitals['bmiHeight'] != null && vitals['bmiWeight'] != null)
                      _buildPDFVitalRow('BMI Details', 'Height: ${vitals['bmiHeight']} cm, Weight: ${vitals['bmiWeight']} kg'),
                    
                    if(vitals['respiratoryRate'] != null)
                      _buildPDFVitalRow('Respiratory Rate', '${vitals['respiratoryRate']} breaths/min'),
                    
                    if(vitals['hB'] != null)
                      _buildPDFVitalRow('Hemoglobin', '${vitals['hB']} g/dL'),
                    
                    if(vitals['bloodGlucoseBF'] != null && vitals['bloodGlucoseAF'] != null)
                      _buildPDFVitalRow('Blood Glucose (Before/After Food)', '${vitals['bloodGlucoseBF']} / ${vitals['bloodGlucoseAF']} mg/dL'),
                  ],
                ),
              ),
            
            pw.SizedBox(height: 20),
            
            // Additional Tests
            _buildPDFSection(
              title: 'Additional Tests',
              child: pw.Column(
                children: [
                  _buildPDFVitalRow('Hemoglobin Value', '${widget.reportData['hemoglobinValue'] ?? "No Data Provided"} ${widget.reportData['hemoglobinValue'] != null ? "g/dL" : ""}'),
                  _buildPDFVitalRow('Alphamine Present', widget.reportData['alphaminePresent'] ?? "No Data Provided"),
                  _buildPDFVitalRow('Sugar Present', widget.reportData['sugarPresent'] ?? "No Data Provided"),
                  _buildPDFVitalRow('Glucose', '${widget.reportData['glucose'] ?? "No Data Provided"} ${widget.reportData['glucose'] != null ? "mg/dL" : ""}'),
                ],
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            _buildPDFSection(
              title: 'Fetal Assessment',
              child: pw.Column(
                children: [
                  _buildPDFVitalRow('Kick Count', '${widget.reportData['kickCount'] ?? "No Data Provided"}'),
                  _buildPDFVitalRow('Heart Rate', '${widget.reportData['heartRate'] ?? "No Data Provided"} ${widget.reportData['heartRate'] != null ? "bpm" : ""}'),
                  _buildPDFVitalRow('Fetal Presentation', widget.reportData['fetalPresentation'] ?? "No Data Provided"),
                  _buildPDFVitalRow('Fetal Movement', widget.reportData['fetalMovement'] ?? "No Data Provided"),
                  _buildPDFVitalRow('Placenta', widget.reportData['placenta'] ?? "No Data Provided"),
                ],
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Prescribed Medications
            if (widget.appointmentDetails['prescription'] != null && 
                widget.appointmentDetails['prescription'] is List && 
                (widget.appointmentDetails['prescription'] as List).isNotEmpty)
              _buildPDFSection(
                title: 'Prescribed Medications',
                child: pw.Column(
                  children: [
                    pw.SizedBox(height: 8),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      children: [
                        // Table header
                        pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: PdfColor(0.9, 0.9, 0.9),
                          ),
                          children: [
                            pw.Padding(
  padding: const pw.EdgeInsets.all(5),
  child: pw.Text('Medication', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
),
pw.Padding(
  padding: const pw.EdgeInsets.all(5),
  child: pw.Text('Units', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
),
pw.Padding(
  padding: const pw.EdgeInsets.all(5),
  child: pw.Text('Timings', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
)
]
),
// Table rows for each medication
...(widget.appointmentDetails['prescription'] as List).map((med) {
  if (med is Map) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(med['tablets'] ?? 'Unknown'),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(med['units']?.toString() ?? 'Not specified'),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(med['Timings'] ?? 'Not specified'),
        ),
      ]
    );
  } else {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(med.toString()),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(''),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(''),
        ),
      ]
    );
  }
}).toList(),
]),
]),
),

// Lab Tests Section
if (widget.appointmentDetails['labrequest'] != null && 
    widget.appointmentDetails['labrequest'] is List && 
    (widget.appointmentDetails['labrequest'] as List).isNotEmpty)
  _buildPDFSection(
    title: 'Lab Tests Requested',
    child: pw.Wrap(
      spacing: 8,
      runSpacing: 8,
      children: (widget.appointmentDetails['labrequest'] as List).map<pw.Widget>((test) {
        return pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: pw.BoxDecoration(
            color: const PdfColor(0.8, 0.9, 1.0),
            borderRadius: pw.BorderRadius.circular(12),
          ),
          child: pw.Text(test.toString()),
        );
      }).toList(),
    ),
  ),
];
},
)
);


    try {
      // Save PDF to device
      final tempDir = await getTemporaryDirectory();
      final reportName = 'medical_report_${widget.patientId}_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf';
      final file = File('${tempDir.path}/$reportName');
      await file.writeAsBytes(await pdf.save());
      return file;
    } catch (e) {
      print('Error saving PDF: $e');
      return null;
    }
}

// Helper methods for PDF
pw.Widget _buildPDFSection({required String title, required pw.Widget child}) {
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(),
      borderRadius: pw.BorderRadius.circular(5),
    ),
    padding: const pw.EdgeInsets.all(10),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Divider(),
        pw.SizedBox(height: 8),
        child,
      ],
    ),
  );
}

pw.Widget _buildPDFVitalRow(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Text(value),
        ),
      ],
    ),
  );
}

pw.Widget _buildPDFDetailRow(String label, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 2),
        pw.Text(value),
        pw.SizedBox(height: 2),
      ],
    ),
  );
}
}