import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';

class KandangModel {
  final String? idKandang;
  final PeternakModel? idPeternak;
  final String? luas;
  final String? namaKandang;
  final String? kapasitas;
  final String? nilaiBangunan;
  final String? jenisKandang;
  final String? alamat;
  final String? provinsi;
  final String? kabupaten;
  final String? kecamatan;
  final String? desa;
  final String? fotoKandang;
  final String? latitude;
  final String? longitude;
  final JenisHewanModel? idJenisHewan;

  final int? status;

  KandangModel({
    this.status,
    this.idKandang,
    this.idPeternak,
    this.namaKandang,
    this.luas,
    this.kapasitas,
    this.nilaiBangunan,
    this.jenisKandang,
    this.alamat,
    this.desa,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.fotoKandang,
    this.latitude,
    this.longitude,
    this.idJenisHewan,
  });

  factory KandangModel.fromJson(Map<String, dynamic> jsonData) {
    return KandangModel(
      status: jsonData['status'] ?? 0,
      idKandang: jsonData['idKandang'] ?? "",
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      luas: jsonData['luas'] ?? "",
      kapasitas: jsonData['kapasitas'] ?? "",
      namaKandang: jsonData['namaKandang'] ?? "",
      nilaiBangunan: jsonData['nilaiBangunan'] ?? "",
      alamat: jsonData['alamat'] ?? "",
      desa: jsonData['desa'] ?? "",
      kecamatan: jsonData['kecamatan'] ?? "",
      kabupaten: jsonData['kabupaten'] ?? "",
      provinsi: jsonData['provinsi'] ?? "",
      fotoKandang: jsonData['file_path'] ?? "",
      latitude: jsonData['latitude'] ?? "",
      longitude: jsonData['longitude'] ?? "",
      jenisKandang: jsonData['jenisKandang'] ?? "",
      idJenisHewan: jsonData['jenisHewan'] != null
          ? JenisHewanModel.fromJson(jsonData['jenisHewan'])
          : null,
    );
  }
}

class KandangListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<KandangModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  KandangListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory KandangListModel.fromJson(Map<String, dynamic> jsonData) {
    return KandangListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<KandangModel>((data) => KandangModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
