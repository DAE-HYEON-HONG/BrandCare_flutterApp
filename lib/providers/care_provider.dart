import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/care/care_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careStatus_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';

class CareProvider{
  final CareApiService _careApiService = CareApiService();

  Future<dynamic>? addCare({
    required dynamic address,
    required List<AddCareListModel> list,
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
  })async{
    List<int> careIdx = [];
    for(var i in list){
      print(i.secondCategoryId);
      careIdx.add(i.secondCategoryId);
    }
    var careInfo = jsonEncode({
      "address" : address,
      'categoryId' : careIdx,
      'paymentAmount' : paymentAmount,
      'phone' : phone,
      'receiver' : receiverName,
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
    var res = await _careApiService.addCare(BaseApiService.authHeaders(token!), careInfo, list);
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.toString());
      return json;
    }
  }

  Future<dynamic> careStatus(String? token, int id)async{
    var res = await _careApiService.careStatus(BaseApiService.authHeaders(token!), id);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> careResult(String? token, int id)async{
    var res = await _careApiService.careResult(BaseApiService.authHeaders(token!), id);
    if(res == null){
      return null;
    }else{
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }

  Future<dynamic> careCategory() async {
    final res = await _careApiService.careCategory();
    if(res == null) {
      return null;
    }else {
      Map<String, dynamic> json = jsonDecode(res.body.toString());
      print(json.toString());
      return json;
    }
  }
}