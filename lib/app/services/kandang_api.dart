import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class KandangApi extends SharedApi {
  final box = GetStorage();

  Future<KandangListModel> loadKandangApi() async {
    try {
      final String? role = box.read('role');
      final String? username = box.read('username');
      String apiUrl = '$baseUrl/kandang';

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
        return KandangListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return KandangListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return KandangListModel.fromJson({"status": 404, "content": []});
    }
  }

  //ADD
  Future<KandangModel?> addKandangAPI(
    String idKandang,
    String idPeternak,
    String luas,
    String namaKandang,
    String jenisKandang,
    String kapasitas,
    String nilaiBangunan,
    String alamat,
    String desa,
    String kecamatan,
    String kabupaten,
    String provinsi,
    File? fotoKandang,
    String latitude,
    String longitude,
    String idJenisHewan,
  ) async {
    try {
      var jsonData;
      showLoading();
      var generatedId = Uuid().v4();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/kandang'),
      );

      request.fields.addAll({
        'idKandang': generatedId,
        'idPeternak': idPeternak,
        'luas': luas,
        'kapasitas': kapasitas,
        'namaKandang': namaKandang,
        'jenisKandang': jenisKandang,
        'nilaiBangunan': nilaiBangunan,
        'alamat': alamat,
        'desa': desa,
        'kecamatan': kecamatan,
        'kabupaten': kabupaten,
        'provinsi': provinsi,
        'fotoKandang': fotoKandang?.path ?? '',
        'idJenisHewan': idJenisHewan,
        "latitude": latitude,
        "longitude": longitude,
      });
      var imageField = http.MultipartFile(
        'file',
        fotoKandang?.readAsBytes().asStream() ?? Stream.empty(),
        fotoKandang?.lengthSync() ?? 0,
        filename: fotoKandang?.path.split("/").last ?? '',
      );
      request.files.add(imageField);
      request.headers.addAll(
        {
          ...getToken(),
          'Content-Type': 'multipart/form-data',
        },
      );

      print('Before sending request: $request');
      var response = await request.send();
      var responseData = await response.stream.transform(utf8.decoder).toList();
      var responseString = responseData.join('');
      jsonData = json.decode(responseString);
      stopLoading();
      if (response.statusCode == 201) {
        return KandangModel.fromJson({
          "status": 201,
          "idKandang": jsonData['idKandang'],
          "idPeternak": jsonData['idPeternak'],
          "namaKandang": jsonData['namaKandang'],
          "jenisKandang": jsonData['jenisKandang'],
          "luas": jsonData['luas'],
          "kapasitas": jsonData['kapasitas'],
          "nilaiBangunan": jsonData['nilaiBangunan'],
          "alamat": jsonData['alamat'],
          "desa": jsonData['desa'],
          "kecamatan": jsonData['kecamatan'],
          "kabupaten": jsonData['kabupaten'],
          "provinsi": jsonData['provinsi'],
          "idJenisHewan": jsonData['idJenisHewan'],
          "latitude": jsonData['latitude'],
          "longitude": jsonData['longitude'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return KandangModel.fromJson({"status": response.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return KandangModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<KandangModel?> editKandangApi(
    String idKandang,
    String idPeternak,
    String namaKandang,
    String jenisKandang,
    String luas,
    String kapasitas,
    String nilaiBangunan,
    String alamat,
    String desa,
    String kecamatan,
    String kabupaten,
    String provinsi,
    String idJenisHewan,
    File? newfotoKandang,
    //String originalFotoKandang,

    String latitude,
    String longitude,
  ) async {
    try {
      var jsonData;
      showLoading();

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/kandang/$idKandang'),
      );

      request.fields.addAll({
        'idKandang': idKandang,
        'idPeternak': idPeternak,
        'namaKandang': namaKandang,
        'jenisKandang': jenisKandang,
        'luas': luas,
        'kapasitas': kapasitas,
        'nilaiBangunan': nilaiBangunan,
        'alamat': alamat,
        'desa': desa,
        'kecamatan': kecamatan,
        'kabupaten': kabupaten,
        'provinsi': provinsi,
        'idJenisHewan': idJenisHewan,
        'latitude': latitude,
        'longitude': longitude,
      });

      if (newfotoKandang != null) {
        var imageField = http.MultipartFile(
          'file',
          newfotoKandang.readAsBytes().asStream(),
          newfotoKandang.lengthSync(),
          filename: newfotoKandang.path.split("/").last,
        );
        request.files.add(imageField);
      }
      // Setelah konfigurasi MultipartRequest
      print('Before sending request:');
      print('Method: ${request.method}');
      print('URL: ${request.url}');
      print('Headers: ${request.fields}');
      print('Fields:');

      request.headers.addAll(
        {
          ...getToken(),
          'Content-Type': 'multipart/form-data',
        },
      );

      var response = await request.send();
      var responseData = await response.stream.transform(utf8.decoder).toList();
      var responseString = responseData.join('');
      jsonData = json.decode(responseString);
      stopLoading();

      if (response.statusCode == 201) {
        return KandangModel.fromJson({
          "status": 201,
          "idKandang": jsonData['idKandang'],
          "idPeternak": jsonData['idPeternak'],
          "namaKandang": jsonData['namaKandang'],
          "jenisKandang": jsonData['jenisKandang'],
          "luas": jsonData['luas'],
          "kapasitas": jsonData['kapasitas'],
          "nilaiBangunan": jsonData['nilaiBangunan'],
          "alamat": jsonData['alamat'],
          "desa": jsonData['desa'],
          "kecamatan": jsonData['kecamatan'],
          "kabupaten": jsonData['kabupaten'],
          "provinsi": jsonData['provinsi'],
          "idJenisHewan": jsonData['idJenisHewan'],
          "fotoKandang": jsonData['fotoKandang'],
          "latitude": jsonData['latitude'],
          "longitude": jsonData['longitude'],
        });
      } else {
        showErrorMessage(jsonData?['message']);
        return KandangModel.fromJson({"status": response.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return KandangModel.fromJson({"status": 404});
    }
  }

  Future<KandangModel?> deleteKandangAPI(String idKandang) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/kandang/$idKandang'),
        headers: getToken(),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 200) {
        // Simpan nilai jsonData['data'] dalam variabel baru
        var postData = <String, dynamic>{};
        postData["statusCode"] = 200;
        //postData["status"] = 1;
        //postData['id'] = 0;

        //postData['content'] = "";

        print(postData);
        // Kirim variabel postData ke dalam fungsi InseminasiModel.fromJson
        return KandangModel.fromJson({
          "status": 200,
        });
      } else {
        showErrorMessage(jsonData['message']);
        return KandangModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return KandangModel.fromJson({"status": 404});
    }
  }
}
