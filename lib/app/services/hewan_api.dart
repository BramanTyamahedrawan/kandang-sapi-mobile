import 'dart:io';

import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/internetMessage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class HewanApi extends SharedApi {
  final box = GetStorage();

  Future<HewanListModel> loadHewanApi() async {
    try {
      final String? role = box.read('role');
      final String? username = box.read('username');
      String apiUrl = '$baseUrl/hewan';

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
        return HewanListModel.fromJson({
          "status": 200,
          "content": jsonData['content'],
          "page": jsonData['page'],
          "size": jsonData['size'],
          "totalElements": jsonData['totalElements'],
          "totalPages": jsonData['totalPages']
        });
      } else {
        return HewanListModel.fromJson(
            {"status": response.statusCode, "content": []});
      }
    } on Exception catch (_) {
      return HewanListModel.fromJson({"status": 404, "content": []});
    }
  }

  int hitungUmurDalamBulan(String tanggalLahir) {
    try {
      print("Tanggal Lahir sebelum konversi: $tanggalLahir");

      // Konversi dari DD/MM/YYYY ke YYYY-MM-DD
      List<String> parts = tanggalLahir.split('/');
      if (parts.length == 3) {
        tanggalLahir =
            "${parts[2]}-${parts[1]}-${parts[0]}"; // Ubah ke YYYY-MM-DD
      }

      print("Tanggal Lahir setelah konversi: $tanggalLahir");

      DateTime birthDate = DateTime.parse(tanggalLahir);
      DateTime today = DateTime.now();

      int umurBulan =
          (today.year - birthDate.year) * 12 + (today.month - birthDate.month);
      return umurBulan;
    } catch (e) {
      print("Error dalam hitungUmurDalamBulan: $e");
      return 0;
    }
  }

  Future<HewanModel?> addHewanAPI(
      String kodeEartagNasional,
      String noKartuTernak,
      String idIsikhnasTernak,
      String idJenisHewan,
      String idRumpunHewan,
      String idTujuanPemeliharaan,
      String idPeternak,
      String idKandang,
      String sex,
      String tempatLahir,
      String tanggalLahir,
      String identifikasiHewan,
      String petugasId,
      File? fotoHewan) async {
    try {
      int umurDalamBulan = hitungUmurDalamBulan(tanggalLahir);
      String tanggalTerdaftar = DateFormat("yyyy-MM-dd").format(DateTime.now());
      var generateId = Uuid().v4();
      showLoading();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/hewan'),
      );

      request.fields.addAll({
        "idHewan": generateId,
        "kodeEartagNasional": kodeEartagNasional,
        "noKartuTernak": noKartuTernak,
        "idIsikhnasTernak": idIsikhnasTernak,
        "jenisHewanId": idJenisHewan,
        "rumpunHewanId": idRumpunHewan,
        "idTujuanPemeliharaan": idTujuanPemeliharaan,
        "idPeternak": idPeternak,
        "idKandang": idKandang,
        "sex": sex,
        "tempatLahir": tempatLahir,
        "tanggalLahir": tanggalLahir,
        "umur": umurDalamBulan.toString(),
        "identifikasiHewan": identifikasiHewan,
        "petugasId": petugasId,
        "tanggalTerdaftar": tanggalTerdaftar,
      });

      if (fotoHewan != null) {
        var imageField = http.MultipartFile(
          'file',
          fotoHewan.readAsBytes().asStream(),
          fotoHewan.lengthSync(),
          filename: fotoHewan.path.split("/").last,
        );
        request.files.add(imageField);
        print(
            "Foto Hewan: ${fotoHewan.path} (Ukuran: ${fotoHewan.lengthSync()} bytes)");
      } else {
        print("Foto Hewan: Tidak ada file yang dikirim");
      }

      request.headers.addAll(
        {
          ...getToken(),
          'Content-Type': 'multipart/form-data',
        },
      );

      // print("=== [DEBUG] Data yang dikirim ke API ===");
      // request.fields.forEach((key, value) {
      //   print("$key: $value");
      // });
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      // print("=== [DEBUG] Response dari API ===");
      // print("Status Code: ${response.statusCode}");
      // print("Response Body: $responseData");

      stopLoading();

      var jsonData = json.decode(responseData);

      if (response.statusCode == 201) {
        return HewanModel.fromJson({"status": 201, ...jsonData});
      } else {
        showErrorMessage(
            jsonData['message'] ?? "Terjadi kesalahan pada server.");
        return HewanModel.fromJson({"status": response.statusCode});
      }
    } catch (e, stacktrace) {
      stopLoading();
      print("=== [DEBUG] ERROR di addHewanAPI ===");
      print("Error: $e");
      print("Stacktrace: $stacktrace");

      showInternetMessage("Periksa koneksi internet anda");
      return HewanModel.fromJson({"status": 500});
    }
  }

