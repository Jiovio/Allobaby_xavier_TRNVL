
class APIResponse {

  bool success;

  String detail = "";
  dynamic id;

  bool created = false;


  APIResponse({ required this.success ,required dynamic map}){

    fromJson(map);

  }



  fromJson(map){
    detail = map["detail"]?? true;
    id = map["id"] ;
    created = map["created"] ?? false;
  }


}