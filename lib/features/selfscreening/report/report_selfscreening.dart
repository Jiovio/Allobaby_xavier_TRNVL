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
  final Map<String, String> doctorDetails;
  final DateTime date;

  const MedicalReportPage({
    Key? key,
    required this.reportData,
    required this.patientId,
    required this.doctorDetails,
    required this.date
  }) : super(key: key);

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {


    // Extract data from the report

    bool loading = true;


    String summary = "No Summary Available";

    void generateSummary() async {



      // loading = false;

      // setState(() {
        
      // });

      // return;

      String prompt = "data : ${json.encode(widget.reportData)} . summarize this data in 100 words..";

      try {

      String? summ = await OurFirebase.getTextResonse(prompt);

      print(summ);

      summary = summ ?? "No Report Available";
        
      } catch (e) {

        Fluttertoast.showToast(msg: "Network Error");
        
      }




      loading = false;


      setState(() {
        
      });


    }


    @override
    void initState(){
      super.initState();

      generateSummary();
    }


  @override
  Widget build(BuildContext context) {


        final symptoms = widget.reportData['symptoms'] == null ? null : widget.reportData['symptoms'] as List<dynamic> ;
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
          // IconButton(
          //   icon: const Icon(Icons.picture_as_pdf),
          //   onPressed: () async {
          //     await _generateAndDownloadPDF(context);
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              // Generate and share PDF
              final pdfFile = await _generatePDF();
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
        
                              // AI Summary
                _buildAISummary(summary),
                
                const SizedBox(height: 20),
                
                // Symptoms
                if(symptoms!=null)
                _buildSection(
                  title: 'Symptoms',
                  child: Wrap(
                    spacing: 8,
                    children: symptoms.map((symptom) => Chip(
                      label: Text(symptom),
                      // backgroundColor: Colors.blue.shade100,
                    )).toList(),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Vital Signs
                if(vitals!=null)
                _buildSection(
                  title: 'Vital Signs',
                  child: Column(
                    children: [
                      _buildVitalRow('Blood Pressure', '${vitals['bloodPressureH']}/${vitals['bloodPressureL']} mmHg'),
                      _buildVitalRow('Temperature', '${vitals['temperature']} ${vitals['temperatureMetric']}'),
                      _buildVitalRow('Blood Saturation (Before/After Walking)', '${vitals['bloodSaturationBW']}% / ${vitals['bloodSaturationAW']}%'),
                      _buildVitalRow('Heart Rate (Before/After Walking)', '${vitals['heartRateBW']} / ${vitals['heartRateAW']} bpm'),
                      _buildVitalRow('BMI Details', 'Height: ${vitals['bmiHeight']} cm, Weight: ${vitals['bmiWeight']} kg'),
                      _buildVitalRow('Respiratory Rate', '${vitals['respiratoryRate']} breaths/min'),
                      _buildVitalRow('Hemoglobin', '${vitals['hB']} g/dL'),
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
                      _buildVitalRow('Hemoglobin Value', '${hemoglobinValue?? "Not Provided"} g/dL'),
                      _buildVitalRow('Sugar Present', sugarPresent?? "Not Provided"),
                      _buildVitalRow('Glucose', '${glucose ?? "Not Provided"} mg/dL'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Fetal Assessment (if applicable)
                _buildSection(
                  title: 'Fetal Assessment',
                  child: Column(
                    children: [
                      _buildVitalRow('Kick Count', '${kickCount??"Not Provided"}'),
                      _buildVitalRow('Heart Rate', '${heartRate??"Not Provided"} bpm'),
                      _buildVitalRow('Fetal Presentation', fetalPresentation??"Not Provided"),
                      _buildVitalRow('Fetal Movement', fetalMovement??"Not Provided"),
                      _buildVitalRow('Placenta', placenta??"Not Provided"),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
        
                
        
                
                // const SizedBox(height: 40),
                
                // // PDF Download Button
                // Center(
                //   child: ElevatedButton.icon(
                //     icon: const Icon(Icons.download),
                //     label: const Text('Download PDF Report'),
                //     style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                //     ),
                //     onPressed: () async {
                //       await _generateAndDownloadPDF(context);
                //     },
                //   ),
                // ),
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(Icons.local_hospital, size: 32, color: Theme.of(context).primaryColor),
        //     const SizedBox(width: 10),
        //     Text(
        //       'Medical Center',
        //       style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        //         fontWeight: FontWeight.bold,
        //         color: Theme.of(context).primaryColor,
        //       ),
        //     ),
        //   ],
        // ),
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
                  const SizedBox(height: 4),
                  Text('BMI: ${_calculateBMI().toStringAsFixed(1)}'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        Expanded(child: Container(),)
        // Expanded(
        //   child: Card(
        //     elevation: 2,
        //     child: Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const Text(
        //             'Doctor Information',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 16,
        //             ),
        //           ),
        //           const SizedBox(height: 8),
        //           Text('Name: ${doctorDetails['name']}'),
        //           const SizedBox(height: 4),
        //           Text('Specialization: ${doctorDetails['specialization']}'),
        //           const SizedBox(height: 4),
        //           Text('License: ${doctorDetails['license']}'),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
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

  Widget _buildAISummary(String summary) {
    return Card(
      elevation: 3,
      // color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Row(
              children: const [
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
              // _generateAISummary(),
              summary,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 4),
            const Text('Doctor\'s Signature'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 4),
            const Text('Patient\'s Signature'),
          ],
        ),
      ],
    );
  }

  double _calculateBMI() {

      if(widget.reportData.containsKey("vitals")
      && widget.reportData["vitals"].containsKey("bmiHeight")
      && widget.reportData["vitals"].containsKey("bmiWeight")
      ){

            double heightInMeters = ((widget.reportData['vitals']['bmiHeight']) ?? 100) / 100;
    double weightInKg = widget.reportData['vitals']['bmiWeight'];
    return weightInKg / (heightInMeters * heightInMeters);


      }

      return 0.0;


  }

  // String _generateAISummary() {
  //   // Get necessary values
  //     final symptoms = widget.reportData['symptoms'] == null ? null : widget.reportData['symptoms'] as List<dynamic> ;
  //   final vitals = widget.reportData['vitals'] == null ? null : widget.reportData['vitals'] as Map<String, dynamic>;
  //   final bloodPressureH = vitals?['bloodPressureH'];
  //   final bloodPressureL = vitals?['bloodPressureL'];
  //   final temperature = vitals?['temperature'];
  //   final bloodGlucoseBF = vitals?['bloodGlucoseBF'];
  //   final sugarPresent = widget.reportData['sugarPresent'];
    
  //   // Generate summary
  //   String summary = "Based on the examination, the patient is presenting with ";

  //   if(symptoms!=null){
  //     summary += symptoms.join(", ") + ". ";
  //   }
    
    
  //   // Blood pressure assessment
  //   if (bloodPressureH >= 120 && bloodPressureH < 130 && bloodPressureL < 80) {
  //     summary += "Blood pressure is elevated. ";
  //   } else if (bloodPressureH >= 130 || bloodPressureL >= 80) {
  //     summary += "Blood pressure readings indicate hypertension. ";
  //   } else if (bloodPressureH < 90 || bloodPressureL < 60) {
  //     summary += "Blood pressure is on the lower side. ";
  //   } else {
  //     summary += "Blood pressure is within normal range. ";
  //   }
    
  //   // Temperature assessment
  //   if (temperature < 36.5) {
  //     summary += "Body temperature is below normal. ";
  //   } else if (temperature > 37.5) {
  //     summary += "Patient is presenting with fever. ";
  //   } else {
  //     summary += "Temperature is normal. ";
  //   }
    
  //   // Blood glucose assessment
  //   if (bloodGlucoseBF > 140 || sugarPresent == "Yes") {
  //     summary += "Blood glucose levels are elevated, suggesting the need for diabetes management. ";
  //   }
    
  //   // Add recommendations
  //   summary += "\n\nRecommendations: ";
    
  //   if (symptoms.contains("Body pain")) {
  //     summary += "Consider pain management therapy. ";
  //   }
    
  //   if (symptoms.contains("Burning Stomach")) {
  //     summary += "Evaluate for gastrointestinal issues, possibly GERD or gastritis. ";
  //   }
    
  //   if (symptoms.contains("Cold cough")) {
  //     summary += "Symptomatic treatment for respiratory condition. ";
  //   }
    
  //   if (bloodGlucoseBF > 140 || sugarPresent == "Yes") {
  //     summary += "Regular blood glucose monitoring and dietary consultation recommended. ";
  //   }
    
  //   return summary;
  // }

  // PDF Generation Functions
  Future<File?> _generatePDF() async {
    final pdf = pw.Document();
    
    // Get necessary data
    final symptoms = widget.reportData['symptoms'] as List<dynamic>;
    final vitals = widget.reportData['vitals'] as Map<String, dynamic>;
    
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
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.center,
                  //   children: [
                  //     pw.Text(
                  //       'Medical Center',
                  //       style: pw.TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: pw.FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // pw.SizedBox(height: 8),
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
            
            // Patient and Doctor Info
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
                        if(widget.reportData.containsKey("vitals"))
                        pw.Text('BMI: ${_calculateBMI().toStringAsFixed(1)}'),
                      ],
                    ),
                  ),
                ),
                // pw.SizedBox(width: 16),
                // pw.Expanded(
                //   child: pw.Container(
                //     padding: const pw.EdgeInsets.all(10),
                //     decoration: pw.BoxDecoration(
                //       border: pw.Border.all(),
                //       borderRadius: pw.BorderRadius.circular(5),
                //     ),
                //     child: pw.Column(
                //       crossAxisAlignment: pw.CrossAxisAlignment.start,
                //       children: [
                //         pw.Text(
                //           'Doctor Information',
                //           style: pw.TextStyle(
                //             fontWeight: pw.FontWeight.bold,
                //             fontSize: 14,
                //           ),
                //         ),
                //         pw.SizedBox(height: 8),
                //         pw.Text('Name: ${widget.doctorDetails['name']}'),
                //         pw.SizedBox(height: 4),
                //         pw.Text('Specialization: ${widget.doctorDetails['specialization']}'),
                //         pw.SizedBox(height: 4),
                //         pw.Text('License: ${widget.doctorDetails['license']}'),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
            
            pw.SizedBox(height: 20),


            
            // AI Summary
            _buildPDFSection(
              title: 'AI Summary',
              child: pw.Container(
                padding: const pw.EdgeInsets.all(8),
                // color: const PdfColor(0.9, 0.95, 1.0),
                child: pw.Text(
                  summary
                  // _generateAISummary()
                  
                  ),
              ),
            ),

            pw.SizedBox(height: 20),
            
            // Symptoms
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
            
            // Vital Signs
            _buildPDFSection(
              title: 'Vital Signs',
              child: pw.Column(
                children: [
                  _buildPDFVitalRow('Blood Pressure', '${vitals['bloodPressureH']}/${vitals['bloodPressureL']} mmHg'),
                  _buildPDFVitalRow('Temperature', '${vitals['temperature']} ${vitals['temperatureMetric']}'),
                  _buildPDFVitalRow('Blood Saturation (Before/After Walking)', '${vitals['bloodSaturationBW']}% / ${vitals['bloodSaturationAW']}%'),
                  _buildPDFVitalRow('Heart Rate (Before/After Walking)', '${vitals['heartRateBW']} / ${vitals['heartRateAW']} bpm'),
                  _buildPDFVitalRow('BMI Details', 'Height: ${vitals['bmiHeight']} cm, Weight: ${vitals['bmiWeight']} kg'),
                  _buildPDFVitalRow('Respiratory Rate', '${vitals['respiratoryRate']} breaths/min'),
                  _buildPDFVitalRow('Hemoglobin', '${vitals['hB']} g/dL'),
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
                  _buildPDFVitalRow('Hemoglobin Value', '${widget.reportData['hemoglobinValue']??"No Provided"} g/dL'),
                  _buildPDFVitalRow('Alphamine Present', widget.reportData['alphaminePresent']??"No Provided"),
                  _buildPDFVitalRow('Sugar Present', widget.reportData['sugarPresent']??"No Provided"),
                  _buildPDFVitalRow('Glucose', '${widget.reportData['glucose']??"No Provided"} mg/dL'),
                ],
              ),
            ),
            
            pw.SizedBox(height: 20),
            
            // Fetal Assessment
            _buildPDFSection(
              title: 'Fetal Assessment',
              child: pw.Column(
                children: [
                  _buildPDFVitalRow('Kick Count', '${widget.reportData['kickCount']}'),
                  _buildPDFVitalRow('Heart Rate', '${widget.reportData['heartRate']} bpm'),
                  _buildPDFVitalRow('Fetal Presentation', widget.reportData['fetalPresentation']),
                  _buildPDFVitalRow('Fetal Movement', widget.reportData['fetalMovement']),
                  _buildPDFVitalRow('Placenta', widget.reportData['placenta']),
                ],
              ),
            ),
            

            
            pw.SizedBox(height: 30),
            
            // Signature Section
            // pw.Row(
            //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            //   children: [
            //     pw.Column(
            //       crossAxisAlignment: pw.CrossAxisAlignment.center,
            //       children: [
            //         pw.Container(
            //           width: 150,
            //           height: 1,
            //           color: const PdfColor(0, 0, 0),
            //         ),
            //         pw.SizedBox(height: 4),
            //         pw.Text('Doctor\'s Signature'),
            //       ],
            //     ),
            //     pw.Column(
            //       crossAxisAlignment: pw.CrossAxisAlignment.center,
            //       children: [
            //         pw.Container(
            //           width: 150,
            //           height: 1,
            //           color: const PdfColor(0, 0, 0),
            //         ),
            //         pw.SizedBox(height: 4),
            //         pw.Text('Patient\'s Signature'),
            //       ],
            //     ),
            //   ],
            // ),
          ];
        },
      ),
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

  pw.Widget _buildPDFSection({required String title, required pw.Widget child}) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        // border: pw.Border.all(),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      padding: const pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
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
      padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
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

  Future<void> _generateAndDownloadPDF(BuildContext context) async {
    try {
      // Check storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission is required to save PDF')),
        );
        return;
      }
      
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generating PDF...')),
      );
      
      // Generate PDF
      final pdfFile = await _generatePDF();
      if (pdfFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to generate PDF')),
        );
        return;
      }
      
      // Save PDF to Downloads folder
      final downloadsDir = await getDownloadsDirectory() ?? await getExternalStorageDirectory();
      if (downloadsDir == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not access downloads directory')),
        );
        return;
      }
      
      final reportName = 'medical_report_${widget.patientId}_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf';
      final savedFile = await File(pdfFile.path).copy('${downloadsDir.path}/$reportName');
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF saved to ${savedFile.path}'),
          action: SnackBarAction(
            label: 'View',
            onPressed: () {
              // Add code to open the PDF file here
              // You can use plugins like open_file or url_launcher to open the file
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}

