import 'package:allobaby/API/authAPI.dart';
import 'package:localstorage/localstorage.dart';

class Userapi {

 static Future<dynamic> getUser() async {
    var req = await getRequest("/user/get");

    return req;
  }


  
  
}