import 'package:allobaby/API/Requests/NewsAPI.dart';
import 'package:get/get.dart';

class Newscontroller extends GetxController {

  Future<void> getNewsfromServer() async {
    var d = await  Newsapi.getNews();
    print(d);
    news = d;
    loading.value = false;
    update();
  }

  RxBool loading = true.obs;


  @override
 void onInit() {
  super.onInit();
  getNewsfromServer();

  }

  List<dynamic> news = [];



}