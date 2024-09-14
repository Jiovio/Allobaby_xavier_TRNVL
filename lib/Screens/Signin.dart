

import 'package:allobaby/Config/responsive.dart';
import 'package:allobaby/Controller/AuthController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Screens/Initial/MomOrDad.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:allobaby/Screens/mobileverification/otpverification.dart';
import 'package:flutter/material.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otpless_flutter/otpless_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final _formKey = GlobalKey<FormState>();
Otpless otpLess = Otpless();


@override
void initState(){
  super.initState();

otpLess.initHeadless("82AR64JHBHZR3T3TEX1Q");
otpLess.setHeadlessCallback(onHeadlessResult);

// otpLess.openLoginPage((result) {
//     var message = "";
//     if (result['data'] != null) {
//         final token = result['response']['token'];
//         message = "token: $token";
//     } else {
//         message = result['errorMessage'];
//     }
// }, arg);

}


bool initiate = false;

bool verified = false;

void showWaitingVerification() {
  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        height: Get.height / 2,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please accept the verification request on WhatsApp.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              color: Colors.greenAccent,
              strokeWidth: 4,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                _launchUrl(Uri.parse("https://wa.me/7639744744")); // Replace with your WhatsApp link
              },
              icon: Icon(Icons.gamepad, color: Colors.white),
              label: Text(
                "Open in WhatsApp",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                // primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showConfirmed() {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Container(
        // height: Get.height / 3, // Adjusted height for a better fit
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              "Mobile Number Verified!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your mobile number has been verified successfully.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // primary: Colors.green, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void onHeadlessResult(dynamic result) {
  print(result);

  if(result["statusCode"]==200){
      if(result["responseType"]=="INITIATE"){
        initiate = true;
        String openChatUrl = result["response"]["destinationUri"];
        showWaitingVerification();
      }
      if(result["responseType"]=="ONETAP" && result["response"]["status"]=="SUCCESS"){
        Navigator.pop(context);
        showConfirmed();
      }
  }


	// setState(() {
	// 	// handle result to update UI
	// });
}

void sendOtp(){
Map<String, dynamic> arg = {};
arg["channel"] = "PHONE";
arg["phone"] = "7639744744";
arg["countryCode"] = "+91";
// otpLess.startHeadless(onHeadlessResult, arg);
showWaitingVerification();
// showConfirmed();

}

var arg = {
    'appId': "82AR64JHBHZR3T3TEX1Q",
};







  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(


        body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,

        child:  signinscreen(context),

        )
          
         
        ),

      ),
    );
  }

  //   getMobileFormWidget(context){
  //   return SingleChildScrollView(
  //     child: Container(
  //       height: MediaQuery.of(context).size.height,
  //       child: GetBuilder<GoogleSignInController>(
  //         builder: (controller) => 
          
  //         controller.isloading == true
  //             ? Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(White),
  //               backgroundColor: PrimaryColor,
  //             ))
  //             : 
  //       ),
  //     ),
  //   );
  // }


  signinscreen(context){

    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: PageView(children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        color: PrimaryColor,
                        padding: EdgeInsets.all(100),
                        child: 
                        
                        Image.asset(
                          "assets/General/mom_care_image_blue.png",

                          fit: BoxFit.contain,
                          

                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0),
                          child: Text(
                            'Personalised Pregnancy Care',
                            style: TextStyle(
                                color: darkGrey3,
                                fontSize: Responsive.isMobile(context)
                                    ? 18
                                    : 22,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  
                  
                  
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        color: PrimaryColor,
                        child: Image.asset(
                          "assets/onboarding/image12.png",
                          width: 350,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0),
                          child: Text(
                            'Helps you to consult Doctor Virtually',
                            style: TextStyle(
                                color: darkGrey3,
                                fontSize: Responsive.isMobile(context)
                                    ? 18
                                    : 22,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        color: PrimaryColor,
                        child: Image.asset(
                          "assets/onboarding/image13.png",
                          width: 350,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0),
                          child: Text(
                            'Engage with Doctor through video and audio',
                            style: TextStyle(
                                color: darkGrey3,
                                fontSize: Responsive.isMobile(context)
                                    ? 18
                                    : 22,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        color: PrimaryColor,
                        child: Image.asset(
                          "assets/onboarding/image14.png",
                          width: 350,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 24.0, right: 24.0),
                          child: Text(
                            'Keep on track your Health',
                            style: TextStyle(
                                color: darkGrey3,
                                fontSize: Responsive.isMobile(context)
                                    ? 18
                                    : 22,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  )
                ]),
              ),
              GetBuilder<Authcontroller>(
                init: Authcontroller(),
                builder:(controller) => 
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Mobile Number",
                          style: TextStyle(
                              fontSize: 14, color: PrimaryColor),
                        ),
                        Form(
                          key: _formKey,
                          child: IntlPhoneField(
                            controller: controller.phone,
                            keyboardType: TextInputType.phone,
                            // countryCodeTextColor:
                            // Get.isDarkMode ? White : Black,
                            decoration: InputDecoration(),
                            initialCountryCode: 'IN',
                            onChanged: (value) {
      
                            },
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(40))),
                            onPressed: ()  async{

                              if(int.tryParse(controller.phone.value.text)==null || int.parse(controller.phone.value.text) <1000000000 ){

                                Get.snackbar("Invalid Mobile Number", "Please Enter Valid Mobile Number",snackPosition: SnackPosition.BOTTOM);

                              }else{

                                sendOtp();
                            // controller.onSuccessLogin();

                              }
                            },
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ("SEND OTP"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // SizedBox(
                                  //   width: 18.0,
                                  // ),
                                  // Icon(Icons.arrow_forward_ios_rounded)
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text:
                              'By continuing, You agree that you have read and accept our ',
                              style: TextStyle(color: Black700),
                              children: [
                                TextSpan(
                                  text: 'T&C and Privacy Policy ',
                                  style: TextStyle(
                                    color: PrimaryColor,
                                  ),
                                )
                              ]),
                        ),

                        ElevatedButton(onPressed: (){

                          Get.to(MomOrDad());
                        }, child: Text("Signup"))
                      ],
                    ),
                  )))
            ],
          );
  }


  
}