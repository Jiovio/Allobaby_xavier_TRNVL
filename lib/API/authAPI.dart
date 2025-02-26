import 'dart:convert';
import 'package:allobaby/API/apiroutes.dart';
import 'package:allobaby/API/response.dart';
import 'package:allobaby/Components/bottom_nav.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:get/get.dart';
import 'package:allobaby/Screens/Signin.dart';
  dynamic getJwt() {
    final userJwt = localStorage.getItem("user");

    if(userJwt!=null) return json.decode(userJwt)["jwt"];

    return null;
  }


 dynamic getHeaders() {
  var headers = {"Authorization":"none"};
  String? jwt =  localStorage.getItem("user");
  if(jwt!=null){
    headers["Authorization"] = "Bearer ${json.decode(jwt)["jwt"]}";
  }
  return headers;
}

Future<dynamic> getRequest(str) async {
  final url = Uri.parse(Apiroutes().baseUrl+str); 

  try {

    final response = await http.get(url,
    headers: getHeaders()
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      saveData(str, response.body);
      return data;
    } else {
      // print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);

      return false;
    }
  } catch (e) {
    
    final d = getData(str);

    if(d!=null){

      Fluttertoast.showToast(msg: "No Internet");

      return d;
    }

    return false;
  }
}


Future<dynamic> putRequest(str,data) async {
  final url = Uri.parse(Apiroutes().baseUrl+str); 

  try {

    var h = getHeaders();

    final response = await http.put(url,
    headers: {
      "Content-Type": "application/json",
      ...h},
       body: json.encode(data)
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response data: $data');
      return data;
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);

      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return false;
  }
}


Future<dynamic> deleteRequest(str) async {
  final url = Uri.parse(Apiroutes().baseUrl+str); 

  try {

    final response = await http.delete(url,
    headers: getHeaders()
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response data: $data');
      return data;
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);

      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return false;
  }
}

Future<dynamic> postRequest(str,data) async {
  final url = Uri.parse((Apiroutes().baseUrl+str)); 

  try {

    dynamic h = getHeaders();

    final response = await http.post(url,
    headers: {
      "Content-Type": "application/json",
      ...h
      },
    body: json.encode(data));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print('Response data: $data');
      return data;
    } else {
      // print("------------------------------------------------------------");
      // print('Failed to load data. Status code: ${response.statusCode}');
      // print(response.body);
      // print("------------------------------------------------------------");

      throw "network Request Failed";

    }
  } catch (e) {
    print(e);
    throw "network Request Failed";
  }
}


Future<dynamic> refreshToken() async {
  final url = Uri.parse( (Apiroutes().baseUrl+"/auth/ca") ); 

  try {

    dynamic h = getHeaders();

    String? cookie = localStorage.getItem("refresh");

    final response = await http.post(url,
    headers: {
      "Content-Type": "application/json",
      "Cookie": "refresh=${cookie ?? "none"}",
      ...h
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      saveData("refresponse", response.body);

      print(data);

      final reset = data["reset"];


      if(reset){
        final user = localStorage.getItem("user");

        if(user!=null){

          final d = json.decode(user);
          d["jwt"] = data["jwt"];

          localStorage.setItem("user", json.encode(d));

          

        }else{
          throw "logout";
          print("Logout");
        }

        

      }
    } 
    else if (response.statusCode == 403) {

      print("User Not Found");


    Get.dialog(AlertDialog(
      title: Text("Invalid Session"),
      content: Text("Your session is invalid. Please log in again"),

      actions: [
        TextButton.icon(onPressed: () async {

        await Get.delete<Maincontroller>();
        await Get.delete<Signupcontroller>();

        await Get.delete<Usercontroller>();
        await Get.delete<NavController>(force: true);

        localStorage.clear();
        

        Get.offAll(()=>const Signin());
        Get.snackbar("Logout Successfull".tr, "",snackPosition: SnackPosition.BOTTOM);

        }, icon: Icon(Icons.check),
        label: Text("Login"),
        )
      ],
    ));

    throw "Error";



    }
    else {
      print("------------------------------------------------------------");
      print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);
      print("------------------------------------------------------------");
       Get.dialog(Container(child: const Text("No Internet !"),));
      throw "failed";

    }
  } catch (e) {

    final d = getData("refresponse");

    print("resp : $d");

    if(d!=null){
      // return d;
      return;
    }

    print(e);
     showNoInternetDialog();
    throw "failed";
  }
}


void showNoInternetDialog() {
  Get.dialog(
    barrierDismissible: false,
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.signal_wifi_off,
                  color: Colors.red,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text(
                  'No Internet!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Please check your internet connection and try again.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => Get.back(),
            //   child: const Text(
            //     'OK',
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}

// New

Future<APIResponse> newPostRequest(str,data) async {
  final url = Uri.parse((Apiroutes().baseUrl+str)); 

  try {

    dynamic h = getHeaders();

    final response = await http.post(url,
    headers: {
      "Content-Type": "application/json",
      ...h
      },
    body: json.encode(data));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      return APIResponse(success: true, map: data);
    } else {
      // print("------------------------------------------------------------");
      // print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);
      // print("------------------------------------------------------------");
      return APIResponse(success: false, map: response.body);

    }
  } catch (e) {
      return APIResponse(success: false, map: {"detail":"Network Error"});
  }

  return APIResponse(success: true, map: data);
}

Future<APIResponse> newGetRequest(str) async {
  final url = Uri.parse(Apiroutes().baseUrl+str); 

  try {

    final response = await http.get(url,
    headers: getHeaders()
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print('Response data: $data');
      return APIResponse(success: true, map: data);
    } else {
      // print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);

      return APIResponse(success: false, map: response.body);
    }
  } catch (e) {
    // print('An error occurred: $e');
    print(e);
    return APIResponse(success: false, map: {"detail":"Network Error"}, networkError: true);
  }
}


Future<APIResponse> newDeleteRequest(str) async {
  final url = Uri.parse(Apiroutes().baseUrl+str); 

  try {

    final response = await http.delete(url,
    headers: getHeaders()
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response data: $data');
      return  APIResponse(success: true, map: response.body);

    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);

      return APIResponse(success: false, map: response.body);
    }
  } catch (e) {
    print('An error occurred: $e');
    return APIResponse(success: false, map: {"detail":"Network Error"});
  }
}


void saveData(String key, dynamic value){
  print("saved :: $key :: $value");
  localStorage.setItem(key, value);


}

dynamic getData(String key){

  final val = localStorage.getItem(key);

  print("got ** $val");

  if(val!=null){
  final data = jsonDecode(val);

    return data;
  }else{
    return null;
  }



  


}