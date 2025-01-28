import 'package:crud_flutter_api/app/data/peternak_model.dart';

class KandangModel {
  final String? idKandang;
  final PeternakModel? idPeternak;
  final String? luas;
  final String? kapasitas;
  final String? nilaiBangunan;
  final String? alamat;
  final String? provinsi;
  final String? kabupaten;
  final String? kecamatan;
  final String? desa;
  final String? fotoKandang;
  final String? latitude;
  final String? longitude;
  final String? jenisHewan;

  final int? status;

  KandangModel({
    this.status,
    this.idKandang,
    this.idPeternak,
    this.luas,
    this.kapasitas,
    this.nilaiBangunan,
    this.alamat,
    this.desa,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.fotoKandang,
    this.latitude,
    this.longitude,
    this.jenisHewan,
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
      nilaiBangunan: jsonData['nilaiBangunan'] ?? "",
      alamat: jsonData['alamat'] ?? "",
      desa: jsonData['desa'] ?? "",
      kecamatan: jsonData['kecamatan'] ?? "",
      kabupaten: jsonData['kabupaten'] ?? "",
      provinsi: jsonData['provinsi'] ?? "",
      fotoKandang: jsonData['file_path'] ?? "",
      latitude: jsonData['latitude'] ?? "",
      longitude: jsonData['longitude'] ?? "",
      jenisHewan: jsonData['jenisHewan'] ?? "",
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

// class IdPeternak {
//   DateTime createdAt;
//   DateTime updatedAt;
//   int createdBy;
//   int updatedBy;
//   String idPeternak;
//   String nikPeternak;
//   String namaPeternak;
//   String idIsikhnas;
//   String lokasi;
//   String petugasPendaftar;
//   String tanggalPendaftaran;

//   IdPeternak({
//     required this.createdAt,
//     required this.updatedAt,
//     required this.createdBy,
//     required this.updatedBy,
//     required this.idPeternak,
//     required this.nikPeternak,
//     required this.namaPeternak,
//     required this.idIsikhnas,
//     required this.lokasi,
//     required this.petugasPendaftar,
//     required this.tanggalPendaftaran,
//   });

//   factory IdPeternak.fromJson(Map<String, dynamic> json) => IdPeternak(
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         createdBy: json["createdBy"],
//         updatedBy: json["updatedBy"],
//         idPeternak: json["idPeternak"],
//         nikPeternak: json["nikPeternak"],
//         namaPeternak: json["namaPeternak"],
//         idIsikhnas: json["idISIKHNAS"],
//         lokasi: json["lokasi"],
//         petugasPendaftar: json["petugasPendaftar"],
//         tanggalPendaftaran: json["tanggalPendaftaran"],
//       );

//   Map<String, dynamic> toJson() => {
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "createdBy": createdBy,
//         "updatedBy": updatedBy,
//         "idPeternak": idPeternak,
//         "nikPeternak": nikPeternak,
//         "namaPeternak": namaPeternak,
//         "idISIKHNAS": idIsikhnas,
//         "lokasi": lokasi,
//         "petugasPendaftar": petugasPendaftar,
//         "tanggalPendaftaran": tanggalPendaftaran,
//       };
// }
