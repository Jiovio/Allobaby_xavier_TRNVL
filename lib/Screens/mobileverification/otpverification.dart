import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Main/Home.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:pin_code_fields/pin_code_fields.dart';

class Otpverification extends StatelessWidget {

   Otpverification({super.key});

   Signupcontroller controller = Get.put(Signupcontroller());

  @override
  Widget build(BuildContext context) {
       return 
      //  GetBuilder<GoogleSignInController>(
        // builder: (controller) => controller.isloading == 
        false
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(White),
                backgroundColor: PrimaryColor,
              ))
            : Scaffold(
                appBar: AppBar(
                  title: Text("OTP Verification")
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OTP VERIFICATION",
                        style: TextStyle(
                          color: 
                          // Get.isDarkMode 
                          true? White : Black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Enter OTP sent to ",
                            style: TextStyle(
                                color: 
                                // Get.isDarkMode 
                                false? White : Black,
                                fontSize: 16),
                            children: [
                              TextSpan(
                                  // text: "+91 9363286517",
                                  text: "+${controller.countryCode} ${controller.phone.text}",

                                
                                  // data.read('mobileNo'),
                                  style: TextStyle(
                                    color: PrimaryColor,
                                  ))
                            ]),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      PinCodeTextField(
                        controller: controller.otp,
                        textStyle: TextStyle(
                          color: 
                          // Get.isDarkMode 
                          false? White : Black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter OTP';
                          }
                          return null;
                        },
                        // controller: otpCode,
                        backgroundColor: Colors.transparent,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        appContext: context,
                        length: 6,
                        animationType: AnimationType.slide,
                        pinTheme: PinTheme(
                          selectedColor: PrimaryColor,
                          activeColor: PrimaryColor,
                          fieldHeight: 50.0,
                          fieldWidth: 38.0,
                          inactiveColor: Black700,
                          shape: PinCodeFieldShape.underline,
                        ),
                        showCursor: false,
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {},
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: controller.verifyOtp,
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(("Verify and proceed").toUpperCase()),
                                SizedBox(
                                  width: 18.0,
                                ),
                                Icon(Icons.arrow_forward)
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              );
  
  }
}

