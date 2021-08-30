import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../base_api_service.dart';
import 'package:http_parser/http_parser.dart';

class ProductApiService {

  Future<dynamic> addProduct(
      dynamic headers,
      dynamic body,
      List<File> images,
      File frontImg,
      File backImg,
      File leftImg,
      File rightImg) async {
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
      //이미지 리스트
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
      //앞면 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
          'frontImage',
          frontImg.readAsBytesSync(),
          filename: frontImg.path.split("/").last
        ),
      );
      //뒷면 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
            'backImage',
            backImg.readAsBytesSync(),
            filename: backImg.path.split("/").last
        ),
      );
      //왼쪽 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
            'leftImage',
            leftImg.readAsBytesSync(),
            filename: leftImg.path.split("/").last
        ),
      );
      //오른쪽 이미지
      req.files.add(
        http.MultipartFile.fromBytes(
            'rightImage',
            rightImg.readAsBytesSync(),
            filename: rightImg.path.split("/").last
        ),
      );
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

}