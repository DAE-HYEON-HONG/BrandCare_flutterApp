import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

class BaseApiService {


  static String baseApi = "http://192.168.100.216:6005/api/brc";
  static String imageApi = "http://192.168.100.216:6005/api/brc/image?path=";
  static Map<String, String> headers = {
    'Content-Type' : 'application/json',
  };

  static Map<String, String> authHeaders(String token){
    Map<String, String> headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token,
    };
    return headers;
  }
}