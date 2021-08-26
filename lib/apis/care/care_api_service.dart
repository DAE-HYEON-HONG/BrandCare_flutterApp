import 'package:http/http.dart' as http;

import '../base_api_service.dart';

class CareApiService{
  Future<http.Response?> addCare(dynamic headers, dynamic body)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/inquiry");
      final http.Response res = await http.post(
        uri,
        headers: headers,
        body: body,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }
}