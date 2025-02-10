import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditReport extends StatefulWidget {
  final Map<String, dynamic> reportDetails;

  const EditReport({super.key, required this.reportDetails});

  @override
  _EditReportState createState() => _EditReportState();
}

class _EditReportState extends State<EditReport> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _reportTypeController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late Map<String, TextEditingController> _detailControllers;

  @override
  void initState() {
    super.initState();
    _reportTypeController =
        TextEditingController(text: widget.reportDetails['report_type'] ?? '');
    _descriptionController =
        TextEditingController(text: widget.reportDetails['description'] ?? '');
    _dateController =
        TextEditingController(text: widget.reportDetails['created'] ?? '');
    
    _detailControllers = {};
    if (widget.reportDetails['details'] != null) {
      (widget.reportDetails['details'] as Map<String, dynamic>)
          .forEach((key, value) {
        _detailControllers[key] = TextEditingController(text: value.toString());
      });
    }
  }

  @override
  void dispose() {
    _reportTypeController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _detailControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _saveReport() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedReport = {
        'report_type': _reportTypeController.text,
        'description': _descriptionController.text,
        'created': _dateController.text,
        'details': _detailControllers.map((key, controller) => MapEntry(key, controller.text)),
      };
      print(updatedReport);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Report'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveReport,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _reportTypeController,
                decoration: InputDecoration(labelText: 'Report Type'.tr),
                validator: (value) => value!.isEmpty ? 'Required'.tr : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'.tr),
                validator: (value) => value!.isEmpty ? 'Required'.tr : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'.tr),
              ),
              SizedBox(height: 16),
              if (_detailControllers.isNotEmpty) ...[
                Text(
                  'Test Results'.tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._detailControllers.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(labelText: entry.key.tr),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