//EDIT
  Future<HewanModel?> editHewanApi(
      String idHewan,
      String kodeEartagNasional,
      String noKartuTernak,
      String idIsikhnasTernak,
      String idJenisHewan,
      String idRumpunHewan,
      String idTujuanPemeliharaan,
      String idPeternak,
      String idKandang,
      String sex,
      String tempatLahir,
      String tanggalLahir,
      String identifikasiHewan,
      String petugasId,
      File? fotoHewan) async {
    try {
      var jsonData;
      showLoading();
      int umurDalamBulan = hitungUmurDalamBulan(tanggalLahir);
      String tanggalTerdaftar = DateFormat("yyyy-MM-dd").format(DateTime.now());
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/hewan/$idHewan'),
      );

      request.fields.addAll({
        "idHewan": idHewan,
        "kodeEartagNasional": kodeEartagNasional,
        "noKartuTernak": noKartuTernak,
        "idIsikhnasTernak": idIsikhnasTernak,
        "jenisHewanId": idJenisHewan,
        "rumpunHewanId": idRumpunHewan,
        "idTujuanPemeliharaan": idTujuanPemeliharaan,
        "idPeternak": idPeternak,
        "idKandang": idKandang,
        "sex": sex,
        "tempatLahir": tempatLahir,
        "tanggalLahir": tanggalLahir,
        "umur": umurDalamBulan.toString(),
        "identifikasiHewan": identifikasiHewan,
        "petugasId": petugasId,
        "tanggalTerdaftar": tanggalTerdaftar,
      });
      if (fotoHewan != null) {
        var imageField = http.MultipartFile(
          'file',
          fotoHewan.readAsBytes().asStream(),
          fotoHewan.lengthSync(),
          filename: fotoHewan.path.split("/").last,
        );
        request.files.add(imageField);
      }
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
        jsonData['statusCode'] = 201;
        print(response.contentLength);
        print(jsonData['alamat']);
        return HewanModel.fromJson({
          "status": 201,
          "kodeEartagNasional": jsonData['kodeEartagNasional'],
          "noKartuTernak": jsonData['noKartuTernak'],
          "idIsikhnasTernak": jsonData['idIsikhnasTernak'],
          "idJenisHewan": jsonData['idJenisHewan'],
          "idRumpunHewan": jsonData['idRumpunHewan'],
          "idTujuanPemeliharaan": jsonData['idTujuanPemeliharaan'],
          "idPeternak": jsonData['idPeternak'],
          "idKandag": jsonData['idKandag'],
          "sex": jsonData['sex'],
          "tempatLahir": jsonData['tempatLahir'],
          "tanggalLahir": jsonData['tanggalLahir'],
          "umur": jsonData['umur'],
          "identifikasiHewan": jsonData['identifikasiHewan'],
          "petugasId": jsonData['petugasId'],
          "tanggalTerdaftar": jsonData['tanggalTerdaftar'],
          "fotoHewan": jsonData['fotoHewan'],
        });
      } else {
        showErrorMessage(jsonData?['message']);
        return HewanModel.fromJson({"status": response.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return HewanModel.fromJson({"status": 404});
    }
  }

  //DELETE
  Future<HewanModel?> deleteHewanApi(String idHewan) async {
    try {
      var jsonData;
      showLoading();
      var data = await http.delete(
        Uri.parse('$baseUrl/hewan/$idHewan'),
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
        return HewanModel.fromJson({"status": 200});
      } else {
        showErrorMessage(jsonData['message']);
        return HewanModel.fromJson({"status": data.statusCode});
      }
    } on Exception catch (_) {
      stopLoading();
      showInternetMessage("Periksa koneksi internet anda");
      return HewanModel.fromJson({"status": 404});
    }
  }
}
