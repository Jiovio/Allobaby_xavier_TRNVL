
class APIResponse {

  bool success;

  String detail = "";
  dynamic id;

  bool created = false;

  dynamic items = [];

  int itemCount = 0;

  dynamic item = null;

  bool networkError = false;


  APIResponse({ required this.success ,required dynamic map , this.networkError = false}){

    fromJson(map);

  }



  fromJson(map){
    detail = map["detail"]?? "No Response";
    id = map["id"] ;
    created = map["created"] ?? false;
    items = map["items"] ?? [];
    itemCount = map["count"] ?? 0;
    item = map["item"] ?? null;
  }


}