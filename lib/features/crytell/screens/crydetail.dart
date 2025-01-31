import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Crydetail extends StatelessWidget {
  Crydetail({super.key});

  final Color primaryColor = const Color(0xFFFF626F);
  
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
      appBar: AppBar(
        title: Text(
          'CryTell',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor,
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
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
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
              // Header Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        data["heading"],
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Description Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...data["description"].map((v) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            if (!v["bold"]) 
                              Icon(
                                Icons.arrow_right_rounded,
                                color: primaryColor,
                              ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                v["text"],
                                style: TextStyle(
                                  fontSize: 16,
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
              Text(
                'Recommendations',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data["recommendations"].length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        data["recommendations"][index],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
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
          color: primaryColor,
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
    );
  }
}