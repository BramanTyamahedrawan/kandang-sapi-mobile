import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/data/TujuanPemeliharaan_model.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TujuanPemeliharaanApi extends SharedApi {
  // Login API
  Future<TujuanPemeliharaanListModel> loadTujuanPemeliharaanApi() async {
    try {
      var data = await http.get(Uri.parse('$baseUrl/tujuanpemeliharaan'),
          headers: getToken());
      // print("hasil" + data.statusCode.toString());
      // print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        // print(jsonData['content']);

        return TujuanPemeliharaanListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return TujuanPemeliharaanListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return TujuanPemeliharaanListModel.fromJson(
          {"status": 404, "content": []});
    }
  }

//   Future<TujuanPemeliharaanModel?> addTujuanPemeliharaanApi(String nikTujuanPemeliharaan, String namaTujuanPemeliharaan, String noTelp, String email) async {
//  try {
//  var jsonData;
//  showLoading();
//  var data = await http.post(
//  Uri.parse(baseUrl + '/TujuanPemeliharaan'),
//  headers: {
//   ...getToken(),
//           'Content-Type': 'application/json',
//         },
//  body: {'nikTujuanPemeliharaan': nikTujuanPemeliharaan, 'namaTujuanPemeliharaan': namaTujuanPemeliharaan, 'noTelp': noTelp, 'email': email},
//  );
//  stopLoading();
//  jsonData = json.decode(data.body);
//  if (data.statusCode == 200) {
//  jsonData['data']['status_code'] = 200;
//  return TujuanPemeliharaanModel.fromJson(jsonData['data']);
//  } else {
//  showErrorMessage(jsonData['message']);
//  return TujuanPemeliharaanModel.fromJson({"status": data.statusCode});
//  }
//  } on Exception catch (_) {
//  stopLoading();
//  showInternetMessage("Periksa koneksi internet anda");
//  return TujuanPemeliharaanModel.fromJson({"status": 404});
//  }
//  }

//ADD
  Future<TujuanPemeliharaanModel?> addTujuanPemeliharaanApi(
      String tujuanPemeliharaan, String deskripsi) async {
    try {
      var generateId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idTujuanPemeliharaan': generateId,
        'tujuanPemeliharaan': tujuanPemeliharaan,
        'deskripsi': deskripsi,
      };
      var data = await http.post(
        Uri.parse("$baseUrl/tujuanpemeliharaan"),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return TujuanPemeliharaanModel.fromJson({
          "status": 201,
          "tujuanPemeliharaan": jsonData['tujuanPemeliharaan'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return TujuanPemeliharaanModel.fromJson({"status": data.statusCode});
      }
    } catch (e) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return TujuanPemeliharaanModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<TujuanPemeliharaanModel?> editTujuanPemeliharaanApi(
      String idTujuanPemeliharaan,
      String tujuanPemeliharaan,
      String deskripsi) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'tujuanPemeliharaan': tujuanPemeliharaan,
        'deskripsi': deskripsi
      };

      var data = await http.put(
        Uri.parse('$baseUrl/tujuanpemeliharaan/$idTujuanPemeliharaan'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        // print(data.body);
        // print(jsonData);
        return TujuanPemeliharaanModel.fromJson({
          "status": 201,
          "tujuanPemeliharaan": jsonData['tujuanPemeliharaan'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return TujuanPemeliharaanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return TujuanPemeliharaanModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<TujuanPemeliharaanModel?> deleteTujuanPemeliharaanApi(
      String idTujuanPemeliharaan) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/tujuanpemeliharaan/$idTujuanPemeliharaan'),
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
        // Kirim variabel postData ke dalam fungsi TujuanPemeliharaanModel.fromJson
        return TujuanPemeliharaanModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return TujuanPemeliharaanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return TujuanPemeliharaanModel.fromJson({"status": 404});
    }
  }
}
