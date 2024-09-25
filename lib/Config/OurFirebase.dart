import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';

class OurFirebase {

  static final storage = FirebaseStorage.instance;

  static final storageRef = FirebaseStorage.instance.ref();

  static final ai = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash',
  generationConfig: GenerationConfig(
    responseMimeType: "application/json"
  ),
  );


    Future<String> uploadImageToFirebase(String path,File image) async {

  final spaceRef = OurFirebase.storageRef.child("images/space.jpg");

  print(spaceRef.bucket);

  try {
    await spaceRef.putFile(image);
    String path =  await spaceRef.getDownloadURL();
     return path;
    } catch (e) {
      return "Error";
    }
  }


   static Future<String> askVertexAi(File img , String promp) async{

      final prompt = TextPart(promp);
final image = await img.readAsBytes();
final imagePart = DataPart('image/jpeg', image);

    final response = await ai.generateContent([
      Content.multi([prompt,imagePart])
    ]);
        // print(response.text);
        return response.text??"";
    }
}