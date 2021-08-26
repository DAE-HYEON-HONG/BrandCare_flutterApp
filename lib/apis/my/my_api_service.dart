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
}