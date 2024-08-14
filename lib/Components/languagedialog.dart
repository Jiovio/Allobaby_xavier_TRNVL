import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/intl/TranslationService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../main.dart';

languageSelectDialog(BuildContext context) {
  return showDialog(
      builder: (BuildContext context) => AlertDialog(
          contentPadding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          title: Text("Select Language".tr),
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
                      Radio(
                            activeColor: PrimaryColor,
                            value: TranslationService.langs[index],
                            groupValue: "English",
                            onChanged: (val) {
                              // TranslationService().changeLocale(val.toString());
                              // data.write(
                              //     'lang',
                              //     TranslationService()
                              //         .getLocaleFromLanguage(val.toString())
                              //         .toString());
                              // Fluttertoast.showToast(
                              //     msg: "Language Changed to $val",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     backgroundColor: Colors.black54,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0);
                              // controller.onSelectLang(val);
                              // Navigator.pop(context);
                            },
                          )),
            ),
          
          )),
      context: context);
}

class LanguageController extends GetxController {
  // String selectedLang = TranslationService().getLanguageFromLocal(data.read('lang'));
  String selectedLang = TranslationService().getLanguageFromLocal('en');

  void onSelectLang(lang) {
    selectedLang = lang;
    update();
  }
}
