import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/features/babycry/cryhistory/cryhistoryhome.dart';
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
  final backgroundColor = Color(0xffFFF0F1); // Light pink shade
  final secondaryColor = Color(0xffFF8A94); // Lighter shade of primary

  final List<Map<String, dynamic>> cryTypes = [
    {
      'title': 'Hungry Cry',
      'description': 'A rhythmic, repetitive cry that escalates if not attended to. Babies may also show signs like rooting or sucking on their hands.',
      'icon': '🍼',
      'link' : "assets/babyicons/hc.png"
    },
    {
      'title': 'Sleepy Cry',
      'description': 'A whiny, nasal cry that may come with yawning, rubbing eyes, or fussiness. It often sounds weaker than a hunger cry.',
      'icon': '😴',
      'link' : "assets/babyicons/sc.png"

    },
    {
      'title': 'Pain Cry',
      'description': 'A sudden, high-pitched, intense cry with pauses for catching breath. It may be accompanied by clenched fists or a stiff body.',
      'icon': '🤕',
      'link' : "assets/babyicons/pc.png"

    },
    {
      'title': 'Discomfort Cry',
      'description': 'A fussy, irritated cry indicating a wet diaper, feeling too hot or cold, or tight clothing. The cry may stop once the issue is resolved.',
      'icon': '😣',
      'link' : "assets/babyicons/dc.png"

    },
    {
      'title': 'Colic Cry',
      'description': 'A prolonged, intense, high-pitched cry that occurs mostly in the evening. The baby may clench fists, arch the back, or have a tense abdomen.',
      'icon': '😢',
      'link' : "assets/babyicons/cc.png"

    },
    {
      'title': 'Attention Cry',
      'description': 'A mild, whimpering cry that starts softly and grows louder if ignored. Babies may also make eye contact or reach out for comfort.',
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "AlloCry",
          style: GoogleFonts.poppins(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [

          TextButton.icon(
            label: Text(
                'Cry History',
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
                                'Baby can cry due to',
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
                      onTap: () => Get.to(()=> Crydetail()),
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
                                  'Record',
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

  const AnimatedCryCard({
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