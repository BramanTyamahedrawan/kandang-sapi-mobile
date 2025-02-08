import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'dart:convert';

import '../data/vaksin_model.dart';

class VaksinApi extends SharedApi {
  final box = GetStorage();
  // Login API
  Future<VaksinListModel> loadVaksinAPI() async {
    try {
      final String? role = box.read('role');
      final String? username = box.read('username');
      String apiUrl = '$baseUrl/vaksin';

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
        return VaksinListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return VaksinListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return VaksinListModel.fromJson({"status": 404, "content": []});
    }
  }

//ADD
  Future<VaksinModel?> addVaksinAPI(
    String peternak_id,
    String hewan_id,
    String petugas_id,
    String idNamaVaksin,
    String idJenisVaksin,
    String batchVaksin,
    String vaksinKe,
    String tglVaksin,
  ) async {
    try {
      var generateId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idVaksin': generateId,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'petugas_id': petugas_id,
        'idNamaVaksin': idNamaVaksin,
        'idJenisVaksin': idJenisVaksin,
        'batchVaksin': batchVaksin,
        'vaksinKe': vaksinKe,
        'tglVaksin': tglVaksin,
      };

      print("=== DEBUG: Body Data ===");
      print(jsonEncode(bodyData)); // Debugging print
      print("========================");

      var data = await http.post(
        Uri.parse('$baseUrl/vaksin'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return VaksinModel.fromJson({
          "status": 201,
          "idVaksin": jsonData['idVaksin'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "petugas_id": jsonData['petugas_id'],
          "idNamaVaksin": jsonData['idNamaVaksin'],
          "idJenisVaksin": jsonData['idJenisVaksin'],
          "batchVaksin": jsonData['batchVaksin'],
          "vaksinKe": jsonData['vaksinKe'],
          "tglVaksin": jsonData['tglVaksin'],
        });
      } else {
        return null; // return VaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return VaksinModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<VaksinModel?> editVaksinApi(
    String idVaksin,
    String peternak_id,
    String hewan_id,
    String petugas_id,
    String idNamaVaksin,
    String idJenisVaksin,
    String batchVaksin,
    String vaksinKe,
    String tglVaksin,
  ) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idVaksin': idVaksin,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'petugas_id': petugas_id,
        'idNamaVaksin': idNamaVaksin,
        'idJenisVaksin': idJenisVaksin,
        'batchVaksin': batchVaksin,
        'vaksinKe': vaksinKe,
        'tglVaksin': tglVaksin,
      };

      var data = await http.put(
        Uri.parse('$baseUrl/vaksin/$idVaksin'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print("=== DEBUG: Body Data ===");
      print(jsonEncode(bodyDataedit)); // Debugging print
      print("========================");
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return VaksinModel.fromJson({
          "status": 201,
          "idVaksin": jsonData['idVaksin'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "petugas_id": jsonData['petugas_id'],
          "idNamaVaksin": jsonData['idNamaVaksin'],
          "idJenisVaksin": jsonData['idJenisVaksin'],
          "batchVaksin": jsonData['batchVaksin'],
          "vaksinKe": jsonData['vaksinKe'],
          "tglVaksin": jsonData['tglVaksin'],
        });
      } else {
        print("Error Status : ${data.statusCode}");
        return VaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return VaksinModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<VaksinModel?> deleteVaksinApi(String idVaksin) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/vaksin/$idVaksin'),
        headers: getToken(),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        // Simpan nilai jsonData['data'] dalam variabel baru
        var postData = <String, dynamic>{};
        postData["statusCode"] = 200;
        //postData['content'] = "";

        print(postData);
        // Kirim variabel postData ke dalam fungsi VaksinModel.fromJson
        return VaksinModel.fromJson({"status": 200});
      } else {
        return VaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return VaksinModel.fromJson({"status": 404});
    }
  }
}
