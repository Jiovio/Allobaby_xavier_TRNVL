import 'dart:math';

import 'package:allobaby/Config/AgoraTokenService.dart';
import 'package:get/get.dart';


class CallUtils {
  
}

const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

// ignore: non_constant_identifier_names
String RandomString(int strlen) {
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  print("results -------------------- $result") ;
  return result;
}
