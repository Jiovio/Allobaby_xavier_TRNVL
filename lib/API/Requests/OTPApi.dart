

import 'package:allobaby/API/authAPI.dart';

class Otpapi {
  static Future sendOtp(String phone, String countryCode)async{
    var req = await postRequest("/otp/generate-otp", {
      "phone":phone,
      "country_code" : countryCode
      });
    print(req);
    return req;
  }


  static Future<bool> verifyOTP(otp,id) async {
    var d = {
      "otp_code":otp,
      "opt_id":id
    };

    print(d);

    var req = await postRequest("/otp/verify-otp", d);

    bool verified = req["verified"];

    return verified;

  }


    static Future<bool> verifyOTPS(otp,id) async {
    var d = {
      "otp_code":otp,
      "opt_id":id,
      "type":"allobaby"
    };

    print(d);

    var req = await postRequest("/otp/verify-otp", d);

    return req;

  }
}