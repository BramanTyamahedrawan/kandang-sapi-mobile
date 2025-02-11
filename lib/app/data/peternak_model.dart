import 'dart:convert';

import 'package:crud_flutter_api/app/data/petugas_model.dart';

class PeternakModel {
  final String? idPeternak;
  final String? idISIKHNAS;
  final String? namaPeternak;
  final String? nikPeternak;
  final String? noTelp;
  final String? emailPeternak;
  final String? gender;
  final String? tanggalLahir;
  final Map<String, dynamic>? provinsi;
  final Map<String, dynamic>? kabupaten;
  final Map<String, dynamic>? kecamatan;
  final Map<String, dynamic>? desa;
  final String? dusun;
  final String? lokasi;
  final PetugasModel? petugasPendaftar;
  final String? tanggalPendaftaran;
  final int? status;

  PeternakModel({
    this.status,
    this.idPeternak,
    this.idISIKHNAS,
    this.namaPeternak,
    this.nikPeternak,
    this.noTelp,
    this.emailPeternak,
    this.gender,
    this.tanggalLahir,
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.desa,
    this.dusun,
    this.lokasi,
    this.petugasPendaftar,
    this.tanggalPendaftaran,
  });

  factory PeternakModel.fromJson(Map<String, dynamic> jsonData) {
    return PeternakModel(
      status: jsonData['status'] ?? 0,
      idPeternak: jsonData['idPeternak'] ?? "",
      idISIKHNAS: jsonData['idISIKHNAS'] ?? "",
      namaPeternak: jsonData['namaPeternak'] ?? "",
      nikPeternak: jsonData['nikPeternak'] ?? "",
      noTelp: jsonData['noTelp'] ?? "",
      emailPeternak: jsonData['emailPeternak'] ?? "",
      gender: jsonData['gender'] ?? "",
      tanggalLahir: jsonData['tanggalLahir'] ?? "",
      provinsi: jsonData['provinsi'] ?? {}, // Simpan sebagai Map
      kabupaten: jsonData['kabupaten'] ?? {},
      kecamatan: jsonData['kecamatan'] ?? {},
      desa: jsonData['desa'] ?? {},
      dusun: jsonData['dusun'] ?? "",
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
