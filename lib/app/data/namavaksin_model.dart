import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';

class NamaVaksinModel {
  final int? status;
  final String? idNamaVaksin;
  final JenisVaksinModel? idJenisVaksin;
  final String? nama;
  final String? deskripsi;
  final String? message;

  NamaVaksinModel(
      {this.status,
      this.idNamaVaksin,
      this.idJenisVaksin,
      this.nama,
      this.deskripsi,
      this.message});

  factory NamaVaksinModel.fromJson(Map<String, dynamic> jsonData) {
    return NamaVaksinModel(
        status: jsonData['status'] ?? 0,
        idNamaVaksin: jsonData['idNamaVaksin'] ?? "",
        idJenisVaksin: jsonData['jenisVaksin'] != null
            ? JenisVaksinModel.fromJson(jsonData['jenisVaksin'])
            : null,
        nama: jsonData['nama'] ?? "",
        deskripsi: jsonData['deskripsi'] ?? "",
        message: jsonData['message'] ?? "");
  }
}

class NamaVaksinListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<NamaVaksinModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  NamaVaksinListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory NamaVaksinListModel.fromJson(Map<String, dynamic> jsonData) {
    return NamaVaksinListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<NamaVaksinModel>((data) => NamaVaksinModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
