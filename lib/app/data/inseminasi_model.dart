import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';

class InseminasiModel {
  final String? idInseminasi;
  final String? tanggalIB;
  //final String? lokasi;
  final PeternakModel? idPeternak;
  //final String? idHewan;
  final HewanModel? kodeEartagNasional;
  final String? ib;
  // final String? ib2;
  // final String? ib3;
  // final String? ibLain;
  final String? idPejantan;
  final String? idPembuatan;
  final String? bangsaPejantan;
  final String? produsen;
  final PetugasModel? inseminator;

  final int? status;

  InseminasiModel({
    this.status,
    this.idInseminasi,
    this.kodeEartagNasional,
    //this.idHewan,
    this.idPembuatan,
    this.idPejantan,
    this.bangsaPejantan,
    this.ib,
    // this.ib2,
    // this.ib3,
    // this.ibLain,
    this.produsen,
    this.idPeternak,
    //this.lokasi,
    this.inseminator,
    this.tanggalIB,
  });

  factory InseminasiModel.fromJson(Map<String, dynamic> jsonData) {
    return InseminasiModel(
      status: jsonData['status'] ?? 0,
      idInseminasi: jsonData['idInseminasi'] ?? "",
      kodeEartagNasional: jsonData['hewan'] != null
          ? HewanModel.fromJson(jsonData['hewan'])
          : null,
      // idHewan: jsonData['idHewan'] ?? "",
      idPembuatan: jsonData['idPembuatan'] ?? "",
      idPejantan: jsonData['idPejantan'] ?? "",
      bangsaPejantan: jsonData['bangsaPejantan'] ?? "",
      ib: jsonData['ib'] ?? "",
      // ib2: jsonData['ib2'] ?? "",
      // ib3: jsonData['ib3'] ?? "",
      // ibLain: jsonData['ibLain'] ?? "",
      produsen: jsonData['produsen'] ?? "",
      idPeternak: jsonData['peternak'] != null
          ? PeternakModel.fromJson(jsonData['peternak'])
          : null,
      // lokasi: jsonData['lokasi'] ?? "",
      inseminator: jsonData['petugas'] != null
          ? PetugasModel.fromJson(jsonData['petugas'])
          : null,
      tanggalIB: jsonData['tanggalIB'] ?? "",
    );
  }
}

class InseminasiListModel {
  final int? status; // 200 - 204 - 400 - 404
  final List<InseminasiModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  InseminasiListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory InseminasiListModel.fromJson(Map<String, dynamic> jsonData) {
    return InseminasiListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<InseminasiModel>((data) => InseminasiModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
