import 'package:get_storage/get_storage.dart';

class SharedApi {
  // String imageUrl = "http://192.168.0.108:8081/api/";
  // String baseUrl = "http://192.168.0.108:8081/api";

  // String imageUrl = "http://192.168.18.123:8081/downloadFile/";
  // String baseUrl = "http://192.168.18.123:8081/api";

  String imageUrl = "http://114.9.13.243:8081/downloadFile/";
  String baseUrl = "http://114.9.13.243:8081/api";

//https://192.168.0.230:8443/api
  Map<String, String> getToken() {
    final box = GetStorage();
    String? token = box.read("token");
    if (token != null) {
      return {
        "Authorization": "Bearer $token",
      };
    }

    return {
      "Authorization": "Bearer " "BadToken",
    };
  }
}
