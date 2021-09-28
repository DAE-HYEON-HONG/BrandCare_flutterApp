import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';

class GlobalApiService{
    static String getImage(String path)  {
    return '${BaseApiService.baseApi}/image?path=$path';
  }
}