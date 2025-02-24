import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/features/babycry/cryhistory/cryhistoryhome.dart';
import 'package:allobaby/features/babycry/data/crydata.dart';
import 'package:allobaby/features/babycry/screens/crydetail.dart';
import 'package:allobaby/features/babycry/screens/record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Crytellhome extends StatefulWidget {
  @override
  State<Crytellhome> createState() => _CrytellhomeState();
}

class _CrytellhomeState extends State<Crytellhome> with SingleTickerProviderStateMixin {
  late AnimationController _recordingController;
  bool isRecording = false;

  // Define color scheme based on primary color
  final primaryColor = Color(0xffFF626F);
  final backgroundColor = Colors.white; // Light pink shade
  final secondaryColor = Color(0xffFF8A94); // Lighter shade of primary


  final List<Map<String, dynamic>> cryTypes = [
    {
      'title': 'Hunger Crying'.tr,
      "org": 'Hunger Cry',
      'description': "Rhythmic, repetitive cries that grow louder if the baby isn't fed. Often accompanied by hand-sucking and rooting behavior.".tr,
      'icon': '🍼',
      'link' : "assets/babyicons/hc.png"
    },
    {
      'title': 'Sleepy Crying'.tr,
      'org': 'Sleepy Cry',

      'description': "A whiny, nasal cry that sounds weaker than a hunger cry, often accompanied by yawning and eye-rubbing.".tr,
      'icon': '😴',
      'link' : "assets/babyicons/sc.png"

    },
    {
      'title': 'Burping Crying'.tr,
      'org': 'Burping Cry',

      'description': "A sudden, high-pitched, intense cry that comes in bursts with breathing pauses. Often accompanied by physical tension.".tr,
      'icon': '🤕',
      'link' : "assets/babyicons/pc.png"

    },
    {
      'title': 'Discomfort Crying'.tr,
      'org': 'Discomfort Cry',

      'description': "A fussy, irritated cry that typically stops when the source of discomfort is addressed.".tr,
      'icon': '😣',
      'link' : "assets/babyicons/dc.png"

    },
    {
      'title': 'Colic Crying'.tr,
      'org': 'Pain Cry',

      'description': "Prolonged, intense crying episodes, typically in the evening, with physical signs of distress.".tr,
      'icon': '😢',
      'link' : "assets/babyicons/cc.png"

    },
    {
      'title': 'Attention Crying'.tr,
      'org': 'Attention Cry',

      'description': "A mild cry that starts softly and increases if ignored, often accompanied by eye contact and reaching out.".tr,
      'icon': '🤗',
      'link' : "assets/babyicons/ac.png"

    },
  ];

  @override
  void initState() {
    super.initState();
    _recordingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _recordingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Allocry".tr,
          style: GoogleFonts.poppins(
          
            color: PrimaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [

          TextButton.icon(
            label: Text(
                'Cry History'.tr,
                style: GoogleFonts.poppins(
                  color: primaryColor,
                  fontWeight: FontWeight.w500
                ),
              ),

            icon: Icon(Icons.history, color: primaryColor),
            onPressed:() => Get.to(()=>CryHistory())),

        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
 
 
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
         
              children: [

                SizedBox(
                  width: Get.width/2,
                  child: Lottie.asset("assets/animations/Ani6.json")
                  ),

                  Text(
                                'Baby can cry due to'.tr,
                                style: GoogleFonts.poppins(
                                  color: PrimaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                
                                
                  )),
                  
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: cryTypes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(()=> Crydetail(data: Data().crydata[cryTypes[index]['org']],)),
                      child: AnimatedCryCard(
                        title: cryTypes[index]['title']!,
                        description: cryTypes[index]['description']!,
                        icon: cryTypes[index]['link']!,
                        index: index,
                        primaryColor: primaryColor,
                      ),
                    );
                  },
                ),

               const SizedBox(height: 100,)
                
              ],
            ),
          ),


        

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Get.to(()=> const VoiceRecorderNew(),
              transition: Transition.downToUp, curve: Curves.easeInOut),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                    ),
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withOpacity(0.1),
                      ),
                    ),
                          
                    TweenAnimationBuilder(
                      duration: Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 1, end: 1),
                      builder: (context, double scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  primaryColor,
                                  secondaryColor,
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [Colors.white, Colors.white70],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ).createShader(bounds),
                                  child: Icon(
                                    Icons.mic,
                                    color: Colors.white,
                                    size: 34,
                                    
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Record'.tr,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  
                  
                  ],
                ),
              ),
            ),
          ),
      
        
        ],
      ),
    );
  }
}

class AnimatedCryCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final int index;
  final Color primaryColor;

   AnimatedCryCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.index,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      
      duration: Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Color(0xffFFF0F1),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   icon,
              //   style: TextStyle(fontSize: 32),
              // ),

              // SizedBox(
              //   height: 32,
              //   child: Image.asset(icon)),
              // SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryColor,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}