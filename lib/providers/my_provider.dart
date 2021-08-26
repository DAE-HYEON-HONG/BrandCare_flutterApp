import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/my/my_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/myProfileInfo_model.dart';

class MyProvider{
  final MyApiService _myApiService = MyApiService();

  Future<dynamic> chkMyProfile(String token) async{
    var res = await _myApiService.chkMyProfile(BaseApiService.authHeaders(token));
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return MyProfileInfoModel.fromJson(json);
    }
  }

  Future<dynamic> productList(String token, int page, String sort) async {
    var res = await _myApiService.productList(BaseApiService.authHeaders(token), page, sort);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> caretList(String token, int page, String sort) async {
    var res = await _myApiService.careList(BaseApiService.authHeaders(token), page, sort);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> genuineList(String token, int page, String sort) async {
    var res = await _myApiService.careList(BaseApiService.authHeaders(token), page, sort);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<bool> changeName(String token, String name) async {
    Map<String, dynamic> body = {
      'nickName' : name,
    };
    final bodyJson = jsonEncode(body);
    var res = await _myApiService.changeName(BaseApiService.authHeaders(token), bodyJson);
    if(res == null){
      return false;
    }else{
      return true;
    }
  }

  Future<dynamic> changePassword(String token, String password, String currentPassword) async {
    Map<String, dynamic> body = {
      'changePassword' : password,
      'currentPassword' : currentPassword,
    };
    final bodyJson = jsonEncode(body);
    var res = await _myApiService.changePassword(BaseApiService.authHeaders(token), bodyJson);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> changeNumber(String token, String number) async {
    Map<String, dynamic> body = {
      'phone' : number,
    };
    final bodyJson = jsonEncode(body);
    var res = await _myApiService.changePassword(BaseApiService.authHeaders(token), bodyJson);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<bool> changeAddress(String token, String city, String street, String zipCode) async {
    Map<String, dynamic> body = {
      'city' : city,
      'street': street,
      'zipCode' : zipCode,
    };
    final bodyJson = jsonEncode(body);
    var res = await _myApiService.changeAddress(BaseApiService.authHeaders(token), bodyJson);
    if(res == null){
      return false;
    }else{
      return true;
    }
  }
}