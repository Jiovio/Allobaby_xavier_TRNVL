
import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Info".tr,
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
            decoration: const BoxDecoration(
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
                

                const Text(
                  "ALLOBABY",
                  style: TextStyle(color: PrimaryColor, fontSize: 24),
                )
                ,


                const SizedBox(
                  height: 8,
                ),
                const Text(
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
               const Text("Last Updated on 10-Feb-2025"),
               const SizedBox(
                  height: 20,
                ),
               
               const SizedBox(
                  height: 16,
                ),
               const Text(
                  'from',
                  style: TextStyle(color: Colors.grey),
                ),
               const SizedBox(
                  height: 8,
                ),
                Text(
                  'savemom private limited'.tr.toUpperCase(),
                  style:const TextStyle(
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
