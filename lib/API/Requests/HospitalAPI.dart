import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/API/local/Storage.dart';

class Hospitalapi { 


  static Future<dynamic> getHospitalList() async {
    var req = await getRequest("/hospital/getlist");
    return req;
  }

  static Future<dynamic> getDefaultChatAgent(id) async {
      final req = await getRequest("/hospital/getdefault?hospital_id=$id");
      return req;
}

  static Future<dynamic> searchHospital(hospitalName) async {
      final req = await getRequest("/hospital/search-hospitals?query=$hospitalName");
      return req;
}


  static Future<dynamic> getDoctors(hospitalid) async {
      final req = await getRequest("/hospital/get_doctors?hospitalid=$hospitalid");
      return req;
}

  static Future<dynamic> getDoctorAppointmentsbyDate(doctorid,DateTime date) async {
      final req = await postRequest("/doctor/availability/doctor",{
        "doctor_id":doctorid,
        "date":date.toIso8601String()
      });
      return req;
}


  static Future<dynamic> createAppointment(dynamic data) async {
      final req = await postRequest("/appointment/create",data);
      return req;
}


  static Future<dynamic> getScheduledAppointments() async {

    final id = Storage.getUserID();
      final req = await getRequest("/appointment/getpendingappointments");
      print(req);
      return req;
}


  static Future<dynamic> getAllAppointmentsByUesr() async {

    final id = Storage.getUserID();
      final req = await getRequest("/appointment/getbypatient?patient_id=$id");
      print(req);
      return req;
}

  static Future<bool> cancelAppointment(int id) async {
      final req = await deleteRequest("/appointment/cancelbyid?id=${id.toString()}");
      return req;
}






}