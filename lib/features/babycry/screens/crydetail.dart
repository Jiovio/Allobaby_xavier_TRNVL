import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/features/babycry/components/audio_play_btn.dart';
import 'package:allobaby/features/babycry/cryhistory/cryhistoryhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Crydetail extends StatelessWidget {
  final Map data ;
  Crydetail({super.key , required this.data});

  final Color primaryColor = const Color(0xFFFF626F);
  final Color bgColor = Color.fromARGB(255, 255, 255, 255);
  final Color accentColor = const Color(0xFFFFB6C1);
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text(
              'Allocry'.tr,
          style: GoogleFonts.poppins(
          
            color: PrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: TextButton.icon(
                  onPressed: ()=> Get.to(()=>CryHistory()),
                  icon: Icon(Icons.history, color: primaryColor),
                  label: Text(
                    'Cry History'.tr,
                    style: GoogleFonts.poppins(
                      color: primaryColor,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(Icons.baby_changing_station,
                                  //     color: primaryColor, size: 30),
                                  // const SizedBox(width: 10),
                                  Text(
                                    data["heading"],
                                    style: GoogleFonts.poppins(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                        ),
                
                        Card(
                          // elevation: 3,
                          shadowColor: primaryColor.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              border: Border.all(
                                color: accentColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...data["description"].map((v) => Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (!v["bold"]) 
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Icon(
                                            Icons.favorite,
                                            color: primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          v["text"],
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: v["bold"]
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: v["bold"]
                                                ? primaryColor
                                                : Colors.black87,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                  
                        const SizedBox(height: 24),
                  
                        // Recommendations Section
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Recommendations',
                            style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  
                        const SizedBox(height: 16),
                  
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data["recommendations"].length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: accentColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryColor.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    data["recommendations"][index],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            
            
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                       
                          decoration: BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Color(0xffFFF0F1),
                              ],
                            ),
                          ),
                          child: Row(
                            
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Text("Sample Cry",
                              style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                              ),
                              Text("Tap to play audio",
                              style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),)


                                ],
                              ),

                             const SizedBox(width: 20,),



                              AudioPlayerButton(assetPath: data["audio"]),

                              
                
                           
                           
                            ],
                          ),
                        )
          
                      ),
        
            ],
          ),

          

        
        );
  }
}

