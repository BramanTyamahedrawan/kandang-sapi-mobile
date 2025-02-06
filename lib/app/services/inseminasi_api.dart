import 'dart:convert';

import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;



class InseminasiApi extends SharedApi {
  final box = GetStorage();

  Future<InseminasiListModel> loadInseminasiAPI() async {
    try {
      final String? role = box.read('role');
      final String? username = box.read('username');
      String apiUrl = '$baseUrl/inseminasi';

      if (role == 'ROLE_PETERNAK') {
        apiUrl += '/?peternakID=$username';
      }

      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: getToken(),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return InseminasiListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return InseminasiListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return InseminasiListModel.fromJson({"status": 404, "content": []});
    }
  }
  // // Login API
  // Future<InseminasiListModel> loadInseminasiAPI() async {
  //   try {
  //     var data =
  //         await http.get(Uri.parse('$baseUrl/inseminasi'), headers: getToken());
  //     // print("hasil" + data.statusCode.toString());
  //     // print(json.decode(data.body));
  //     if (data.statusCode == 200) {
  //       var jsonData = json.decode(data.body);

  //       // print(jsonData['content']);

  //       return InseminasiListModel.fromJson({
  //         "status": 200,
  //         "content": jsonData['content'],
  //         "page": jsonData['page'],
  //         "size": jsonData['size'],
  //         "totalElements": jsonData['totalElements'],
  //         "totalPages": jsonData['totalPages']
  //       });
  //     } else {
  //       return InseminasiListModel.fromJson(
  //           {"status": data.statusCode, "content": []});
  //     }
  //   } on Exception catch (_) {
  //     return InseminasiListModel.fromJson({"status": 404, "content": []});
  //   }
  // }

//ADD
  Future<InseminasiModel?> addInseminasiAPI(
    String idInseminasi,
    String hewan_id,
    String idPembuatan,
    String idPejantan,
    String bangsaPejantan,
    String ib,
    String produsen,
    String peternak_id,
    String petugas_id,
    String tanggalIB,
  ) async {
    try {
      var jsonData;
      showLoading();

      var bodyData = {
        'idInseminasi': idInseminasi,
        'hewan_id': hewan_id,
        'idPejantan': idPejantan,
        'idPembuatan': idPembuatan,
        'bangsaPejantan': bangsaPejantan,
        'ib': ib,
        'produsen': produsen,
        'peternak_id': peternak_id,
        'petugas_id': petugas_id,
        'tanggalIB': tanggalIB,
      };
      var data = await http.post(
        Uri.parse('$baseUrl/inseminasi'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return InseminasiModel.fromJson({
          "status": 201,
          "idInseminasi": jsonData['idInseminasi'],
          "hewan_id": jsonData['hewan_id'],
          "idPejantan": jsonData['idPejantan'],
          "idPembuatan": jsonData['idPembuatan'],
          "bangsaPejantan": jsonData['bangsaPejantan'],
          "ib": jsonData['ib'],
          "produsen": jsonData['produsen'],
          "peternak_id": jsonData['peternak_id'],
          "petugas_id": jsonData['petugas_id'],
          "tanggalIB": jsonData['tanggalIB'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return null; //InseminasiModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return InseminasiModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<InseminasiModel?> editInseminasiApi(
    String idInseminasi,
    String hewan_id,
    String idPejantan,
    String idPembuatan,
    String bangsaPejantan,
    String ib,
    String produsen,
    String peternak_id,
    String petugas_id,
    String tanggalIB,
  ) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idInseminasi': idInseminasi,
        'hewan_id': hewan_id,
        'idPejantan': idPejantan,
        'idPembuatan': idPembuatan,
        'bangsaPejantan': bangsaPejantan,
        'ib': ib,
        'produsen': produsen,
        'peternak_id': peternak_id,
        'petugas_id': petugas_id,
        'tanggalIB': tanggalIB,
      };

      var data = await http.put(
        Uri.parse('$baseUrl/inseminasi/$idInseminasi'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        // jsonData['statusCode'] = 201;
        // // print(data.body);
        // // print(jsonData);
        // return InseminasiModel.fromJson(jsonData);
        return InseminasiModel.fromJson({
          "status": 201,
          "idInseminasi": jsonData['idInseminasi'],
          "hewan_id": jsonData['hewan_id'],
          //"idHewan": jsonData['idHewan'],
          "idPejantan": jsonData['idPejantan'],
          "idPembuatan": jsonData['idPembuatan'],
          "bangsaPejantan": jsonData['bangsaPejantan'],
          "ib": jsonData['ib'],

          "produsen": jsonData['produsen'],
          "peternak_id": jsonData['peternak_id'],
          "petugas_id": jsonData['petugas_id'],
          "tanggalIB": jsonData['tanggalIB'],
        });
      } else {
        // showErrorMessage(jsonData['message']);
        return InseminasiModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return InseminasiModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<InseminasiModel?> deleteInseminasiAPI(String idInseminasi) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/inseminasi/$idInseminasi'),
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
        // Kirim variabel postData ke dalam fungsi InseminasiModel.fromJson
        return InseminasiModel.fromJson({"status": 200});
      } else {
        // showErrorMessage(jsonData['message']);
        return InseminasiModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return InseminasiModel.fromJson({"status": 404});
    }
  }
}
