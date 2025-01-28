import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';

class KelahiranModel {
  final int? status;
  final String? idKejadian;
  final String? tanggalLaporan;
  final String? tanggalLahir;
  final PeternakModel? idPeternak;
  final HewanModel? kodeEartagNasional;
  final KandangModel? idKandang;
  final PetugasModel? petugasPelapor;
  final InseminasiModel? idInseminasi;

  final String? eartagAnak;
  final String? jenisKelaminAnak;
  final String? spesies;
  final String? urutanIb;

  KelahiranModel({
    this.status,
    this.idKejadian,
    this.tanggalLaporan,
    this.tanggalLahir,
    this.idPeternak,
    this.kodeEartagNasional,
    this.idKandang,
    this.petugasPelapor,
    this.idInseminasi,
    this.eartagAnak,
    this.jenisKelaminAnak,
    this.spesies,
    this.urutanIb,
  });

  factory KelahiranModel.fromJson(Map<String, dynamic> jsonData) {
    return KelahiranModel(
      status: jsonData['status'] ?? 0,
      idKejadian: jsonData['idKejadian'] ?? "",
      tanggalLaporan: jsonData['tanggalLaporan'] ?? "",
      tanggalLahir: jsonData['tanggalLahir'] ?? "",
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      kodeEartagNasional: jsonData['hewan'] != null
          ? HewanModel.fromJson(jsonData['hewan'])
          : null,
      idKandang: jsonData['kandang'] != null
          ? KandangModel.fromJson(jsonData['kandang'])
          : null,
      petugasPelapor: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      idInseminasi: jsonData['inseminasi'] != null
          ? InseminasiModel.fromJson(jsonData['inseminasi'])
          : null,
      eartagAnak: jsonData['eartagAnak'] ?? "",
      jenisKelaminAnak: jsonData['jenisKelaminAnak'] ?? "",
      spesies: jsonData['spesies'] ?? "",
    );
  }
}

class KelahiranListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<KelahiranModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  KelahiranListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory KelahiranListModel.fromJson(Map<String, dynamic> jsonData) {
    return KelahiranListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<KelahiranModel>((data) => KelahiranModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
