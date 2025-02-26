import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/response.dart';

class SelfscreeningApi {



  static Future<APIResponse> create(data) async {
    var req = await newPostRequest("/selfscreening/create",data);
    return req;
  }



  static Future<APIResponse> getHistory(int page, int count) async {
    var req = await newGetRequest("/selfscreening/getpage?page=${page.toString()}&count=${count.toString()}");

    print(req.detail);
    return req;
  }


    static Future<APIResponse> getAppointmentSelfScreeningData(int appointmentID) async {
    var req = await newGetRequest("/selfscreening/getappointment?id=${appointmentID.toString()}");

    print(req.detail);
    return req;
  }



}