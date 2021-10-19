import 'dart:io';

import 'package:http/http.dart' as http;

import '../base_api_service.dart';

class MyApiService{
  Future<http.Response?> chkMyProfile(dynamic headers)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/my");
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

  Future<http.Response?> productList(dynamic headers, int page, String sort) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/product/mine?page=$page&sort=$sort");
      print(uri.toString());
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

  Future<http.Response?> careList(dynamic headers, int page, String sort) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/care/history?page=$page&sort=$sort");
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

  Future<http.Response?> genuineList(dynamic headers, int page, String sort) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/activation/history?page=$page&sort=$sort");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      print("$page $sort");
      print(res.body.toString());
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

  Future<http.Response?> changeName(dynamic headers, dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/nickname");
      final http.Response res = await http.put(
        uri,
        headers: headers,
        body: body
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

  Future<http.Response?> changePassword(dynamic headers, dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/password");
      final http.Response res = await http.put(
          uri,
          headers: headers,
          body: body
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> changeNumber(dynamic headers, dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/phone");
      final http.Response res = await http.put(
          uri,
          headers: headers,
          body: body
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> changeAddress(dynamic headers, dynamic body) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/address");
      final http.Response res = await http.put(
          uri,
          headers: headers,
          body: body
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> pointHistory(dynamic headers, int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/point?page=$page");
      final http.Response res = await http.get(
          uri,
          headers: headers,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> couponHistory(dynamic headers, int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/coupon?page=$page");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> couponAdd(dynamic headers, dynamic code) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/coupon/code");
      final http.Response res = await http.post(
        uri,
        headers: headers,
        body: code
      );
      print(res.body.toString());
      if(res.statusCode == 500){
        return res;
      }else if(res.statusCode == 404){
        return null;
      }
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> noticeList(dynamic headers, int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/notice/list?page=$page");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> addInquiry(dynamic headers, dynamic body) async {
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

  Future<dynamic> changeUserProfile(dynamic headers, File profileImg)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/profile");
      var req = http.MultipartRequest('POST', uri);
      req.files.add(
        http.MultipartFile.fromBytes(
          'image',
          profileImg.readAsBytesSync(),
          filename: profileImg.path.split("/").last,
        ),
      );
      req.headers.addAll(headers);
      http.StreamedResponse res = await req.send();
      final resReturn = await res.stream.bytesToString();
      if(res.statusCode == 200){
        return resReturn;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> getQnA(int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/faq?page=$page");
      final http.Response res = await http.get(
        uri,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> getBanner(String type) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/banner-list?type=$type");
      final http.Response res = await http.get(
        uri,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> getTerms() async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/terms");
      final http.Response res = await http.get(
        uri,
      );
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> getInquiry(dynamic headers, int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/inquiry/mine?page=$page");
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

  Future<http.Response?> reqPoint(dynamic headers, int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/point?page=$page");
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

  Future<http.Response?> reqAlarmList(dynamic headers) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/alarm?page=1&type=HISTORY");
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

  Future<http.Response?> alarmSet(dynamic headers, int type) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/alarm/$type");
      final http.Response res = await http.post(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> alarmList(dynamic headers, String type, int page) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/alarm/$type?page=$page");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> removeAllAlarms(dynamic headers) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/read/ALL/1");
      final http.Response res = await http.post(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 404 || res.statusCode == 500){
        return null;
      }
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> removeSelectAlarms(dynamic headers, String type, int id) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/user/read/$type/$id");
      final http.Response res = await http.post(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 404 || res.statusCode == 500){
        return null;
      }
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> sendFileEmail(dynamic headers, String email) async {
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/genuine/email?=$email");
      final http.Response res = await http.post(
        uri,
        headers: headers,
      );
      print(res.body.toString());
      if(res.statusCode == 404 || res.statusCode == 500){
        return null;
      }
      return res;
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }
}