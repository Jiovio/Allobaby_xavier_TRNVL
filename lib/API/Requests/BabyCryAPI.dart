import 'package:allobaby/API/authAPI.dart';

class Babycryapi {


  static Future<dynamic> addBabyCry(String text, String audioLink) async {
      final req = await postRequest("/user/addbabycry",{
        "audio_link":audioLink,
        "text":text
      });
      return req;
}


  static Future<dynamic> getcrys() async {
      final req = await getRequest("/user/babycrys");
      return req;
}



}