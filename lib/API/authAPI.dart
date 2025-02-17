import 'dart:convert';
import 'package:allobaby/API/apiroutes.dart';
import 'package:flutter/material.dart';
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
      // print('Response data: $data');
      return data;
    } else {
      // print('Failed to load data. Status code: ${response.statusCode}');
      print(response.body);

      return false;
    }
  } catch (e) {
    // print('An error occurred: $e');
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
  final url = Uri.parse(( Apiroutes().baseUrl+"/auth/ca")); 

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
      print("Logout");
      localStorage.clear();
      Get.offAll(Signin());
      throw "logout";
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
    print(e);
     Get.dialog(Container(child: const Text("No Internet !"),));
    throw "failed";
  }
}