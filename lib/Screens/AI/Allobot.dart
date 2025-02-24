import 'package:allobaby/Controller/AllobotController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:allobaby/Config/Color.dart';


class Allobot extends StatefulWidget {
  @override
  _AllobotState createState() => _AllobotState();
}

class _AllobotState extends State<Allobot> {
  final ScrollController _scrollController = ScrollController();



  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String _generateResponse(String query) {
    // Placeholder for actual AI response generation
    return "### Regarding: $query\n\n"
           "Here's some information about your query:\n\n"
           "1. **Key Point 1**: Important medical fact\n"
           "2. **Key Point 2**: Another crucial detail\n\n"
           "```\n"
           "Some statistical data or code snippet if relevant\n"
           "```\n\n"
           "_Remember to consult with a healthcare professional for personalized advice._";
  }

  Allobotcontroller controller = Get.put(Allobotcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Allobot'.tr, style: 
        TextStyle(color: PrimaryColor, fontWeight: FontWeight.w600)
        // GoogleFonts.poppins(color: PrimaryColor, fontWeight: FontWeight.w600)

        
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: PrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: PrimaryColor),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: Column(
        children: [
          GetBuilder<Allobotcontroller>(builder: (controller)=>
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: controller.convs.length,
              itemBuilder: (context, index) {
                var d = controller.convs[index];

                return ChatMessage(text: d["msg"], isUserMessage: d["user"]);

              },
            ),
          )),
          GetBuilder<Allobotcontroller>(builder: (controller)=>
          controller.aithinking?buildAIThinkingWidget():Container()),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              controller: controller.input,
              decoration: InputDecoration(
                hintText: 'Ask Allobot a question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              style: 
              TextStyle(fontSize: 16),
              // GoogleFonts.poppins(fontSize: 16),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: PrimaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: White),
              onPressed: () {
                _scrollToBottom();
                controller.converseWithAI();},
            ),
          ),
        ],
      ),
    );
  }

Widget buildAIThinkingWidget() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circular Pulse Animation
        AnimatedContainer(
          duration: Duration(seconds: 2),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: PrimaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: PrimaryColor.withOpacity(0.4),
                blurRadius: 20.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PrimaryColor,
              ),
              child: Icon(
                Icons.child_care, // Maternal AI icon
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),

        // Text: AI Thinking
        Text(
          'Thinking...'.tr,
          // style: GoogleFonts.poppins
          style: 
          TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: PrimaryColor,
          ),
        ),

        SizedBox(height: 8),

        // Subtext (Optional)
        Text(
          'Your maternal AI assistant is processing your question'.tr,
          textAlign: TextAlign.center,
          style: 
          // GoogleFonts.poppins
          TextStyle
          (
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16),

        // Row of animated dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildThinkingDot(1),
            SizedBox(width: 8),
            _buildThinkingDot(2),
            SizedBox(width: 8),
            _buildThinkingDot(3),
          ],
        ),
      ],
    ),
  );
}

// Animated Dot Widget
Widget _buildThinkingDot(int index) {
  return TweenAnimationBuilder(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 100),
    curve: Curves.easeInOut,
    builder: (context, double value, child) {
      return Transform.scale(
        scale: 0.5 + (value * 0.5),
        child: Opacity(
          opacity: 0.3 + (value * 0.7),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: PrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    },
    onEnd: () {
      Future.delayed(Duration(milliseconds: 300), () {
        if (context != null) {
          (context as Element).markNeedsBuild(); // To loop the animation
        }
      });
    },
  );
}

}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isUserMessage)
            Container(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: PrimaryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  text,
                  style:TextStyle
                 //GoogleFonts.poppins//
                 (color: PrimaryColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: accentColor.withOpacity(0.2),
                          child: Icon(Icons.medical_services, color: PrimaryColor),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Allobot'.tr,
                          style: 
                          TextStyle
                          (fontWeight: FontWeight.w600, fontSize: 16, color: PrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    MarkdownBody(
                      data: text,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontSize: 16),
                        h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PrimaryColor),
                        h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: PrimaryColor),
                        h3: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimaryColor),
                        code: 
                        // GoogleFonts.robotoMono
                        TextStyle
                        (fontSize: 14, backgroundColor: Colors.grey[200]),
                        em: TextStyle(color: Black800),
                        strong: TextStyle(color: PrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}