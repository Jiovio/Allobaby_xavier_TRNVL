import 'package:allobaby/Controller/AllobotController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:allobaby/Config/Color.dart';

void allobotModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildIntroSection(),
                      SizedBox(height: 20),
                      _buildWhatToAskSection(),
                      SizedBox(height: 20),
                      // _buildChatSection(),
                    ],
                  ),
                ),
                _buildInputSection(),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildHeader() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Allobot',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PrimaryColor,
          ),
        ),
        Text(
          'Your Maternal AI Assistant',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntroSection() {
  return Card(
    elevation: 0,
    color: Colors.pink[50],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Allobot!',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: PrimaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'I`m here to support you through your maternal journey. Ask me anything about pregnancy, childbirth, or early motherhood.',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

Widget _buildWhatToAskSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'What You Can Ask Me:',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: PrimaryColor,
        ),
      ),
      SizedBox(height: 10),
      _buildAskItem(Icons.favorite, 'Pregnancy health tips'),
      _buildAskItem(Icons.restaurant, 'Nutrition advice'),
      _buildAskItem(Icons.child_care, 'Baby care basics'),
      _buildAskItem(Icons.calendar_today, 'Trimester milestones'),
    ],
  );
}

Widget _buildAskItem(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, color: accentColor, size: 20),
        SizedBox(width: 10),
        Text(text, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    ),
  );
}

Widget _buildChatSection() {
  // Placeholder for chat messages
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Text(
      'Your conversation will appear here...',
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _buildInputSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: 
    GetBuilder(
      init: Allobotcontroller(),
      builder: (controller) => 
    Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.input,
            decoration: InputDecoration(
              hintText: 'Ask Allobot...',
              hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(width: 10),
        controller.aithinking?CircularProgressIndicator():Container(
          decoration: BoxDecoration(
            color: PrimaryColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            
            icon: Icon(Icons.send, color: Colors.white),
            onPressed:(){controller.converseWithAI(true);},
          ),
        ),
      ],
    )),
  );
}