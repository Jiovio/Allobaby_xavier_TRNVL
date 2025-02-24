import 'package:allobaby/API/authAPI.dart';

class SelfscreeningApi {



  static Future<dynamic> create(data) async {
    var req = await postRequest("/selfscreening/create",data);
    return req;
  }



}