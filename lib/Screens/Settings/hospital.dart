import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Settings/ViewHospital.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHospital extends StatelessWidget {
  const MyHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Container(
          padding: EdgeInsets.only(top: 24, bottom: 8),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Hospital",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: darkGrey2,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.local_hospital,
                    color: Black800,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: Hospitalapi.getHospitalList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Hospitals available"));
          } else {
            final hospitals = snapshot.data!;
            return ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      hospital['name'],
                      style: TextStyle(fontWeight: FontWeight.bold, color: PrimaryColor),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("District: ${hospital['district']}"),
                        Text("Address: ${hospital['address']}"),
                        Text("State: ${hospital['state']}"),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: PrimaryColor),
                    onTap: () 
                    => Get.to(() => Viewhospital(hospital: hospital)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.https(url))) {
      await launchUrl(Uri.https(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}