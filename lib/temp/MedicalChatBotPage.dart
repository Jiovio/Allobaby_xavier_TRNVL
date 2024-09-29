import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:allobaby/Config/Color.dart';

class AllobotChatPage extends StatefulWidget {
  @override
  _AllobotChatPageState createState() => _AllobotChatPageState();
}

class _AllobotChatPageState extends State<AllobotChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addBotMessage(
      "# Welcome to Allobot\n\n"
      "I'm your AI medical assistant, here to provide information and guidance. How can I assist you today?\n\n"
      "- Ask about symptoms\n"
      "- Get information on medications\n"
      "- Learn about health conditions\n\n"
      "_Remember, always consult with a healthcare professional for personalized medical advice._"
    );
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    _textController.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: true));
    });
    _scrollToBottom();
    // Simulate bot response
    Future.delayed(Duration(seconds: 1), () {
      _addBotMessage(_generateResponse(text));
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: false));
    });
    _scrollToBottom();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Allobot', style: GoogleFonts.poppins(color: PrimaryColor, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: PrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: PrimaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
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
              controller: _textController,
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
              onSubmitted: _handleSubmitted,
              style: GoogleFonts.poppins(fontSize: 16),
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
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
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
                  style: GoogleFonts.poppins(color: PrimaryColor, fontSize: 16),
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
                          'Allobot',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: PrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    MarkdownBody(
                      data: text,
                      styleSheet: MarkdownStyleSheet(
                        p: GoogleFonts.poppins(fontSize: 16),
                        h1: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: PrimaryColor),
                        h2: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: PrimaryColor),
                        h3: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: PrimaryColor),
                        code: GoogleFonts.robotoMono(fontSize: 14, backgroundColor: Colors.grey[200]),
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