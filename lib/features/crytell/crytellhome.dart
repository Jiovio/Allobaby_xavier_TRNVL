import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/features/crytell/screens/crydetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Crytellhome extends StatelessWidget {
  final List<Map<String, String>> cryTypes = [
    {
      'title': 'Hungry Cry',
      'description': 'A rhythmic, repetitive cry that escalates if not attended to. Babies may also show signs like rooting or sucking on their hands.',
    },
    {
      'title': 'Sleepy Cry',
      'description': 'A whiny, nasal cry that may come with yawning, rubbing eyes, or fussiness. It often sounds weaker than a hunger cry.',
    },
    {
      'title': 'Pain Cry',
      'description': 'A sudden, high-pitched, intense cry with pauses for catching breath. It may be accompanied by clenched fists or a stiff body.',
    },
    {
      'title': 'Discomfort Cry',
      'description': 'A fussy, irritated cry indicating a wet diaper, feeling too hot or cold, or tight clothing. The cry may stop once the issue is resolved.',
    },
    {
      'title': 'Colic Cry',
      'description': 'A prolonged, intense, high-pitched cry that occurs mostly in the evening. The baby may clench fists, arch the back, or have a tense abdomen.',
    },
    {
      'title': 'Attention Cry',
      'description': 'A mild, whimpering cry that starts softly and grows louder if ignored. Babies may also make eye contact or reach out for comfort.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryTell"),
        actions: [
          
          const Text('Cry History', style: TextStyle(color: PrimaryColor)),
          SizedBox(width: 10,)],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: PrimaryColor),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Image.asset('assets/crying_baby.png', height: 100),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: cryTypes.length,
              itemBuilder: (context, index) {
                return CryCard(
                  title: cryTypes[index]['title']!,
                  description: cryTypes[index]['description']!,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: PrimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mic, color: Colors.white, size: 28),
              SizedBox(width: 10),
              Text('Press to record crying',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class CryCard extends StatelessWidget {
  final String title;
  final String description;

  const CryCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 8),
            Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: PrimaryColor))),
            SizedBox(height: 8),
            IconButton(
              icon: Icon(Icons.play_circle_outline_rounded, color: PrimaryColor, size: 40),
              onPressed: () => Get.to(()=>Crydetail()),
              ),
            SizedBox(height: 8),

            Text(description, style: TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}