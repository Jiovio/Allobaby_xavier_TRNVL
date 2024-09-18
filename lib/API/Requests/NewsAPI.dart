import 'package:allobaby/API/authAPI.dart';

class Newsapi {



  static Future<dynamic> getNews() async {
    var req = await getRequest("/news/");
    return req;
  }
}