import 'package:get_storage/get_storage.dart';

class SharedApi {
  String imageUrl = "http://192.168.3.87:8081/api/";
  String baseUrl = "http://192.168.3.87:8081/api";

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
