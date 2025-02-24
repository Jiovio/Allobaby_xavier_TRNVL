
class APIResponse {

  bool success;

  String detail = "";
  dynamic id;


  APIResponse({ required this.success ,required dynamic map}){

    fromJson(map);

  }



  fromJson(map){
    detail = map["detail"]?? true;
    id = map["id"] ;
  }


}