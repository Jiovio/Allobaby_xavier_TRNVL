import 'package:allobaby/Config/Color.dart';
import 'package:flutter/material.dart';

class Crydetail extends StatelessWidget {
   Crydetail({super.key});

      //  ...['Sucking on hands or fingers',
      //                   'Smacking lips or rooting (turning head to search for a nipple)',
      //                   'Fussiness even after being comforted'
      //                 ].map((text) => Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 4.0),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       const Text('• '



   Map data = {
    "heading" : "Hungry Cry",
    "description" : 
    [
    {
      "bold":true,
      "text": 'Hunger cries are rhythmic, repetitive, and gradually intensify if the baby isnt fed. The cry may start softly but become louder and more desperate over time.'
    },

    {
      "bold":true,
      "text": 'Babies may also show signs like:'
    },

        {
      "bold":false,
      "text": '• Sucking on hands or fingers'
    },

        {
      "bold":false,
      "text": '• Smacking lips or rooting (turning head to search for a nipple)'
    },

        {
      "bold":false,
      "text": '• Fussiness even after being comforted'
    }


   ]
    
    ,
    "recommendations" : [
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
        title: const Text(
          'CryTell',
        ),
        backgroundColor: Colors.white,
        elevation: 0,

        actions: [
          TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Cry History',
                    style: TextStyle(
                      color: PrimaryColor,

                    ),
                  ),
                ),],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              
              // // Crying Baby Icon
              // Center(
              //   child: Container(
              //     width: 120,
              //     height: 120,
              //     decoration: BoxDecoration(
              //       color: const Color(0xFFFCE4EC),
              //       borderRadius: BorderRadius.circular(60),
              //     ),
              //     child: const Icon(
              //       Icons.child_care,
              //       size: 80,
              //       color: Color(0xFFE57373),
              //     ),
              //   ),
              // ),
              
              const SizedBox(height: 16),


              Card(
                elevation: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(children: [
                    Center(
                    child: Text(
                    data["heading"],
                    style: const TextStyle(
                      color: PrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                                    ),
                                  ),
                    const SizedBox(height: 16),

                    Center(
                      child: 
                        Icon(Icons.play_circle_outline_rounded, 
                        color: PrimaryColor,
                        size: 50,)
                    ),
                    
                    
                    
                    ],),
                  ),
                ),
              ),
              

              

              
              const SizedBox(height: 24),
              
              // Description Card
              Card(
                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: const BorderSide(
      color: Color(0xFFEF9A9A),  // Pink border color to match the app theme
      width: 1.5,                // Border width
    ),
  ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ...data["description"].map((v)=>

                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                          v["text"],
                          style: TextStyle(fontSize: 14,fontWeight: v["bold"] ? FontWeight.bold : FontWeight.normal),
                                                ),
                        )
                      
                      
                      ).toList(),

                      // const Text(
                      //   'Hunger cries are rhythmic, repetitive, and gradually intensify if the baby isnt fed. The cry may start softly but become louder and more desperate over time.',
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      // const SizedBox(height: 14),
                      // const Text(
                      //   'Babies may also show signs like:',
                      //   style: TextStyle(fontSize: 14),
                      // ),
                      // const SizedBox(height: 8),
                      // ...['Sucking on hands or fingers',
                      //   'Smacking lips or rooting (turning head to search for a nipple)',
                      //   'Fussiness even after being comforted'
                      // ].map((text) => Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       const Text('• ', style: TextStyle(fontSize: 14)),
                      //       Expanded(
                      //         child: Text(text, style: TextStyle(fontSize: 14)),
                      //       ),
                      //     ],
                      //   ),
                      // )).toList(),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Recommendations Section
              const Text(
                'Recommendations',
                style: TextStyle(
                  color: Color(0xFFE57373),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 16),


              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                
                itemBuilder:(context, index) {
                  
                  return                 Card(
                  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: const BorderSide(
      color: Color(0xFFEF9A9A),  // Pink border color to match the app theme
      width: 1.5,                // Border width
    ),
  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE4EC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Color(0xFFE57373),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            data["recommendations"][index],
                            style: TextStyle(fontSize: 14, color: Colors.black54)
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              

                }, 
                
                separatorBuilder:(context, index) {
                  return SizedBox(height: 10,);
                }, 
                
                itemCount: data["recommendations"].length),
              

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: PrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.mic, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Press to record crying',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}