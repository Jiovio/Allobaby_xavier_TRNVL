import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:allobaby/API/local/Storage.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Models/ChatMessage.dart';
import 'package:allobaby/temp/CallView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:localstorage/localstorage.dart';
class OurFirebase {

  static final db = FirebaseFirestore.instance;

  static final storage = FirebaseStorage.instance;

  static final storageRef = FirebaseStorage.instance.ref();

  static final FirebaseDatabase database = FirebaseDatabase.instance;

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

    static Future<String?> getToken() async {
      String? token = await messaging.getToken();
      print("FCM Token: $token");
      return token;
    }


        static Future<void> deleteMessagingToken() async {
      await messaging.deleteToken();
    }

    

  static final ai = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash',
  generationConfig: GenerationConfig(
    responseMimeType: "application/json"
  ),
  );

    static final textai = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash',
  );




  static Future<String> uploadImageToFirebase(String path,String filename,File image,[String? phone]) async {

  Maincontroller cont = Get.put(Maincontroller());

  phone ??= cont.phoneNumber.text;
  

  final spaceRef = OurFirebase.storageRef.child("/Allobaby/$phone/$path/$filename");

  print(spaceRef.bucket);

  try {
    await spaceRef.putFile(image);
    String path =  await spaceRef.getDownloadURL();
     return path;
    } catch (e) {
      return "Error";
    }
  }

    static Future<String> uploadAudioToStorage(String path,File audio) async {

    var d = await Userapi.getUser();

    String phone = d["phone_number"];
    String date = DateTime.now().toString();


  final spaceRef = OurFirebase.storageRef.child("/Allobaby/$phone/$path/$date.aac ");

  print(spaceRef.bucket);

  try {
    await spaceRef.putFile(audio);
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


static Future<List<Map<String, dynamic>>> getReports() async {

    var d = await Userapi.getUser();
    String phone = d["phone_number"];


    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("reports")
        .where("phone", isEqualTo: phone)
        .get();


    List<Map<String, dynamic>> reports = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    return reports;
  }


  static Future<Map<String, dynamic>> getAIAppointments([bool reload = false]) async {
    try {

      var d = await Userapi.getUser();

      final local = localStorage.getItem("${d.toString()}/aiappointment");


      if(local!=null && reload ==false){

        print("got from location");

        return json.decode(local);
        
      }

      
      print(d);
      var status = d["pregnancy_status"];
      var lmp_date = d["lmp_date"];
      var ed_date = d["ed_date"];
      
      String date = DateTime.now().toString();




      String temp = """
      This is my lmp date $lmp_date my status is $status current date is $date. 
      if my status is iam trying to conceive iam not pregnant
      check whether iam pregnant 
      and generate dates for my whole pregnancy of upcoming regular checkup appointment till the ed date 
      if not pregnant return dates as {} 
""";
      
      String prompt = """
iam ${d["pregnancy_status"]}.

 my details are $d with LMP Date of $lmp_date .
 current date is $date.
Note : if iam trying to conceive , iam not pregnant.
 if am pregnant,
calculate the EDD date and monthly once ANC appointment date every month 
for 9 months starting from one month after lmp date , give short summary based on data and current date
 and dont give dates in summary

      in the schema {
        is_pregnant:bool,
        summary : text
        dates :{
          [month year]: [String of dates]
        }
      }
      """;

      print(prompt);
      
      var res = await ai.generateContent([Content.text(prompt)]);
      
      if (res.text != null) {
        Map<String, dynamic> data = json.decode(res.text as String);
        print("******************************");
        // print(data);

        localStorage.setItem("${d.toString()}/aiappointment", res.text as String);

        return data;
      } else {
        throw Exception('No response from AI');
      }
    } catch (e) {
      print("Error in getAIAppointments: $e");
      throw e;
    }
  }

           static Future<String> audioAI(File aud , String promp) async{

      final prompt = TextPart(promp);
final audio = await aud.readAsBytes();
final imagePart = DataPart('audio/aac', audio);

    final response = await ai.generateContent([
      Content.multi([prompt,imagePart])
    ]);
        // print(response.text);
        return response.text??"";
    }

    static Future<void>  addUser() async {

      try {
         DatabaseReference ref = FirebaseDatabase.instance.ref("users/P1");
      await ref.set({"name":"Astro"});
      } catch (e) {

        print(e);
        
      }


    }

    static Future<void>  addMessages(Messages msg,String to, dynamic details) async {

      try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/$to");
      DatabaseReference newMessRef = ref.push();

      print(msg.toMap());

      await newMessRef.set({...msg.toMap(),...details});
      } catch (e) {
        print(e);
      }
    }

    static Future<dynamic> getCurrentMessages() async{
      final userid = Storage.getUserID();
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child("users/P$userid").get();
      print(userid);
      print(snapshot);
      if(snapshot.exists){
        print(snapshot.value);  
      }
      return snapshot.value;
    }


    static Future<void>  createCall(String p2, String p1,String type) async {
      Maincontroller controller = Get.put(Maincontroller());
      final token = await Userapi.getCallToken(p1);
      if(token==null){
        Get.snackbar("Call Failed", "Error Making Call");
        return;
      }
      try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("calls/$p2");
     await  ref.set({
      "call":true, 
      "callerName":controller.name.text,
      "p1":p1,
      "p2":p2,
      "token":token,
      "type":type
      });
      Get.dialog(Callview(channel: p1,token: token,path: p2,));
      // Get.to(()=>Callview(channel: p1,token: token,path: p2,));
      } catch (e) {
        print(e);
      }
    }

        static Future<bool>  cutCall(String path) async {
      try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("calls/$path");
     await  ref.set({
      "call":false
      });

      return true;
      
      } catch (e) {
        print(e);

        return false;
      }
    }


    static Future<void> addPrescription({
    required int userId,
    required String imageUrl,
    required String prescriptionType,
    required String description,
  }) async {
    

    try {
      await db.collection('Prescription').add({
        'userId': userId,
        'imageUrl': imageUrl,
        'prescriptionType': prescriptionType,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add prescription: $e');
    }
  }






    static setStatus(bool status) async {
  final id = Storage.getUserUID();
  print(id.toString());

     DatabaseReference ref = FirebaseDatabase.instance.ref("online/${id.toString()}");
     await  ref.set(status);
    }
    




}