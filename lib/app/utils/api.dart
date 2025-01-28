import 'package:get_storage/get_storage.dart';

class SharedApi {
  // String imageUrl = "http://192.168.5.248:8080/downloadFile/";
  // String baseUrl = "http://192.168.5.248:8080/api";

  String imageUrl = "http://192.168.2.100:8081/api/";
  String baseUrl = "http://192.168.2.100:8081/api";

  // String imageUrl = "http://114.9.13.243:8080/downloadFile/";
  // String baseUrl = "http://114.9.13.243:8080/api";

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
