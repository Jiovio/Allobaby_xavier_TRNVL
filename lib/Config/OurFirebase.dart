import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_vertexai/firebase_vertexai.dart';

class OurFirebase {

  static final db = FirebaseFirestore.instance;

  static final storage = FirebaseStorage.instance;

  static final storageRef = FirebaseStorage.instance.ref();

  static final ai = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash',
  generationConfig: GenerationConfig(
    responseMimeType: "application/json"
  ),
  );

    static final textai = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash',
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


    static Future<bool> createDataWithName(String collection,String docName,dynamic data) 
    async {
final city = <String, String>{
  "name": "Los Angeles",
  "state": "CA",
  "country": "USA"
};
    db
    .collection(collection)
    .doc(docName)
    .set(data)
    .onError((e, _) {
      print("Error writing document: $e");
      return false;
      });
      return true;
    }


    static void createUser (phone,data) {

      createDataWithName("AllobabyUsers",phone, data);

    }
}