import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/product/product_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/addProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'dart:io';

class ProductProvider {
  final ProductApiService _productApiService = ProductApiService();

  Future<dynamic> productApply(AddProductModel model, List<File> images, File frontImg, File backImg, File leftImg, File rightImg) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    var body = jsonEncode(model);
    final res = await _productApiService.addProduct(
      BaseApiService.authHeaders(token!),
      body,
      images,
      frontImg,
      backImg,
      leftImg,
      rightImg,
    );
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.toString());
      return json;
    }
  }

  Future<Map<String, dynamic>?> getMyProduct() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.getMyProduct(token!);
    if(res != null) {
      return jsonDecode(res.body);
    }
    return null;
  }

  Future<Map<String, dynamic>?> changeProduct(Map<String, dynamic> data) async {
  final String? token = await SharedTokenUtil.getToken("userLogin_token");
  final res = await _productApiService.changeProduct(token: token!, data: data);
  if(res != null) {
    return jsonDecode(res.body);
  }
  return null;
  }

  Future<Map<String, dynamic>?> changeProductCancel(Map<String, dynamic> data) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.changeProductCancel(token!, data);
    if(res != null) {
      return jsonDecode(res.body);
    }
    return null;
  }
  Future<Map<String, dynamic>?> changeProductAccept(Map<String, dynamic> data) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.changeProductAccept(token!, data);
    if(res != null) {
      return jsonDecode(res.body);
    }
    return null;
  }
  Future<Map<String, dynamic>?> getChangeProduct(String status) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.getProductChangeList(token!, status);
    if(res != null) {
      return jsonDecode(res.body);
    }
    return null;
  }
  Future<Map<String, dynamic>?> getChangeProductOnce(int id, String status) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.getProductChangeOnce(token!, id, status);
    if(res != null) {
      return jsonDecode(res.body);
    }
    return null;
  }

}