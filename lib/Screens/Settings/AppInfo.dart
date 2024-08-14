
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Info",
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context)),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/General/laucher_icon.png',
                  scale: 4,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Version : 1.0",
                  style: TextStyle(color: PrimaryColor, fontSize: 18),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Text("Last Updated on 06-jan-2021"),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(minimumSize: Size(50, 40)),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward),
                  label: Text("CHECK FOR UPDATES"),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'from',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'JioVio Healthcare'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
