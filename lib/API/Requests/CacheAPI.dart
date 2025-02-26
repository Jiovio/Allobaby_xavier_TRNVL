

import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/response.dart';

class Cacheapi {



    static Future<APIResponse> get(String key) async {
    var req = await newGetRequest("/cache/get?id=$key");
    return req;
  }


      static Future<APIResponse> create(String key, Map<String , dynamic> data) async {
    var req = await newPostRequest("/cache/create",{
      "id": key, "response" : data
    });
    return req;
  }



}