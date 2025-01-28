import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/kelahiran_model.dart';

class KelahiranApi extends SharedApi {
  final box = GetStorage();
  // Login API
  Future<KelahiranListModel> loadKelahiranAPI() async {
    try {
      final String? role = box.read('role');
      final String? username = box.read('username');
      String apiUrl = '$baseUrl/kelahiran';

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
        return KelahiranListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return KelahiranListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return KelahiranListModel.fromJson({"status": 404, "content": []});
    }
  }

//ADD
  Future<KelahiranModel?> addKelahiranAPI(
    String idKejadian,
    String tanggalLaporan,
    String tanggalLahir,
    String peternak_id,
    String hewan_id,
    String kandang_id,
    String petugas_id,
    String inseminasi_id,
    String eartagAnak,
    String jenisKelaminAnak,
    String spesies,
  ) async {
    try {
      var jsonData;
      showLoading();

      var bodyData = {
        'idKejadian': idKejadian,
        'tanggalLaporan': tanggalLaporan,
        'tanggalLahir': tanggalLahir,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'kandang_id': kandang_id,
        'petugas_id': petugas_id,
        'inseminasi_id': inseminasi_id,
        'eartagAnak': eartagAnak,
        'jenisKelaminAnak': jenisKelaminAnak,
        'spesies': spesies,
      };
      var data = await http.post(
        Uri.parse('$baseUrl/kelahiran'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return KelahiranModel.fromJson({
          "status": 201,
          "idKejadian": jsonData['idKejadian'],
          "tanggalLaporan": jsonData['tanggalLaporan'],
          "tanggalLahir": jsonData['tanggalLahir'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "kandang_id": jsonData['kandang_id'],
          "petugas_id": jsonData['petugas_id'],
          "inseminasi_id": jsonData['inseminasi_id'],
          "eartagAnak": jsonData['eartagAnak'],
          "jenisKelaminAnak": jsonData['jenisKelaminAnak'],
          "spesies": jsonData['spesies'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return null; // KelahiranModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return KelahiranModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<KelahiranModel?> editKelahiranApi(
    String idKejadian,
    String tanggalLaporan,
    String tanggalLahir,
    String peternak_id,
    String hewan_id,
    String kandang_id,
    String petugas_id,
    String inseminasi_id,
    String eartagAnak,
    String jenisKelaminAnak,
    String spesies,
  ) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idKejadian': idKejadian,
        'tanggalLaporan': tanggalLaporan,
        'tanggalLahir': tanggalLahir,
        'peternak_id': peternak_id,
        'hewan_id': hewan_id,
        'kandang_id': kandang_id,
        'petugas_id': petugas_id,
        'inseminasi_id': inseminasi_id,
        'eartagAnak': eartagAnak,
        'jenisKelaminAnak': jenisKelaminAnak,
        'spesies': spesies,
      };
      var data = await http.put(
        Uri.parse('$baseUrl/kelahiran/$idKejadian'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return KelahiranModel.fromJson({
          "status": 201,
          "idKejadian": jsonData['idKejadian'],
          "tanggalLaporan": jsonData['tanggalLaporan'],
          "tanggalLahir": jsonData['tanggalLahir'],
          "peternak_id": jsonData['peternak_id'],
          "hewan_id": jsonData['hewan_id'],
          "kandang_id": jsonData['kandang_id'],
          "petugas_id": jsonData['petugas_id'],
          "inseminasi_id": jsonData['inseminasi_id'],
          "eartagAnak": jsonData['eartagAnak'],
          "jenisKelaminAnak": jsonData['jenisKelaminAnak'],
          "spesies": jsonData['spesies'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return KelahiranModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return KelahiranModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<KelahiranModel?> deleteKelahiranAPI(String idKejadianDetail) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/kelahiran/$idKejadianDetail'),
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
        // Kirim variabel postData ke dalam fungsi KelahiranModel.fromJson
        return KelahiranModel.fromJson({"status": 200});
      } else {
        // showErrorMessage(jsonData['message']);
        return KelahiranModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return KelahiranModel.fromJson({"status": 404});
    }
  }
}
