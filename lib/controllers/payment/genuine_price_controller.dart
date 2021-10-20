import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:get/get.dart';

class GenuinePriceController extends GetxController {

  RxInt genuinePrice = 29000.obs;



  // void setGenuinePrice() async {
  //   var body = model.toJson();
  //   var bodyJson = jsonEncode(body);
  //   print(bodyJson.toString());
  //   final res = await getGenuinePrice();
  //   if(res == null) {
  //     return null;
  //   }else {
  //     Map<String, dynamic> json = jsonDecode(res.toString());
  //     return json;
  //   }
  // }

  Future<void> getGenuinePrice() async {
    try{
      var request = http.Request('GET', Uri.parse('${BaseApiService.baseApi}/activation/price'));
      http.StreamedResponse response = await request.send();
      if(response.statusCode == 200) {
        var responseStream = await response.stream.bytesToString();
        final parsed = json.decode(responseStream);
        PriceData priceData = PriceData.fromJson(parsed);
        genuinePrice.value = priceData.data ?? 29000;
      }
      else{print(response.statusCode);}
    }catch(e){

    }
  }
}

class PriceData {
  int? data;

  PriceData({this.data});

  PriceData.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    return data;
  }
}