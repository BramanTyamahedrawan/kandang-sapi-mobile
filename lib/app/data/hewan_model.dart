//import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';

class HewanModel {
  final String? kodeEartagNasional;
  final String? noKartuTernak;
  final String? provinsi;
  final String? kabupaten;
  final String? kecamatan;
  final String? desa;
  final String? alamat;

  final PeternakModel? idPeternak;
  final KandangModel? idKandang;

  final String? spesies;
  final String? sex;
  final String? umur;
  final String? identifikasiHewan;
  final PetugasModel? petugasPendaftar;
  final String? tanggalTerdaftar;
  final String? fotoHewan;
  final String? latitude;
  final String? longitude;

  final int? status;

  HewanModel({
    this.status,
    this.kodeEartagNasional,
    this.noKartuTernak,
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.desa,
    this.alamat,
    this.idPeternak,
    this.idKandang,
    this.spesies,
    this.sex,
    this.umur,
    this.identifikasiHewan,
    this.petugasPendaftar,
    this.tanggalTerdaftar,
    this.fotoHewan,
    this.latitude,
    this.longitude,
  });

  factory HewanModel.fromJson(Map<String, dynamic> jsonData) {
    return HewanModel(
      status: jsonData['status'] ?? 0,
      kodeEartagNasional: jsonData['kodeEartagNasional'] ?? "",
      alamat: jsonData['alamat'] ?? "",
      provinsi: jsonData['provinsi'] ?? "",
      kabupaten: jsonData['kabupaten'] ?? "",
      kecamatan: jsonData['kecamatan'] ?? "",
      desa: jsonData['desa'] ?? "",
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      idKandang: jsonData['kandang'] != null
          ? KandangModel.fromJson(jsonData['kandang'])
          : null,
      spesies: jsonData['spesies'] ?? "",
      sex: jsonData['sex'] ?? "",
      umur: jsonData['umur'] ?? "",
      identifikasiHewan: jsonData['identifikasiHewan'] ?? "",
      petugasPendaftar: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      tanggalTerdaftar: jsonData['tanggalTerdaftar'] ?? "",
      fotoHewan: jsonData['file_path'] ?? "",
      latitude: jsonData['latitude'] ?? "",
      longitude: jsonData['longitude'] ?? "",
    );
  }
}

class HewanListModel {
  final int? status; //200 - 204 - 400 - 404
  final List<HewanModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  HewanListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory HewanListModel.fromJson(Map<String, dynamic> jsonData) {
    return HewanListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<HewanModel>((data) => HewanModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
