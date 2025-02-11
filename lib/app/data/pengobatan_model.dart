import 'package:crud_flutter_api/app/data/petugas_model.dart';

class PengobatanModel {
  final int? status;

  final String? idPengobatan;
  final String? idKasus;
  final String? tanggalPengobatan;
  final String? tanggalKasus;
  final PetugasModel? namaPetugas;
  final String? namaInfrastruktur;
  final String? lokasi;
  final String? dosis;
  final String? sindrom;
  final String? diagnosaBanding;
  final String? provinsiPengobatan;
  final String? kabupatenPengobatan;
  final String? kecamatanPengobatan;
  final String? desaPengobatan;

  final String? message;

  PengobatanModel({
    this.status,
    this.idPengobatan,
    this.idKasus,
    this.tanggalPengobatan,
    this.tanggalKasus,
    this.namaPetugas,
    this.namaInfrastruktur,
    this.lokasi,
    this.dosis,
    this.sindrom,
    this.diagnosaBanding,
    this.provinsiPengobatan,
    this.kabupatenPengobatan,
    this.kecamatanPengobatan,
    this.desaPengobatan,
    this.message,
  });

  factory PengobatanModel.fromJson(Map<String, dynamic> jsonData) {
    return PengobatanModel(
      status: jsonData['status'] ?? 0,
      idPengobatan: jsonData['idPengobatan'] ?? "",
      idKasus: jsonData['idKasus'] ?? "",
      tanggalPengobatan: jsonData['tanggalPengobatan'] ?? "",
      tanggalKasus: jsonData['tanggalKasus'] ?? "",
      namaPetugas: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      namaInfrastruktur: jsonData['namaInfrastruktur'] ?? "",
      lokasi: jsonData['lokasi'] ?? "",
      dosis: jsonData['dosis'] ?? "",
      sindrom: jsonData['sindrom'] ?? "",
      diagnosaBanding: jsonData['diagnosaBanding'] ?? "",
      provinsiPengobatan: jsonData['provinsiPengobatan'] ?? "",
      kabupatenPengobatan: jsonData['kabupatenPengobatan'] ?? "",
      kecamatanPengobatan: jsonData['kecamatanPengobatan'] ?? "",
      desaPengobatan: jsonData['desaPengobatan'] ?? "",
      message: jsonData['message'] ?? "",
    );
  }
}

class PengobatanListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<PengobatanModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  PengobatanListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory PengobatanListModel.fromJson(Map<String, dynamic> jsonData) {
    return PengobatanListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<PengobatanModel>((data) => PengobatanModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
