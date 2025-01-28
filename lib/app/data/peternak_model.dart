import 'package:crud_flutter_api/app/data/petugas_model.dart';

class PeternakModel {
  final String? idPeternak;
  final String? nikPeternak;
  final String? namaPeternak;
  final String? idISIKHNAS;
  final String? lokasi;
  final PetugasModel? petugasPendaftar;
  final String? tanggalPendaftaran;

  final int? status;

  PeternakModel({
    this.status,
    this.idPeternak,
    this.nikPeternak,
    this.namaPeternak,
    this.idISIKHNAS,
    this.lokasi,
    this.petugasPendaftar,
    this.tanggalPendaftaran,
  });

  factory PeternakModel.fromJson(Map<String, dynamic> jsonData) {
    return PeternakModel(
      status: jsonData['status'] ?? 0,
      idPeternak: jsonData['idPeternak'] ?? "",
      nikPeternak: jsonData['nikPeternak'] ?? "",
      namaPeternak: jsonData['namaPeternak'] ?? "",
      idISIKHNAS: jsonData['idISIKHNAS'] ?? "",
      lokasi: jsonData['lokasi'] ?? "",
      petugasPendaftar: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      tanggalPendaftaran: jsonData['tanggalPendaftaran'] ?? "",
    );
  }
}

class PeternakListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<PeternakModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  PeternakListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory PeternakListModel.fromJson(Map<String, dynamic> jsonData) {
    return PeternakListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<PeternakModel>((data) => PeternakModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
