import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/data/pengobatan_model.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PengobatanApi extends SharedApi {
  // Login API
  Future<PengobatanListModel> loadPengobatanAPI() async {
    try {
      var data =
          await http.get(Uri.parse('$baseUrl/pengobatan'), headers: getToken());
      //print("hasil" + data.statusCode.toString());
      //print(json.decode(data.body));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);

        //print(jsonData['content']);

        return PengobatanListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return PengobatanListModel.fromJson(
            {"status": data.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return PengobatanListModel.fromJson({"status": 404, "content": []});
    }
  }

//ADD
  Future<PengobatanModel?> addPengobatanAPI(
    String idKasus,
    String tanggalPengobatan,
    String tanggalKasus,
    String petugasId,
    String namaInfrastruktur,
    String lokasi,
    String dosis,
    String sindrom,
    String dignosaBanding,
    String provinsiPengobatan,
    String kabupatenPengobatan,
    String kecamatanPengobatan,
    String desaPengobatan,
  ) async {
    try {
      var generatedId = Uuid().v4();
      var jsonData;
      showLoading();

      var bodyData = {
        'idPengobatan': generatedId,
        'idKasus': idKasus,
        'tanggalPengobatan': tanggalPengobatan,
        'tanggalKasus': tanggalKasus,
        'petugasId': petugasId,
        'namaInfrastruktur': namaInfrastruktur,
        'lokasi': lokasi,
        'dosis': dosis,
        'sindrom': sindrom,
        'diagnosaBanding': dignosaBanding,
        'provinsiPengobatan': provinsiPengobatan,
        'kabupatenPengobatan': kabupatenPengobatan,
        'kecamatanPengobatan': kecamatanPengobatan,
        'desaPengobatan': desaPengobatan,
      };
      var data = await http.post(
        Uri.parse('$baseUrl/pengobatan'),
        headers: {
          ...getToken(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );
      stopLoading();
      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return PengobatanModel.fromJson({
          "status": 201,
          "idPengobatan": jsonData['idPengobatan'],
          "idKasus": jsonData['idKasus'],
          "tanggalPengobatan": jsonData['tanggalPengobatan'],
          "tanggalKasus": jsonData['tanggalKasus'],
          "petugas_id": jsonData['petugas_id'],
          "namaInfrastruktur": jsonData['namaInfrastruktur'],
          "lokasi": jsonData['lokasi'],
          "dosis": jsonData['dosis'],
          "sindrom": jsonData['sindrom'],
          "diagnosaBanding": jsonData['dignosaBanding'],
          "provinsiPengobatan": jsonData['provinsiPengobatan'],
          "kabupatenPengobatan": jsonData['kabupatenPengobatan'],
          "kecamatanPengobatan": jsonData['kecamatanPengobatan'],
          "desaPengobatan": jsonData['desaPengobatan'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return PengobatanModel.fromJson({"status": data.statusCode});
      }
    } catch (e) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PengobatanModel.fromJson({"status": 404});
    }
  }

//EDIT
  Future<PengobatanModel?> editPengobatanApi(
    String idPengobatan,
    String idKasus,
    String tanggalPengobatan,
    String tanggalKasus,
    String petugasId,
    String namaInfrastruktur,
    String lokasi,
    String dosis,
    String sindrom,
    String dignosaBanding,
    String provinsiPengobatan,
    String kabupatenPengobatan,
    String kecamatanPengobatan,
    String desaPengobatan,
  ) async {
    try {
      var jsonData;
      showLoading();
      var bodyDataedit = {
        'idKasus': idKasus,
        'tanggalPengobatan': tanggalPengobatan,
        'tanggalKasus': tanggalKasus,
        'petugasId': petugasId,
        'namaInfrastruktur': namaInfrastruktur,
        'lokasi': lokasi,
        'dosis': dosis,
        'sindrom': sindrom,
        'diagnosaBanding': dignosaBanding,
        'provinsiPengobatan': provinsiPengobatan,
        'kabupatenPengobatan': kabupatenPengobatan,
        'kecamatanPengobatan': kecamatanPengobatan,
        'desaPengobatan': desaPengobatan,
      };

      var data = await http.put(
        Uri.parse('$baseUrl/pengobatan/$idPengobatan'),
        headers: {...getToken(), 'Content-Type': 'application/json'},
        body: jsonEncode(bodyDataedit),
      );
      print(data.body);
      stopLoading();

      jsonData = json.decode(data.body);
      if (data.statusCode == 201) {
        return PengobatanModel.fromJson({
          "status": 201,
          "idKasus": jsonData['idKasus'],
          "tanggalPengobatan": jsonData['tanggalPengobatan'],
          "tanggalKasus": jsonData['tanggalKasus'],
          "petugas_id": jsonData['petugas_id'],
          "namaInfrastruktur": jsonData['namaInfrastruktur'],
          "lokasi": jsonData['lokasi'],
          "dosis": jsonData['dosis'],
          "sindrom": jsonData['sindrom'],
          "diagnosaBanding": jsonData['dignosaBanding'],
          "provinsiPengobatan": jsonData['provinsiPengobatan'],
          "kabupatenPengobatan": jsonData['kabupatenPengobatan'],
          "kecamatanPengobatan": jsonData['kecamatanPengobatan'],
          "desaPengobatan": jsonData['desaPengobatan'],
        });
      } else {
        showErrorMessage(jsonData['message']);
        return PengobatanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PengobatanModel.fromJson({"status": 404});
    }
  }

//DELETE
  Future<PengobatanModel?> deletePengobatanAPI(String idPengobatan) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/pengobatan/$idPengobatan'),
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
        // Kirim variabel postData ke dalam fungsi PengobatanModel.fromJson
        return PengobatanModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return PengobatanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return PengobatanModel.fromJson({"status": 404});
    }
  }
}
