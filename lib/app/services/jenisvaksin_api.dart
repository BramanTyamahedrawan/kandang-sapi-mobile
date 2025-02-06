import 'dart:convert';

import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class JenisVaksinApi extends SharedApi {
  // Login API
  Future<JenisVaksinListModel> loadJenisVaksinApi() async {
    try {
      var data =
          await http.get(Uri.parse('$baseUrl/jenisvaksin'), headers: getToken());
      // print("hasil" + data.statusCode.toString());
      // print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        // print(jsonData['content']);

        return JenisVaksinListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return JenisVaksinListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return JenisVaksinListModel.fromJson({"status": 404, "content": []});
    }
  }

//   Future<JenisVaksinModel?> addJenisVaksinApi(String nikJenisVaksin, String namaJenisVaksin, String noTelp, String email) async {
//  try {
//  var jsonData;
//  showLoading();
//  var data = await http.post(
//  Uri.parse(baseUrl + '/JenisVaksin'),
//  headers: {
//   ...getToken(),
//           'Content-Type': 'application/json',
//         },
//  body: {'nikJenisVaksin': nikJenisVaksin, 'namaJenisVaksin': namaJenisVaksin, 'noTelp': noTelp, 'email': email},
//  );
//  stopLoading();
//  jsonData = json.decode(data.body);
//  if (data.statusCode == 200) {
//  jsonData['data']['status_code'] = 200;
//  return JenisVaksinModel.fromJson(jsonData['data']);
//  } else {
//  showErrorMessage(jsonData['message']);
//  return JenisVaksinModel.fromJson({"status": data.statusCode});
//  }
//  } on Exception catch (_) {
//  stopLoading();
//  showInternetMessage("Periksa koneksi internet anda");
//  return JenisVaksinModel.fromJson({"status": 404});
//  }
//  }

//ADD
  Future<JenisVaksinModel?> addJenisVaksinApi(
      String jenis, String deskripsi) async {
    try {
      var generateId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idJenisVaksin': generateId,
        'jenis': jenis,
        'deskripsi': deskripsi,
      };
      var data = await http.post(
        Uri.parse("$baseUrl/jenisvaksin"),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return JenisVaksinModel.fromJson({
          "status": 201,
          "jenis": jsonData['jenis'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return JenisVaksinModel.fromJson({"status": data.statusCode});
      }
    } catch (e) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return JenisVaksinModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<JenisVaksinModel?> editJenisVaksinApi(
      String idJenisVaksin, String jenis, String deskripsi) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {'jenis': jenis, 'deskripsi': deskripsi};

      var data = await http.put(
        Uri.parse('$baseUrl/jenisvaksin/$idJenisVaksin'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        // print(data.body);
        // print(jsonData);
        return JenisVaksinModel.fromJson({
          "status": 201,
          "jenis": jsonData['jenis'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return JenisVaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return JenisVaksinModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<JenisVaksinModel?> deleteJenisVaksinApi(String idJenisVaksin) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/jenisvaksin/$idJenisVaksin'),
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
        // Kirim variabel postData ke dalam fungsi JenisVaksinModel.fromJson
        return JenisVaksinModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return JenisVaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return JenisVaksinModel.fromJson({"status": 404});
    }
  }
}
