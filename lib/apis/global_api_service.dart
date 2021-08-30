import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:http/http.dart' as http;

class GlobalApiService{
    static String getImage(String path)  {
    return '${BaseApiService.baseApi}/image?path=$path';
  }
}