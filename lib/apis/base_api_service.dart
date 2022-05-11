

class BaseApiService {

  static String baseApi = "http://api.test.org.kr/api/brc";
  static String imageApi = "http://api.test.org.kr/api/brc/image?path=";
  static Map<String, String> headers = {
    'Content-Type' : 'application/json',
  };

  static Map<String, String> authHeaders(String token){
    Map<String, String> headers = {
      'Content-Type' : 'application/json',
      'Authorization' : token,
    };
    return headers;
  }
}