import 'dart:convert';
import 'package:brandcare_mobile_flutter_v2/apis/auth/auth_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/UserInfo_model.dart';

class AuthProvider {
  final AuthApiService _authApiService = AuthApiService();

  // Future<Model> getMe() async {
  //   var response = await _authApiService.asdads();
  //   toJson
  //   fromJson
  // 모델로 리턴 해주어야 함.
  // }
  Future<dynamic> chkDuplicateEmail(String email) async {
    var res = await _authApiService.duplicateEmail(email);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> jsonMap = jsonDecode(res.body.toString());
      return (jsonMap['data']);
    }
  }

  Future<dynamic> registerUserEmail(String code, String email, String nickName, String password, String phone) async{
    Map<String, dynamic> body = {
      "code" : code == "" ? null : code,
      "email" : email,
      "nickName" : nickName,
      "password" : password,
      "phone" : phone,
      "socialType" : "NORMAL"
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


  Future<dynamic> registerUserSocial(String code, String email, String nickName, String phone, String type) async{
    Map<String, dynamic> body = {
      "code" : code == "" ? null : code,
      "email" : email,
      "nickName" : nickName,
      "phone" : phone,
      "socialType" : type,
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

  Future<dynamic> registerUserSocialChk(String token, String id, String type)async{
    Map<String, String> body = {
      "id" : id,
      "token" : token,
    };
    final bodyJson = jsonEncode(body);
    var res = await _authApiService.registerUserSocialChk(bodyJson, type);
    if(res == null) {
      return null;
    }else {
      return res;
    }
  }

  Future<dynamic> loginUser(String email, String password)async{
    Map<String, String> body = {
      "email" : email,
      "password" : password,
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
}