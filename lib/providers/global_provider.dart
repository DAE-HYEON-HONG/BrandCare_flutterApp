import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';

class GlogalProvider{
  final GlobalApiService _globalApiService = GlobalApiService();

  Future<dynamic> smsAuth(String phNum) async{
    Map<String, dynamic> body = {
      'phNum' : phNum,
    };
    final bodyJson = jsonEncode(body);
    var res = await _globalApiService.phoneAuth(bodyJson);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }
}