import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:get/route_manager.dart';
import 'package:localstorage/localstorage.dart';

class Userapi {

 static Future<dynamic> getUser() async {
    var req = await getRequest("/user/get");

    return req;
  }


  static Future<void> updateDefaultHospital(int hospitalId) async {
    try {
    bool req = await postRequest("/user/setdefaulthospital", {"hospitalId" : hospitalId});
    print(req);
    if(req){
      localStorage.setItem("defaultHospital", hospitalId.toString());
      Get.to(MainScreen());
    }else {
      Get.snackbar("Error", "Please Try Again Later", snackPosition: SnackPosition.BOTTOM);
    }
    } catch (e) {
      Get.snackbar("Error", "Please Try Again Later", snackPosition: SnackPosition.BOTTOM);
    }
  }
}