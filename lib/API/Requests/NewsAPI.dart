import 'package:allobaby/API/authAPI.dart';

class Newsapi {



  static Future<dynamic> getNews() async {
    var req = await getRequest("/news/");
    return req;
  }


    static Future<dynamic> getReels() async {
    var req = await getRequest("/news/getreels");

    print(req);
    return req;
  }
}