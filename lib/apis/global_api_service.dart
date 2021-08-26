import 'package:http/http.dart' as http;
import './base_api_service.dart';

class GlobalApiService{
  Future<http.Response?> phoneAuth(dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/sms");
      final http.Response res = await http.post(
        uri,
        headers: BaseApiService.headers,
        body: body,
      );
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }
}