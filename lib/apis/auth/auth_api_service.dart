import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:http/http.dart' as http;

class AuthApiService {


  Future<http.Response?> duplicateEmail(String email) async {
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/email?email=$email");
      final http.Response res = await http.get(uri, headers: BaseApiService.headers);
      if(res.statusCode == 500 || res.statusCode == 200){
        return res;
      }else{
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
        print(res.body.toString());
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> phoneAuth(dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/sms");
      final http.Response res = await http.post(
        uri,
        headers: BaseApiService.headers,
        body: body,
      );
      if(res.statusCode == 200) {
        return res;
      }
      // }else{
      //   return null;
      // }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      // return null;
    }
    return null;
  }

  Future<http.Response?> findId(String phNum) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/find-id?phone=$phNum");
      final http.Response res = await http.get(
        uri,
        headers: BaseApiService.headers,
      );
      if(res.statusCode == 200) {
        return res;
      }
      if(res.statusCode == 400){
        return res;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
    }
    return null;
  }

  Future<http.Response?> findPassword(String phNum, String email) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/find-password?email=$email&phone=$phNum");
      final http.Response res = await http.get(
        uri,
        headers: BaseApiService.headers,
      );
      if(res.statusCode == 200) {
        return res;
      }
      if(res.statusCode == 400){
        return res;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
    }
    return null;
  }

  Future<http.Response?> updatePw(dynamic body) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/auth/password");
      final http.Response res = await http.put(
        uri,
        headers: BaseApiService.headers,
        body: body,
      );
      print(res.body.toString());
      if(res.statusCode == 200) {
        return res;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
    }
    return null;
  }

  Future<http.Response?> deleteUser(int userIdx) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/manage/user/$userIdx");
      final http.Response res = await http.post(
        uri,
        headers: BaseApiService.headers,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }
}