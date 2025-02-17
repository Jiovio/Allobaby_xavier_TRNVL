import 'package:allobaby/API/authAPI.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

class Apiroutes {
  // String baseUrl = "https://dev.savemom.app";
  String baseUrl = "http://10.0.2.2:8000";
  // String baseUrl ="https://production-server-800848206554.asia-south1.run.app";

  static checkUser () {
    if(localStorage.getItem("user")==null){
      return false;
    }
    return true;
  }

  String otpSessionCreation = "/auth/otp";

  String getUrl(String route){
    return baseUrl+route;
  }

  Future<dynamic> getUserByPhone(phone) async {
      try {
      var d = await postRequest("/user/login/$phone",{});
      if(d!=null){
        // print(d);
        return d;
      }else{
        return false;
      }
        
      } catch (e) {
        return false;
      }
  }


    Future<dynamic> createUser(Map<String,dynamic> data) async {
      // print(data);
      try {
      var d = await postRequest("/user/",data);
      if(d!=null){
        return d;
      }else{
        return false;
      }
        
      } catch (e) {
        print(e);
        return false;
      }
  }


  Future<void> checkAuth() async {

      var d = await getRequest("/auth/protected");

      // print(d);


  }
}