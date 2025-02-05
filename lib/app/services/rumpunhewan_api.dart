import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/data/RumpunHewan_model.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RumpunHewanApi extends SharedApi {
  // Login API
  Future<RumpunHewanListModel> loadRumpunHewanApi() async {
    try {
      var data = await http.get(Uri.parse('$baseUrl/rumpunhewan'),
          headers: getToken());
      // print("hasil" + data.statusCode.toString());
      // print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        // print(jsonData['content']);

        return RumpunHewanListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return RumpunHewanListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return RumpunHewanListModel.fromJson({"status": 404, "content": []});
    }
  }

//   Future<RumpunHewanModel?> addRumpunHewanApi(String nikRumpunHewan, String namaRumpunHewan, String noTelp, String email) async {
//  try {
//  var jsonData;
//  showLoading();
//  var data = await http.post(
//  Uri.parse(baseUrl + '/RumpunHewan'),
//  headers: {
//   ...getToken(),
//           'Content-Type': 'application/json',
//         },
//  body: {'nikRumpunHewan': nikRumpunHewan, 'namaRumpunHewan': namaRumpunHewan, 'noTelp': noTelp, 'email': email},
//  );
//  stopLoading();
//  jsonData = json.decode(data.body);
//  if (data.statusCode == 200) {
//  jsonData['data']['status_code'] = 200;
//  return RumpunHewanModel.fromJson(jsonData['data']);
//  } else {
//  showErrorMessage(jsonData['message']);
//  return RumpunHewanModel.fromJson({"status": data.statusCode});
//  }
//  } on Exception catch (_) {
//  stopLoading();
//  showInternetMessage("Periksa koneksi internet anda");
//  return RumpunHewanModel.fromJson({"status": 404});
//  }
//  }

//ADD
  Future<RumpunHewanModel?> addRumpunHewanApi(
      String rumpun, String deskripsi) async {
    try {
      var generateId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idRumpunHewan': generateId,
        'rumpun': rumpun,
        'deskripsi': deskripsi,
      };
      var data = await http.post(
        Uri.parse("$baseUrl/rumpunhewan"),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return RumpunHewanModel.fromJson({
          "status": 201,
          "rumpun": jsonData['rumpun'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return RumpunHewanModel.fromJson({"status": data.statusCode});
      }
    } catch (e) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return RumpunHewanModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<RumpunHewanModel?> editRumpunHewanApi(
      String idRumpunHewan, String rumpun, String deskripsi) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {'rumpun': rumpun, 'deskripsi': deskripsi};

      var data = await http.put(
        Uri.parse('$baseUrl/rumpunhewan/$idRumpunHewan'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        // print(data.body);
        // print(jsonData);
        return RumpunHewanModel.fromJson({
          "status": 201,
          "rumpun": jsonData['rumpun'],
          "deskripsi": jsonData['deskripsi'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return RumpunHewanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return RumpunHewanModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<RumpunHewanModel?> deleteRumpunHewanApi(String idRumpunHewan) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/rumpunhewan/$idRumpunHewan'),
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
        // Kirim variabel postData ke dalam fungsi RumpunHewanModel.fromJson
        return RumpunHewanModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return RumpunHewanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return RumpunHewanModel.fromJson({"status": 404});
    }
  }
}
