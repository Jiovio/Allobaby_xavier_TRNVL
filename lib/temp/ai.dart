import 'package:flutter/material.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:firebase_core/firebase_core.dart';

class Ai extends StatefulWidget {
  const Ai({super.key});

  @override
  State<Ai> createState() => _AiState();
}

class _AiState extends State<Ai> {
  final TextEditingController _controller = TextEditingController();
  final model = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash',
  generationConfig: GenerationConfig(
    // responseMimeType: "application/json"
  ),
  );


  Future<void> _showModal(String inputText) async {

    final prompt = [Content.text(inputText)];

    final response = await model.generateContent(prompt);

    print(response.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AI:'),
          content: SingleChildScrollView(child: Text(response.text as String)),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter something',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showModal(_controller.text);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
