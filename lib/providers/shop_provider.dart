import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/shop/shop_api_service.dart';

class ShopProvider{
  final ShopApiService _shopApiService = ShopApiService();
  Future<dynamic> shopList(String token, int page, String searchWord, String type) async {
    var res = await _shopApiService.shopList(BaseApiService.authHeaders(token), page, searchWord, type);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
    }
  }
}