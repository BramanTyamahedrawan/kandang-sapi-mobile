import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/pkb_model.dart';

class PKBApi extends SharedApi {
  final box = GetStorage();
  // Login API
  Future<PKBListModel> loadPKBAPI() async {
    try {
      final String? role = box.read('role');
      final String? username = box.read('username');
      String apiUrl = '$baseUrl/pkb';

      // Modify URL if the role is ROLE_PETERNAK
      if (role == 'ROLE_PETERNAK') {
        apiUrl += '/?peternakID=$username';
      }

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: getToken(),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return PKBListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return PKBListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return PKBListModel.fromJson({"status": 404, "content": []});
    }
  }

//ADD
  Future<PKBModel?> addPKBAPI(
      String idKejadian,
      String peternak_id,
      String hewan_id,
      String petugas_id,
      String spesies,
      String umurKebuntingan,
      String tanggalPkb) async {
    try {
      var jsonData;
      showLoading();

      var bodyData = {
        'idKejadian': idKejadian,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'petugas_id': petugas_id,
        'spesies': spesies,
        'umurKebuntingan': umurKebuntingan,
        'tanggalPkb': tanggalPkb,
      };
      var data = await http.post(
        Uri.parse('$baseUrl/pkb'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return PKBModel.fromJson({
          "status": 201,
          "idKejadian": jsonData['idKejadian'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "petugas_id": jsonData['petugas_id'],
          "spesies": jsonData['spesies'],
          "umurKebuntingan": jsonData['umurKebuntingan'],
          "tanggalPkb": jsonData['tanggalPkb'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return null; // return PKBModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PKBModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<PKBModel?> editPKBApi(
      String idKejadian,
      String peternak_id,
      String hewan_id,
      String petugas_id,
      String spesies,
      String umurKebuntingan,
      String tanggalPkb) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idKejadian': idKejadian,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'petugas_id': petugas_id,
        'spesies': spesies,
        'umurKebuntingan': umurKebuntingan,
        'tanggalPkb': tanggalPkb
      };

      var data = await http.put(
        Uri.parse('$baseUrl/pkb/$idKejadian'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      // print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return PKBModel.fromJson({
          "status": 201,
          "idKejadian": jsonData['idKejadian'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "petugas_id": jsonData['petugas_id'],
          "spesies": jsonData['spesies'],
          "umurKebuntingan": jsonData['umurKebuntingan'],
          "tanggalPkb": jsonData['tanggalPkb'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return PKBModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PKBModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<PKBModel?> deletePKBAPI(String idKejadian) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/pkb/$idKejadian'),
        headers: getToken(),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        // Simpan nilai jsonData['data'] dalam variabel baru
        var postData = <String, dynamic>{};
        postData["statusCode"] = 200;
        // postData['content'] = "";

        print(postData);
        // Kirim variabel postData ke dalam fungsi PKBModel.fromJson
        return PKBModel.fromJson({"status": 200});
      } else {
        // showErrorMessage(jsonData['message']);
        return PKBModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PKBModel.fromJson({"status": 404});
    }
  }
}
