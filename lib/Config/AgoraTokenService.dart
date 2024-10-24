
import 'package:get/get.dart';

import 'agora_configs.dart';

class AgoraTokenService extends GetConnect {
  Future getAgoraToken(
    String channelName,
  ) async {
    // ignore: non_constant_identifier_names
    String Url = "" ;
    try {
      final response = await get(Url, contentType: 'application/json' , query: {'channel_name': channelName});
          // ,
          // query: {'channel_name': channelName}
     // print('-----response---------------------${response.bodyString}') ;
      if (response.hasError) {
        print("Area error");
      } else {
        var jsonString = response.bodyString;
        return Token ;
        //return response.body["Agora_token"];
      }
    } catch (exception) {
      print('-------------error---------------') ;
      return Future.error(exception.toString());
    }
  }
}
