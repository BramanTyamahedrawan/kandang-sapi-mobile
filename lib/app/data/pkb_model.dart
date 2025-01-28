import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';

class PKBModel {
  final int? status;
  final String? idKejadian;
  final HewanModel? kodeEartagNasional;
  final String? tanggalPkb;
  final String? lokasi;
  final PeternakModel? idPeternak;
  // final String? idHewan;
  final String? spesies;
  final String? kategori;
  final String? jumlah;
  final String? umurKebuntingan;
  final PetugasModel? pemeriksaKebuntingan;

  PKBModel({
    this.status,
    this.idKejadian,
    this.kodeEartagNasional,
    this.tanggalPkb,
    this.lokasi,
    this.idPeternak,
    // this.idHewan,
    this.spesies,
    this.kategori,
    this.jumlah,
    this.umurKebuntingan,
    this.pemeriksaKebuntingan,
  });

  factory PKBModel.fromJson(Map<String, dynamic> jsonData) {
    return PKBModel(
      status: jsonData['status'] ?? 0,
      idKejadian: jsonData['idKejadian'] ?? "",
      kodeEartagNasional: jsonData['hewan'] != null
          ? HewanModel.fromJson(jsonData['hewan'])
          : null,
      tanggalPkb: jsonData['tanggalPkb'] ?? "",
      lokasi: jsonData['lokasi'] ?? "",
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      //idHewan: jsonData['idHewan'] ?? "",
      spesies: jsonData['spesies'] ?? "",
      kategori: jsonData['kategori'] ?? "",
      jumlah: jsonData['jumlah'] ?? "",
      umurKebuntingan: jsonData['umurKebuntingan'] ?? "",
      pemeriksaKebuntingan: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
    );
  }
}

class PKBListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<PKBModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  PKBListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory PKBListModel.fromJson(Map<String, dynamic> jsonData) {
    return PKBListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<PKBModel>((data) => PKBModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
