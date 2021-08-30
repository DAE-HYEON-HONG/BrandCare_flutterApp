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
}