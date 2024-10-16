import 'package:allobaby/API/authAPI.dart';

class Hospitalapi { 


  static Future<dynamic> getHospitalList() async {
    var req = await getRequest("/hospital/getlist");
    return req;
  }

  static Future<dynamic> getDefaultChatAgent(id) async {
      final req = await getRequest("/hospital/getdefault?hospital_id=$id");
      return req;
}
}