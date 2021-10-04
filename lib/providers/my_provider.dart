import 'dart:convert';
import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/apis/my/my_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/banner/banner_model.dart';
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
    var res = await _myApiService.genuineList(BaseApiService.authHeaders(token), page, sort);
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
    var body = jsonEncode({
      'phone' : number,
    });
    var res = await _myApiService.changeNumber(BaseApiService.authHeaders(token), body);
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
    print(res?.body.toString());
    if(res == null){
      return false;
    }else{
      return true;
    }
  }

  Future<dynamic> pointHistory(String token, int page) async {
    var res = await _myApiService.pointHistory(BaseApiService.authHeaders(token), page);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> couponHistory(String token, int page) async {
    var res = await _myApiService.couponHistory(BaseApiService.authHeaders(token), page);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> couponAdd(String token, String code) async {
    Map<String, dynamic> body = {
      'code' : code,
    };
    final bodyJson = jsonEncode(body);
    var res = await _myApiService.couponAdd(BaseApiService.authHeaders(token), bodyJson);
    if(res == null){
      return null;
    }
    Map<String, dynamic> json = jsonDecode(res.body.toString());
    if(json['code'] == "CP001"){
      return "notCoupon";
    }else if(json['code'] == "C004"){
      return "already";
    } else{
      return true;
    }
  }

  Future<dynamic> noticeList(int page) async {
    var res = await _myApiService.noticeList(BaseApiService.headers, page);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> addInquiry(String token, String title, String content) async {
    Map<String, dynamic> body = {
      'content' : content,
      'title': title,
    };
    final bodyJson = jsonEncode(body);
    var res = await _myApiService.addInquiry(BaseApiService.authHeaders(token), bodyJson);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> changeProfileImg(String token, File img) async {
    var res = await _myApiService.changeUserProfile(BaseApiService.authHeaders(token), img);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.toString());
      return json;
    }
  }

  Future<dynamic> getQna(int page) async {
    var res = await _myApiService.getQnA(page);
    print(res!.body.toString());
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> getBanner(String type) async{
    var res = await _myApiService.getBanner(type);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> getTerms() async{
    var res = await _myApiService.getTerms();
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> getInquiry(String token, int page) async{
    var res = await _myApiService.getInquiry(BaseApiService.authHeaders(token), page);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> reqPoint(String token, int page) async{
    var res = await _myApiService.reqPoint(BaseApiService.authHeaders(token), page);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<bool> changeAlarm(String token, int type) async {
    var res = await _myApiService.alarmSet(BaseApiService.authHeaders(token), type);
    if(res == null){
      return false;
    }else{
      return true;
    }
  }

  Future<dynamic> alarmList(String token, String type, int page)async{
    var res = await _myApiService.alarmList(BaseApiService.authHeaders(token), type, page);
    if(res == null) {
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> removeAllAlarm(String token)async{
    var res = await _myApiService.removeAllAlarms(BaseApiService.authHeaders(token));
    if(res == null) {
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> removeSelectAlarm(String token, String type, int id)async{
    var res = await _myApiService.removeSelectAlarms(BaseApiService.authHeaders(token), type, id);
    if(res == null) {
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }
}