import 'package:flutter/material.dart';


void showCustomDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required VoidCallback onActionPressed,
  Color? titleColor,
  Color? subtitleColor,
  Color? actionColor,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor,
          ),
        ),
        actions: <Widget>[


          TextButton(
            onPressed: onActionPressed ,
            child: const Text(
              "OK",
  
            ),
          ),


          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "CANCEL",
 
            ),
          ),
        ],
      );
    },
  );
}