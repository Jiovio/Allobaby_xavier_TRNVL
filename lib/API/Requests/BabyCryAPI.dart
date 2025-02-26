import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/response.dart';

class Babycryapi {


  static Future<dynamic> addBabyCry(String text, String audioLink, bool cry_detected) async {
      final req = await postRequest("/babycry/addbabycry",{
        "audio_link":audioLink,
        "text":text,
        "cry_detected": cry_detected
      });
      return req;
}


  static Future<dynamic> getcrys() async {
      final req = await getRequest("/babycry/babycrys");
      return req;
}

  static Future<APIResponse> saveCry(id, save) async {
      final req = await newPostRequest("/babycry/save",{
        "id" : id,
        "save" : save
      });
      return req;
}

      static Future<APIResponse> deleteCry(dynamic id) async {

    final req = await newDeleteRequest("/babycry/deletebabycry?cry_id=${id.toString()}");
    return req; 

  }



}