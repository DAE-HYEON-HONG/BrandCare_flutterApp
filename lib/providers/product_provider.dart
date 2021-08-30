import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/product/product_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/addGenuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/addProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/genuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/productDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'dart:io';

class ProductProvider {
  final ProductApiService _productApiService = ProductApiService();

  Future<dynamic> productApply(AddProductModel model, List<File> images, File frontImg, File backImg, File leftImg, File rightImg) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    var body = model.toJson();
    var bodyJson = jsonEncode(body);
    print(bodyJson.toString());
    final res = await _productApiService.addProduct(
      BaseApiService.authHeaders(token!),
      bodyJson,
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
  Future<Map<String, dynamic>?> getProductDetail(int id) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.getProductDetail(token!, id);
    if(res != null) {
      return jsonDecode(res.body);
    }
    return null;
  }

  Future<dynamic> brandNameList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.brandCategory(BaseApiService.authHeaders(token!));
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      return json;
    }
  }

  Future<dynamic> categoryNameList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.categoryNameList(BaseApiService.authHeaders(token!));
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> productDetail(int idx) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.productDetail(BaseApiService.authHeaders(token!), idx);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return ProductDetailModel.fromJson(json);
    }
  }

  Future<dynamic> productRemove(int idx) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.productRemove(BaseApiService.authHeaders(token!), idx);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return ProductDetailModel.fromJson(json);
    }
  }

  Future<dynamic>? addGenuine({
    required dynamic address,
    required List<GenuinePriceListModel> list,
    required int paymentAmount,
    required String phone,
    required String receiverPhone,
    required String receiverName,
    required String request_term,
    required dynamic returnAddress,
    required String senderName,
    required String returnType,
    int? couponId,
    required int usePointAmount,
    required int price,
    required int productId,
  })async{
    List careIdx = [];
    for(var i in list){
      careIdx.add(i.id);
    }
    var addInfo = jsonEncode({
      "address" : address,
      'categoryList' : careIdx,
      'paymentAmount' : paymentAmount,
      'phone' : phone,
      'productId' : productId,
      'receiver' : receiverName,
      'receiverPhone' : receiverPhone,
      'request_term' : request_term,
      'receiveAddress' : returnAddress,
      'sender' : senderName,
      'useCouponId' : couponId,
      'usePoint' : usePointAmount,
      'returnType' : returnType,
      'receiverPhone' : receiverPhone,
      'price' : price,
    });
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    var res = await _productApiService.productGenuineAdd(BaseApiService.authHeaders(token!), addInfo);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.toString());
      return json;
    }
  }

  Future<dynamic> genuineStatus(int idx) async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await _productApiService.productRemove(BaseApiService.authHeaders(token!), idx);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return ProductDetailModel.fromJson(json);
    }
  }
}