import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud_flutter_api/app/data/berita_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';

class BeritaApi extends SharedApi {
  // Login API
  Future<BeritaListModel> loadBeritaApi() async {
    try {
      var data =
          await http.get(Uri.parse('$baseUrl/berita'), headers: getToken());
      print("hasil" + data.statusCode.toString());
      print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        //print(jsonData['content']);

        return BeritaListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return BeritaListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return BeritaListModel.fromJson({"status": 404, "content": []});
    }
  }
}
