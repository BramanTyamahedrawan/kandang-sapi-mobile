import 'dart:convert';

import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:http/http.dart' as http;

class PeternakApi extends SharedApi {
  // Login API
  Future<PeternakListModel> loadPeternakApi() async {
    try {
      var data =
          await http.get(Uri.parse('$baseUrl/peternak'), headers: getToken());
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        print(jsonData['content']);

        return PeternakListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return PeternakListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return PeternakListModel.fromJson({"status": 404, "content": []});
    }
  }

//ADD
  Future<PeternakModel?> addPeternakAPI(
      String idPeternak,
      String idISIKHNAS,
      String namaPeternak,
      String nikPeternak,
      String noTelp,
      String emailPeternak,
      String gender,
      String tanggalLahir,
      String dusun,
      String latitude,
      String longitude,
      String petugas_id,
      String tanggalPendaftaran) async {
    try {
      var jsonData;
      showLoading();

      var bodyData = {
        'idPeternak': idPeternak,
        'idISIKHNAS': idISIKHNAS,
        'namaPeternak': namaPeternak,
        'nikPeternak': nikPeternak,
        'noTelp': noTelp,
        'emailPeternak': emailPeternak,
        'gender': gender,
        'tanggalLahir': tanggalLahir,
        'dusun': dusun,
        'lokasi': '$latitude,$longitude',
        'petugas_id': petugas_id,
        'tanggalPendaftaran': tanggalPendaftaran
      };

      //print('Body Data: ${jsonEncode(bodyData)}');

      var data = await http.post(
        Uri.parse('$baseUrl/peternak'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      stopLoading();
      jsonData = json.decode(data.body);

      if (data.statusCode == 201) {
        print('Response Data: $jsonData');
        return PeternakModel.fromJson({
          "status": 201,
          "idPeternak": jsonData['idPeternak'],
          "idISIKHNAS": jsonData['idISIKHNAS'],
          "namaPeternak": jsonData['namaPeternak'],
          "nikPeternak": jsonData['nikPeternak'],
          "noTelp": jsonData['noTelp'],
          "emailPeternak": jsonData['emailPeternak'],
          "gender": jsonData['gender'],
          "tanggalLahir": jsonData['tanggalLahir'],
          "dusun": jsonData['dusun'],
          "lokasi": jsonData['lokasi'],
          "petugas_id": jsonData['petugas_id'],
          "tanggalPendaftaran": jsonData['tanggalPendaftaran'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return null;
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PeternakModel.fromJson({"status": 404});
    }
  }

  Future<List<Map<String, dynamic>>> getProvinsi() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/provinsi'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      }
    } catch (e) {
      print("Error fetching provinsi: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getKabupaten(String idProvinsi) async {
    try {
      var response =
          await http.get(Uri.parse('$baseUrl/kabupaten/$idProvinsi'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      }
    } catch (e) {
      print("Error fetching kabupaten: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getKecamatan(String idKabupaten) async {
    try {
      var response =
          await http.get(Uri.parse('$baseUrl/kecamatan/$idKabupaten'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      }
    } catch (e) {
      print("Error fetching kecamatan: $e");
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getDesa(String idKecamatan) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/desa/$idKecamatan'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      }
    } catch (e) {
      print("Error fetching desa: $e");
    }
    return [];
  }

//EDIT
  Future<PeternakModel?> editPeternakApi(
      String idPeternak,
      String idISIKHNAS,
      String namaPeternak,
      String nikPeternak,
      String noTelp,
      String emailPeternak,
      String gender,
      String tanggalLahir,
      String dusun,
      String latitude,
      String longitude,
      String petugas_id,
      String tanggalPendaftaran) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idPeternak': idPeternak,
        'idISIKHNAS': idISIKHNAS,
        'namaPeternak': namaPeternak,
        'nikPeternak': nikPeternak,
        'noTelp': noTelp,
        'emailPeternak': emailPeternak,
        'gender': gender,
        'tanggalLahir': tanggalLahir,
        'dusun': dusun,
        'lokasi': '$latitude,$longitude',
        'petugas_id': petugas_id,
        'tanggalPendaftaran': tanggalPendaftaran
      };

      var data = await http.put(
        Uri.parse('$baseUrl/peternak/$idPeternak'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      // print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return PeternakModel.fromJson({
          "status": 201,
          "idPeternak": jsonData['idPeternak'],
          "idISIKHNAS": jsonData['idISIKHNAS'],
          "namaPeternak": jsonData['namaPeternak'],
          "nikPeternak": jsonData['nikPeternak'],
          "noTelp": jsonData['noTelp'],
          "emailPeternak": jsonData['emailPeternak'],
          "gender": jsonData['gender'],
          "tanggalLahir": jsonData['tanggalLahir'],
          "dusun": jsonData['dusun'],
          "lokasi": jsonData['lokasi'],
          "petugas_id": jsonData['petugas_id'],
          "tanggalPendaftaran": jsonData['tanggalPendaftaran'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return PeternakModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PeternakModel.fromJson({"status": 404});
    }
  }

  Future<PeternakModel?> deletePeternakAPI(String idPeternak) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/peternak/$idPeternak'),
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
        return PeternakModel.fromJson({
          "status": 200,
        });
      } else {
        showErrorMessage(jsonData['message']);
        return PeternakModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PeternakModel.fromJson({"status": 404});
    }
  }
}
