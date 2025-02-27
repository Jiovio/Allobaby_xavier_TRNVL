

import 'package:allobaby/API/authAPI.dart';
import 'package:allobaby/Config/responsive.dart';
import 'package:allobaby/Controller/AuthController.dart';
import 'package:allobaby/Controller/MainController.dart';
import 'package:allobaby/Controller/SignupController.dart';
import 'package:allobaby/Screens/Initial/MomOrDad.dart';
import 'package:allobaby/Screens/Main/MainScreen.dart';
import 'package:allobaby/Screens/mobileverification/otpverification.dart';

import 'package:flutter/material.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:url_launcher/url_launcher.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final _formKey = GlobalKey<FormState>();


Signupcontroller signupCont = Get.put(Signupcontroller());


@override
void initState(){
  super.initState();

}


bool initiate = false;

bool verified = false;

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


  signinscreen(context){

    return 
    
    Column(
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
                            'Personalised Pregnancy Care'.tr,
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
                            'Helps you to consult Doctor Virtually'.tr,
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
                            'Engage with Doctor through video and audio'.tr,
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
                            'Keep on track your Health'.tr,
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
              GetBuilder<Signupcontroller>(
                init: Signupcontroller(),
                builder:(controller) => 
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Mobile Number".tr,
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
                            onCountryChanged: (value) {
                              controller.countryCode = value.dialCode;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Center(
                          child: Obx(
                            ()=> ElevatedButton(
                                
                              style: ElevatedButton.styleFrom(
                                  minimumSize:const Size(100, 45),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(40))),
                              onPressed:
                              controller.loading.value?
                              (){}
                              :
                               ()  async{
                            
                                if(int.tryParse(controller.phone.value.text)==null || int.parse(controller.phone.value.text) <1000000000 ){
                            
                                  Get.snackbar("Invalid Mobile Number", "Please Enter Valid Mobile Number",snackPosition: SnackPosition.BOTTOM);
                            
                                }else{
                                  controller.startLoading();
                                  await controller.sendOtp(); 
                                  controller.stopLoading();

                                  // Get.to(MomOrDad());
                                }
                              },
                              child:
                              controller.loading.value?
                              const CircularProgressIndicator(color: White,):
                               Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ("SEND OTP".tr),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                            
                                  ]),
                                  
                            ),
                          ),
                        ),
                        
                        
                        SizedBox(
                          height: 18,
                        ),
                        GestureDetector(
                          onTap: () async {
                              const url =
                              'https://savemom.in/terms.html';
                          _launchURL(url);
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                'By continuing, You agree that you have read and accept our '.tr,
                                style: TextStyle(color: Black700),
                                children: [
                                  TextSpan(
                                    text: 'T&C and Privacy Policy '.tr,
                                    style: TextStyle(
                                      color: PrimaryColor,
                                    ),
                                  )
                                ]),
                          ),
                        ),

                        // ElevatedButton(onPressed: (){
                        //   Get.to(Ai());
                        // }, child: Text("AI")),

                        //                         ElevatedButton(onPressed: (){
                        //   Get.to(Googlesignin());
                        // }, child: Text("gs"))
                      ],
                    ),
                  )))
            ],
          );
  }




  void  _launchURL(String url) async {
      print(Uri.https(Uri.encodeComponent(url)));
      // await launchUrl(Uri.https(Uri.encodeComponent(url)));
      await launchUrl(Uri.parse(url));

  }


  
}