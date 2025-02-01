import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Crydetail extends StatelessWidget {
  Crydetail({super.key});

  final Color primaryColor = const Color(0xFFFF626F);
  final Color bgColor = Color.fromARGB(255, 255, 255, 255);
  final Color accentColor = const Color(0xFFFFB6C1);
  
  final Map data = {
    "heading": "Hungry Cry",
    "description": [
      {
        "bold": true,
        "text":
            'Hunger cries are rhythmic, repetitive, and gradually intensify if the baby isnt fed. The cry may start softly but become louder and more desperate over time.'
      },
      {
        "bold": true,
        "text": 'Babies may also show signs like:'
      },
      {
        "bold": false,
        "text": '• Sucking on hands or fingers'
      },
      {
        "bold": false,
        "text": '• Smacking lips or rooting (turning head to search for a nipple)'
      },
      {
        "bold": false,
        "text": '• Fussiness even after being comforted'
      }
    ],
    "recommendations": [
      'Feed Promptly – Responding early prevents excessive crying and makes feeding easier.',
      'Watch for Hunger Cues – Crying is a late sign; look for early signs like lip-smacking, rooting, sticking out tongue, or sucking on hands.',
      'Ensure Proper Latch – If breastfeeding, ensure a deep latch to avoid discomfort.',
      'Check Feeding Schedule – Newborns need feeding every 2-3 hours.',
      'Burp Baby After Feeding – Helps prevent gas and fussiness.',
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     bgColor,
          //     Colors.white,
          //     Colors.white,
          //     bgColor.withOpacity(0.3),
          //   ],
          //   stops: const [0.0, 0.3, 0.7, 1.0],
          // ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'AlloCry',
          style: GoogleFonts.poppins(
          
            color: Colors.black,
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
                  onPressed: () {},
                  icon: Icon(Icons.history, color: primaryColor),
                  label: Text(
                    'Cry History',
                    style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
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
                            Icon(Icons.baby_changing_station,
                                color: primaryColor, size: 30),
                            const SizedBox(width: 10),
                            Text(
                              data["heading"],
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Card(
                    elevation: 8,
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
          floatingActionButton: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.mic,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}