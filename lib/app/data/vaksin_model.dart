import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';

class VaksinModel {
  final int? status;
  final String? idVaksin;
  final PeternakModel? idPeternak;
  final HewanModel? kodeEartagNasional;
  final PetugasModel? inseminator;
  final NamaVaksinModel? namaVaksin;
  final JenisVaksinModel? jenisVaksin;
  final String? batchVaksin;
  final String? vaksinKe;
  final String? tglVaksin;

  VaksinModel({
    this.status,
    this.idVaksin,
    this.idPeternak,
    this.kodeEartagNasional,
    this.inseminator,
    this.namaVaksin,
    this.jenisVaksin,
    this.batchVaksin,
    this.vaksinKe,
    this.tglVaksin,
  });

  factory VaksinModel.fromJson(Map<String, dynamic> jsonData) {
    return VaksinModel(
      status: jsonData['status'] ?? 0,
      idVaksin: jsonData['idVaksin'] ?? "",
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      kodeEartagNasional: jsonData['hewan'] != null
          ? HewanModel.fromJson(jsonData['hewan'])
          : null,
      inseminator: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      namaVaksin: jsonData['namaVaksin'] != null
          ? NamaVaksinModel.fromJson(jsonData["namaVaksin"])
          : null,
      jenisVaksin: jsonData['jenisVaksin'] != null
          ? JenisVaksinModel.fromJson(jsonData["jenisVaksin"])
          : null,
      batchVaksin: jsonData['batchVaksin'] ?? "",
      vaksinKe: jsonData['vaksinKe'] ?? "",
      tglVaksin: jsonData['tglVaksin'] ?? "",
    );
  }
}

class VaksinListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<VaksinModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  VaksinListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory VaksinListModel.fromJson(Map<String, dynamic> jsonData) {
    return VaksinListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<VaksinModel>((data) => VaksinModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
