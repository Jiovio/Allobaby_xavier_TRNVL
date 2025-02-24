import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/response.dart';

class SelfscreeningApi {



  static Future<APIResponse> create(data) async {
    var req = await newPostRequest("/selfscreening/create",data);
    return req;
  }



}