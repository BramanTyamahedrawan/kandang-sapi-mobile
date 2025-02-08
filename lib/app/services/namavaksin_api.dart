import 'dart:convert';

import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class NamaVaksinApi extends SharedApi {
  final box = GetStorage();
  // Login API
  Future<NamaVaksinListModel> loadNamaVaksinAPI() async {
    try {
      var response =
          await http.get(Uri.parse('$baseUrl/namavaksin'), headers: getToken());

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NamaVaksinListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return NamaVaksinListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return NamaVaksinListModel.fromJson({"status": 404, "content": []});
    }
  }

//ADD
  Future<NamaVaksinModel?> addNamaVaksinAPI(
    String idJenisVaksin,
    String nama,
    String deskripsi,
  ) async {
    try {
      var generateId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idNamaVaksin': generateId,
        'idJenisVaksin': idJenisVaksin,
        'nama': nama,
        'deskripsi': deskripsi,
      };
      var data = await http.post(
        Uri.parse('$baseUrl/namavaksin'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      print(data.body);
      if (data.statusCode == 201) {
        return NamaVaksinModel.fromJson({
          "status": 201,
          "idNamaVaksin": jsonData['idNamaVaksin'],
          "idJenisVaksin": jsonData['idJenisVaksin'],
          "nama": jsonData['nama'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        print("error:");
        return null; // return VaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return NamaVaksinModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<NamaVaksinModel?> editNamaVaksinApi(
    String idNamaVaksin,
    String idJenisVaksin,
    String nama,
    String deskripsi,
  ) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idNamaVaksin': idNamaVaksin,
        'idJenisVaksin': idJenisVaksin,
        'nama': nama,
        'deskripsi': deskripsi,
      };

      var data = await http.put(
        Uri.parse('$baseUrl/namavaksin/$idNamaVaksin'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      // print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return NamaVaksinModel.fromJson({
          "status": 201,
          "idNamaVaksin": jsonData['idNamaVaksin'],
          "idJenisVaksin": jsonData['idJenisVaksin'],
          "nama": jsonData['nama'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        return NamaVaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return NamaVaksinModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<NamaVaksinModel?> deleteNamaVaksinApi(String idNamaVaksin) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/namavaksin/$idNamaVaksin'),
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
        // Kirim variabel postData ke dalam fungsi NamaVaksinModel.fromJson
        return NamaVaksinModel.fromJson({"status": 200});
      } else {
        return NamaVaksinModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return NamaVaksinModel.fromJson({"status": 404});
    }
  }
}
