import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../base_api_service.dart';
import 'package:http_parser/http_parser.dart';

class ShopApiService {
  Future<http.Response?> shopList(dynamic headers, int page, String searchWord, String type)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/shop?page=$page&query=$searchWord&type=$type");
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

  Future<dynamic> addShopProduct(dynamic headers, List<File> images, dynamic body) async {
    try {
      final uri = Uri.parse("${BaseApiService.baseApi}/shop");
      var req = http.MultipartRequest('POST', uri);
      req.files.add(
        http.MultipartFile.fromBytes(
          'dto',
          utf8.encode(body),
          contentType: MediaType(
            'application',
            'json',
            {'charset': 'utf-8'},
          ),
        ),
      );
      for (var file in images) {
        List<int> imageData = file.readAsBytesSync();
        req.files.add(
          http.MultipartFile.fromBytes(
            'images',
            imageData,
            filename: file.path
                .split("/")
                .last,
          ),
        );
      }
      req.headers.addAll(headers);
      http.StreamedResponse res = await req.send();
      final resReturn = await res.stream.bytesToString();
      if (res.statusCode == 200) {
        return resReturn;
      } else {
        return null;
      }
    } catch (e) {
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> shopDetail(dynamic headers, int idx)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/shop/$idx");
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

  Future<http.Response?> isLiked(dynamic headers, int idx)async{
    try{
      var body = jsonEncode({
        "shopId" : idx,
      });
      final uri = Uri.parse("${BaseApiService.baseApi}/shop/like");
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