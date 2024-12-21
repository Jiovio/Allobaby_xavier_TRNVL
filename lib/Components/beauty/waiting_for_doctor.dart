

import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';

class WaitingForDoctorWidget extends StatelessWidget {
  const WaitingForDoctorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Medical services icon
          Icon(
            Icons.medical_services_outlined,
            size: 100,
            color: PrimaryColor,
          ),
          
          const SizedBox(height: 20),
          
          // Text display
          Text(
            "Waiting For Doctor Input ..",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20,)
        ],
      ),
    );
  }
}