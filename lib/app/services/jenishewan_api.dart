import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JenisHewanApi extends SharedApi {
  // Login API
  Future<JenisHewanListModel> loadJenisHewanApi() async {
    try {
      var data =
          await http.get(Uri.parse('$baseUrl/jenishewan'), headers: getToken());
      // print("hasil" + data.statusCode.toString());
      // print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        // print(jsonData['content']);

        return JenisHewanListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return JenisHewanListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return JenisHewanListModel.fromJson({"status": 404, "content": []});
    }
  }

//   Future<JenisHewanModel?> addJenisHewanApi(String nikJenishewan, String namaJenishewan, String noTelp, String email) async {
//  try {
//  var jsonData;
//  showLoading();
//  var data = await http.post(
//  Uri.parse(baseUrl + '/Jenishewan'),
//  headers: {
//   ...getToken(),
//           'Content-Type': 'application/json',
//         },
//  body: {'nikJenishewan': nikJenishewan, 'namaJenishewan': namaJenishewan, 'noTelp': noTelp, 'email': email},
//  );
//  stopLoading();
//  jsonData = json.decode(data.body);
//  if (data.statusCode == 200) {
//  jsonData['data']['status_code'] = 200;
//  return JenishewanModel.fromJson(jsonData['data']);
//  } else {
//  showErrorMessage(jsonData['message']);
//  return JenishewanModel.fromJson({"status": data.statusCode});
//  }
//  } on Exception catch (_) {
//  stopLoading();
//  showInternetMessage("Periksa koneksi internet anda");
//  return JenishewanModel.fromJson({"status": 404});
//  }
//  }

//ADD
  Future<JenisHewanModel?> addJenisHewanApi(
      String jenis, String deskripsi) async {
    try {
      var generateId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idJenisHewan': generateId,
        'jenis': jenis,
        'deskripsi': deskripsi,
      };
      var data = await http.post(
        Uri.parse("$baseUrl/jenishewan"),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return JenisHewanModel.fromJson({
          "status": 201,
          "jenis": jsonData['jenis'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return JenisHewanModel.fromJson({"status": data.statusCode});
      }
    } catch (e) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return JenisHewanModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<JenisHewanModel?> editJenisHewanApi(
      String idJenisHewan, String jenis, String deskripsi) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {'jenis': jenis, 'deskripsi': deskripsi};

      var data = await http.put(
        Uri.parse('$baseUrl/jenishewan/$idJenisHewan'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        // print(data.body);
        // print(jsonData);
        return JenisHewanModel.fromJson({
          "status": 201,
          "jenis": jsonData['jenis'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return JenisHewanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return JenisHewanModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<JenisHewanModel?> deleteJenisHewanApi(String idJenisHewan) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/jenishewan/$idJenisHewan'),
        headers: getToken(),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        // Simpan nilai jsonData['data'] dalam variabel baru
        var postData = <String, dynamic>{};
        postData["statusCode"] = 200;
        //postData["status"] = 200;
        //postData['id'] = 0;

        //postData['content'] = "";

        print(postData);
        // Kirim variabel postData ke dalam fungsi JenisHewanModel.fromJson
        return JenisHewanModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return JenisHewanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return JenisHewanModel.fromJson({"status": 404});
    }
  }
}
