import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PetugasApi extends SharedApi {
  // Login API
  Future<PetugasListModel> loadPetugasApi() async {
    try {
      var data =
          await http.get(Uri.parse('$baseUrl/petugas'), headers: getToken());
      // print("hasil" + data.statusCode.toString());
      // print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        // print(jsonData['content']);

        return PetugasListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return PetugasListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return PetugasListModel.fromJson({"status": 404, "content": []});
    }
  }

//   Future<PetugasModel?> addPetugasApi(String nikPetugas, String namaPetugas, String noTelp, String email) async {
//  try {
//  var jsonData;
//  showLoading();
//  var data = await http.post(
//  Uri.parse(baseUrl + '/petugas'),
//  headers: {
//   ...getToken(),
//           'Content-Type': 'application/json',
//         },
//  body: {'nikPetugas': nikPetugas, 'namaPetugas': namaPetugas, 'noTelp': noTelp, 'email': email},
//  );
//  stopLoading();
//  jsonData = json.decode(data.body);
//  if (data.statusCode == 200) {
//  jsonData['data']['status_code'] = 200;
//  return PetugasModel.fromJson(jsonData['data']);
//  } else {
//  showErrorMessage(jsonData['message']);
//  return PetugasModel.fromJson({"status": data.statusCode});
//  }
//  } on Exception catch (_) {
//  stopLoading();
//  showInternetMessage("Periksa koneksi internet anda");
//  return PetugasModel.fromJson({"status": 404});
//  }
//  }

//ADD
  Future<PetugasModel?> addPetugasApi(String nikPetugas, String namaPetugas,
      String noTelp, String email) async {
    try {
      var jsonData;
      showLoading();

      var bodyData = {
        'nikPetugas': nikPetugas,
        'namaPetugas': namaPetugas,
        'noTelp': noTelp,
        'email': email
      };
      var data = await http.post(
        Uri.parse("$baseUrl/petugas"),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return PetugasModel.fromJson({
          "status": 201,
          "nikPetugas": jsonData['nikPetugas'],
          "namaPetugas": jsonData['namaPetugas'],
          "noTelp": jsonData['noTelp'],
          "email": jsonData['email'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return PetugasModel.fromJson({"status": data.statusCode});
      }
    } catch (e) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PetugasModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<PetugasModel?> editPetugasApi(String nikPetugas, String namaPetugas,
      String noTelp, String email) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'nikPetugas': nikPetugas,
        'namaPetugas': namaPetugas,
        'noTelp': noTelp,
        'email': email
      };

      var data = await http.put(
        Uri.parse('$baseUrl/petugas/$nikPetugas'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        jsonData['statusCode'] = 201;
        // print(data.body);
        // print(jsonData);
        return PetugasModel.fromJson(jsonData);
      } else {
        showErrorMessage(jsonData['message']);
        return PetugasModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PetugasModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<PetugasModel?> deletePetugasApi(String nikPetugas) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/petugas/$nikPetugas'),
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
        // Kirim variabel postData ke dalam fungsi PetugasModel.fromJson
        return PetugasModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return PetugasModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PetugasModel.fromJson({"status": 404});
    }
  }
}
