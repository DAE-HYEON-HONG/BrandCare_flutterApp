import 'package:http/http.dart' as http;

import '../base_api_service.dart';

class ShopApiService {
  Future<http.Response?> shopList(dynamic headers, int page, String searchWord, String type)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/shop");
      final http.Response res = await http.post(
        uri,
        headers: headers,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }
}