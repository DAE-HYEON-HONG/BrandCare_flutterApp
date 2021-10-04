import 'dart:convert';
import 'package:brandcare_mobile_flutter_v2/apis/auth/auth_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/userInfo_model.dart';

class AuthProvider {
  final AuthApiService _authApiService = AuthApiService();


  Future<dynamic> chkDuplicateEmail(String email) async {
    var res = await _authApiService.duplicateEmail(email);

    if(res == null){
      return null;
    }else{
      Map<String, dynamic> jsonMap = jsonDecode(res.body.toString());
      print(jsonMap);
      if(jsonMap.containsKey('data'))
        return (jsonMap['data']);
      return jsonMap['code'];
    }
  }

  Future<dynamic> registerUserEmail(String code, String email, String nickName, String password, String phone, String fcm) async{
    Map<String, dynamic> body = {
      "code" : code == "" ? null : code,
      "email" : email,
      "nickName" : nickName,
      "password" : password,
      "phone" : phone,
      "socialType" : "NORMAL",
      "fcmToken" : fcm,
    };
    final bodyJson = jsonEncode(body);
    var res = await _authApiService.registerUser(bodyJson);
    print(res!.body.toString());
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> jsonMap = jsonDecode(res.body.toString());
      print((jsonMap['data']));
    }
  }


  Future<dynamic> registerUserSocial(String code, String email, String nickName, String phone, String type, String sub, String fcm) async{
    Map<String, dynamic> body = {
      "code" : code == "" ? null : code,
      "email" : email,
      "nickName" : nickName,
      "phone" : phone,
      "socialType" : type,
      "appleCode" : sub,
      "fcmToken" : fcm,
    };
    final bodyJson = jsonEncode(body);
    var res = await _authApiService.registerUser(bodyJson);
    print(res!.body.toString());
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> jsonMap = jsonDecode(res.body.toString());
      print((jsonMap['data']));
    }
  }

  Future<dynamic> registerUserSocialChk(String token, String id, String type, String fcm)async{
    Map<String, String> body = {
      "id" : id,
      "token" : token,
      "fcmToken" : fcm,
    };
    final bodyJson = jsonEncode(body);
    var res = await _authApiService.registerUserSocialChk(bodyJson, type);
    if(res == null) {
      return null;
    }else {
      return res;
    }
  }

  Future<dynamic> loginUser(String email, String password, String fcmToken)async{
    Map<String, String> body = {
      "email" : email,
      "password" : password,
      "fcmToken" : fcmToken,
    };
    final bodyJson = jsonEncode(body);
    var res = await _authApiService.loginUser(bodyJson);
    if(res == null) {
      return null;
    }else {
      return res;
    }
  }

  Future<dynamic> loginToken(String token) async{
    var res = await _authApiService.loginToken(BaseApiService.authHeaders(token));
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return UserInfoModel.fromJson(json);
    }
  }

  Future<Map<String, dynamic>?> smsAuth(String phNum) async{
    Map<String, dynamic> body = {
      'phone' : phNum,
    };
    final bodyJson = jsonEncode(body);
    var res = await _authApiService.phoneAuth(bodyJson);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<Map<String, dynamic>?> phoneChkAuth(String phNum) async{
    var res = await _authApiService.phoneChkAuth(phNum);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<Map<String, dynamic>?> findId(String phNum) async {
    var res = await _authApiService.findId(phNum);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<Map<String, dynamic>?> findPw(String phNum, String email) async {
    var res = await _authApiService.findPassword(phNum, email);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }
  Future<Map<String, dynamic>?> updatePw(String email, String pw) async {
    var body = jsonEncode({
      "email" : email,
      "password" : pw,
    });
    print(body.toString());
    var res = await _authApiService.updatePw(body);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> deleteUser(int userIdx) async {
    var res = await _authApiService.deleteUser(userIdx);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

}