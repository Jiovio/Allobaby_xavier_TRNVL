

import 'package:allobaby/API/authAPI.dart';

class Otpapi {
  static Future sendOtp(String phone)async{
    var req = await postRequest("/otp/generate-otp", {"phone":phone});
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
}