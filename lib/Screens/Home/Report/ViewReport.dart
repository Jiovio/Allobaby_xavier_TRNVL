import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ViewReport extends StatelessWidget {
  final Map<String, dynamic> reportDetails;

  const ViewReport({super.key, required this.reportDetails});

  @override
  Widget build(BuildContext context) {
    // Parse the JSON details
    Map<String, dynamic> details = 
      jsonDecode(reportDetails['details'] ?? '{}');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Details'),
        elevation: 0,
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
                        reportDetails['imageurl'],
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
                    reportDetails['reportType'] ?? 'Unknown Report Type',
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
                        child: _buildInfoCard(
                          icon: Icons.calendar_today,
                          title: 'Date',
                          content: _formatDate(reportDetails['created']),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.phone,
                          title: 'Phone',
                          content: reportDetails['phone'] ?? 'N/A',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Description
                  _buildSection(
                    title: 'Description',
                    content: reportDetails['description'] ?? 'No description available',
                  ),
                  SizedBox(height: 16),

                  // Details
                  if (details.isNotEmpty) ...[
                    Text(
                      'Test Results',
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
    .map((word) => word.capitalize())
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
                child: Image.network(reportDetails['imageurl']),
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