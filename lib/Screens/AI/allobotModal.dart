import 'package:allobaby/Controller/AllobotController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/AI/Allobot.dart';
import 'package:allobaby/Screens/Main/BottomSheet/BottomQuestion.dart';
import 'package:allobaby/Screens/Main/BottomSheet/widgets/emoji.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:allobaby/Config/Color.dart';

void allobotModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        // This ensures the modal takes keyboard height into account
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          // Constrain height to ensure modal doesn't take full screen
          height: MediaQuery.of(context).size.height * 0.95,
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildIntroSection(),
                          SizedBox(height: 20),
                          _buildWhatToAskSection(),
                          SizedBox(height: 20),
                          // _buildChatSection(),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: _buildInputSection(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}


Widget _buildHeader() {
  return Container(
    // padding: EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      children: [
        // Container(
        //   width: 40,
        //   height: 5,
        //   decoration: BoxDecoration(
        //     color: Colors.grey[300],
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        // ),
        // SizedBox(height: 15),
        Text(
          'Allobot'.tr,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PrimaryColor,
          ),
        ),
        Text(
          'Your Maternal AI Assistant'.tr,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

Widget _buildIntroSection() {
  return Card(
    elevation: 0,
    color: Colors.pink[50],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Allobot!'.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: PrimaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'I`m here to support you through your maternal journey. Ask me anything about pregnancy, childbirth, or early motherhood.'.tr,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}

Widget _buildWhatToAskSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'What You Can Ask Me:'.tr,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: PrimaryColor,
        ),
      ),
      SizedBox(height: 10),
      _buildAskItem(Icons.favorite, 'Pregnancy health tips'.tr),
      _buildAskItem(Icons.restaurant, 'Nutrition advice'.tr),
      _buildAskItem(Icons.child_care, 'Baby care basics'.tr),
      _buildAskItem(Icons.calendar_today, 'Trimester milestones'.tr),
    ],
  );
}

Widget _buildAskItem(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, color: accentColor, size: 20),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    ),
  );
}

Widget _buildChatSection() {
  // Placeholder for chat messages
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Text(
      'Your conversation will appear here...',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _buildInputSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: 
    GetBuilder(
      init: Allobotcontroller(),
      builder: (controller) => 
    Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.input,
            decoration: InputDecoration(
              hintText: 'Ask Allobot...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(width: 10),
        controller.aithinking?CircularProgressIndicator():Container(
          decoration: BoxDecoration(
            color: PrimaryColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            
            icon: Icon(Icons.send, color: Colors.white),
            onPressed:(){controller.converseWithAI(true);},
          ),
        ),
      ],
    )),
  );
}



Widget _buildInputSectionMic(context) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: 
    GetBuilder(
      init: Allobotcontroller(),
      builder: (controller) => 
    Row(
      children: [
        Expanded(
          child: TextField(
            onTap: () {
              Get.to(Allobot());

              
              },
            controller: controller.input,
            decoration: InputDecoration(
              hintText: 'Ask Allobot...'.tr,
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(width: 10),

        Container(
          decoration: BoxDecoration(
            color: PrimaryColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            
            icon: Icon(Icons.mic, color: Colors.white),
            onPressed:(){
              Navigator.pop(context);
                                                                        showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) => Container(
                              height: Get.height / 2,
                              child:  
                              bottomQuestionSheet(context, 6),
                              // Text("Hi")
        
        
                            ));
            },
          ),
        ),


        // SizedBox(width: 10),
        // controller.aithinking?CircularProgressIndicator():Container(
        //   decoration: BoxDecoration(
        //     color: PrimaryColor,
        //     shape: BoxShape.circle,
        //   ),
        //   child: IconButton(
            
        //     icon: Icon(Icons.send, color: Colors.white),
        //     onPressed:(){controller.converseWithAI(true);},
        //   ),
        // ),
      ],
    )),
  );
}

  showAllobotModalWithEmoji(BuildContext context) {


      
   Maincontroller controller = Get.put(Maincontroller());

   

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        // initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.99,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                // Simple header implementation
                Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    children: [
                      // Intro section

                      _buildHeader(),




                      // Emoji section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "Hi Patient",
                                //   style: TextStyle(
                                //     fontSize: 24,
                                //     fontWeight: FontWeight.w700,
                                //   ),
                                // ),
                                SizedBox(height: 10),
                                Text(
                                  "How do you feel today ?".tr,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: PrimaryColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120.0,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: GetBuilder<Maincontroller>(
                              builder: (controller) => ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => SizedBox(width: 10),
                                itemCount: emojiList.length,
                                itemBuilder: (context, index) {
                                  final item = emojiList[index];
                                  final isSelected = controller.bottomSheetData["feeling"] == item.title;
                                  
                                  return TextButton(
                                    style: TextButton.styleFrom(
                                      padding:const EdgeInsets.all(14),
                                      shape: isSelected
                                          ? RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                              side: BorderSide(
                                                color: Theme.of(context).primaryColor,
                                                width: 1.5,
                                              ),
                                            )
                                          : null,
                                    ),
                                    onPressed: () {
                                      controller.setBottomSheetData("feeling", item.title);
                                      Navigator.pop(context);


                                                          showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) => Container(
                              height: Get.height / 2,
                              child:  
                              bottomQuestionSheet(context, 1),
                              // Text("Hi")
        
        
                            ));
                                      
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          item.emoji,
                                          height: 58,
                                          width: 58,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(Icons.error);
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Theme.of(context).primaryColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),


                                            _buildIntroSection(),

                      SizedBox(height: 20),


                      _buildWhatToAskSection(),


                    ],
                  ),
                ),

                
                // Input section
                _buildInputSectionMic(context)
              ],
            ),
          );
        },
      );
    },
  );
}