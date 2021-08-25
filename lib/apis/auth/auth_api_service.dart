import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:http/http.dart' as http;

class AuthApiService {

  Future<http.Response?> duplicateEmail(String email) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/email?email=$email");
      final http.Response res = await http.get(uri, headers: BaseApiService.headers);
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> registerUser(dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/resister");
      final http.Response res = await http.post(
        uri,
        headers: BaseApiService.headers,
        body: body,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> registerUserSocialChk(dynamic body, String type) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/social/$type");
      final http.Response res = await http.post(
        uri,
        headers: BaseApiService.headers,
        body: body,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> loginUser(dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/login");
      final http.Response res = await http.post(
        uri,
        headers: BaseApiService.headers,
        body: body,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> loginToken(dynamic headers) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/me");
      final http.Response res = await http.get(
        uri,
        headers: headers,
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