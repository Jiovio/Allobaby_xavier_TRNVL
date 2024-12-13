
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Controller/UserController.dart';
import 'package:allobaby/intl/TranslationService.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

languageSelectDialog(BuildContext context) {
  final Usercontroller usercontroller = Get.put(Usercontroller());
  return showDialog(
      
      builder: (BuildContext context) => AlertDialog(
          contentPadding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          title: Text("Select Language".tr),
          backgroundColor: White,
          content: Container(
            width: double.minPositive,
            height: 230,
            child: ListView.builder(
              
              // shrinkWrap: true,
              itemCount: TranslationService.langs.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(
                    TranslationService.langs[index],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  trailing: 

                  
                  GetBuilder<Usercontroller>(
                    // init: Usercontroller(),
                    builder:(controller) => 
                      Radio(
                            activeColor: PrimaryColor,
                            value: TranslationService.langs[index],
                            groupValue: controller.locale,
                            onChanged: (val) {
                              TranslationService().changeLocale(val.toString());
                              controller.locale = val!;
                              // print(controller.locale);

                              controller.update();

                              print(val.toString());

                              localStorage.setItem("lang", val.toString());
                              
                              Fluttertoast.showToast(
                                  msg: "Language Changed to $val",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              // controller.onSelectLang(val);
                              Navigator.pop(context);
                            },
                          ))),
            ),
          
          )),
      context: context);
}

class LanguageController extends GetxController {
  String selectedLang =
      TranslationService().getLanguageFromLocal("en");
  void onSelectLang(lang) {
    selectedLang = lang;
    update();
  }
  
}