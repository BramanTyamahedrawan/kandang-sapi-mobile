import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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
    String idVaksin,
    String peternak_id,
    String hewan_id,
    String petugas_id,
    String namaVaksin,
    String jenisVaksin,
    String tglVaksin,
  ) async {
    try {
      var jsonData;
      showLoading();

      var bodyData = {
        'idVaksin': idVaksin,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'petugas_id': petugas_id,
        'namaVaksin': namaVaksin,
        'jenisVaksin': jenisVaksin,
        'tglVaksin': tglVaksin,
      };
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
      print(data.body);
      print("apalah");
      if (data.statusCode == 201) {
        return VaksinModel.fromJson({
          "status": 201,
          "idVaksin": jsonData['idVaksin'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "petugas_id": jsonData['petugas_id'],
          "namaVaksin": jsonData['namaVaksin'],
          "jenisVaksin": jsonData['jenisVaksin'],
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
    String namaVaksin,
    String jenisVaksin,
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
        'namaVaksin': namaVaksin,
        'jenisVaksin': jenisVaksin,
        'tglVaksin': tglVaksin,
      };

      var data = await http.put(
        Uri.parse('$baseUrl/vaksin/$idVaksin'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      // print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return VaksinModel.fromJson({
          "status": 201,
          "idVaksin": jsonData['idVaksin'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "petugas_id": jsonData['petugas_id'],
          "namaVaksin": jsonData['namaVaksin'],
          "jenisVaksin": jsonData['jenisVaksin'],
          "tglVaksin": jsonData['tglVaksin'],
        });
      } else {
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
