import 'dart:convert';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../base_api_service.dart';

class CareApiService{
  Future<dynamic> addCare(dynamic headers, dynamic body, List<AddCareListModel> list)async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/care");
      var req = http.MultipartRequest('POST', uri);
      req.files.add(
        http.MultipartFile.fromBytes(
          'json',
          utf8.encode(body),
          contentType: MediaType(
            'application',
            'json',
            {'charset': 'utf-8'},
          ),
        ),
      );
      for(var file in list) {
        List<int> imageData = file.picture.readAsBytesSync();
        req.files.add(
          http.MultipartFile.fromBytes(
            'images',
            imageData,
            filename: file.picture.path.split("/").last,
          ),
        );
      }
      req.headers.addAll(headers);
      http.StreamedResponse res = await req.send();
      final resReturn = await res.stream.bytesToString();
      print(resReturn.toString());
      print(res.reasonPhrase.toString());
      print(res.statusCode);
      if(res.statusCode == 200){
        return resReturn;
      }else{
       return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> careStatus(dynamic headers, int id) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/care/$id");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> careResult(dynamic headers, int id) async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/care/result/$id");
      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }

  Future<http.Response?> careCategory() async{
    try{
      final uri = Uri.parse("${BaseApiService.baseApi}/care/category");
      final http.Response res = await http.get(
        uri,
      );
      if(res.statusCode == 200){
        return res;
      }else{
        return null;
      }
    }catch(e){
      print("접속 에러 : ${e.toString()}");
      return null;
    }
  }
}