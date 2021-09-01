import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/shop/shop_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/shopDetail_model.dart';

class ShopProvider{
  final ShopApiService _shopApiService = ShopApiService();
  Future<dynamic> shopList(String token, int page, String searchWord, String type) async {
    var res = await _shopApiService.shopList(BaseApiService.authHeaders(token), page, searchWord, type);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> addShopProduct({
    required String token,
    required AddProductShopModel model,
  }) async {
    var body = jsonEncode({
      "title": model.title,
      "content": model.content,
      "price": model.price,
      "productId": model.productIdx,
    });
    print(body.toString());
    var res = await _shopApiService.addShopProduct(BaseApiService.authHeaders(token), model.pictures, body);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.toString());
      return json;
    }
  }

  Future<dynamic> shopDetail(String token, int idx)async{
    var res = await _shopApiService.shopDetail(BaseApiService.authHeaders(token), idx);
    if(res == null){
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return ShopDetailModel.fromJson(json);
    }
  }

  Future<dynamic> isLiked(String token, int idx) async {
    var res = await _shopApiService.isLiked(BaseApiService.authHeaders(token), idx);
    if(res == null){
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }
}