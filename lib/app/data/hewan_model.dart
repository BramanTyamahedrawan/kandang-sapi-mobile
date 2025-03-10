//import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/data/rumpunhewan_model.dart';
import 'package:crud_flutter_api/app/data/tujuanpemeliharaan_model.dart';

class HewanModel {
  final String? idHewan;
  final String? kodeEartagNasional;
  final String? noKartuTernak;
  final String? idIsikhnasTernak;
  final JenisHewanModel? jenisHewan;
  final RumpunHewanModel? rumpunHewan;
  final TujuanPemeliharaanModel? tujuanPemeliharaan;
  final PeternakModel? idPeternak;
  final KandangModel? idKandang;
  final String? sex;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? umur;
  final String? identifikasiHewan;
  final PetugasModel? petugasPendaftar;
  final String? tanggalTerdaftar;
  final String? fotoHewan;
  final String? latitude;
  final String? longitude;
  final int? status;

  HewanModel({
    this.idHewan,
    this.status,
    this.kodeEartagNasional,
    this.noKartuTernak,
    this.idIsikhnasTernak,
    this.jenisHewan,
    this.rumpunHewan,
    this.tujuanPemeliharaan,
    this.idPeternak,
    this.idKandang,
    this.tanggalLahir,
    this.tempatLahir,
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
      idHewan: jsonData['idHewan'] ?? "",
      kodeEartagNasional: jsonData['kodeEartagNasional'] ?? "",
      noKartuTernak: jsonData['noKartuTernak'] ?? "",
      idIsikhnasTernak: jsonData['idIsikhnasTernak'] ?? "",
      jenisHewan: jsonData['jenisHewan'] != null
          ? JenisHewanModel.fromJson(jsonData['jenisHewan'])
          : null,
      rumpunHewan: jsonData['rumpunHewan'] != null
          ? RumpunHewanModel.fromJson(jsonData['rumpunHewan'])
          : null,
      tujuanPemeliharaan: jsonData['tujuanPemeliharaan'] != null
          ? TujuanPemeliharaanModel.fromJson(jsonData['tujuanPemeliharaan'])
          : null,
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      idKandang: jsonData['kandang'] != null
          ? KandangModel.fromJson(jsonData['kandang'])
          : null,
      tanggalLahir: jsonData['tanggalLahir'] ?? "",
      tempatLahir: jsonData['tempatLahir'] ?? "",
      sex: jsonData['sex'] ?? "",
      umur: jsonData['umur'] ?? "",
      identifikasiHewan: jsonData['identifikasiHewan'] ?? "",
      petugasPendaftar: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      tanggalTerdaftar: jsonData['tanggalTerdaftar'] ?? "",
      fotoHewan: jsonData['file_path'] ?? "",
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
