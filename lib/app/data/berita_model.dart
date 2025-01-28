class BeritaModel {
  final String? idBerita;
  final String? judul;
  final String? tglPembuatan;
  final String? isiBerita;
  final String? pembuat;
  final String? fotoBerita;

  final int? status;

  BeritaModel({
    this.status,
    this.idBerita,
    this.judul,
    this.tglPembuatan,
    this.pembuat,
    this.isiBerita,
    this.fotoBerita,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> jsonData) {
    return BeritaModel(
      status: jsonData['status'] ?? 0,
      idBerita: jsonData['idBerita'] ?? "",
      judul: jsonData['judul'] ?? "",
      tglPembuatan: jsonData['tglPembuatan'] ?? "",
      isiBerita: jsonData['isiBerita'] ?? "",
      fotoBerita: jsonData['file_path'] ?? "",
    );
  }
}

class BeritaListModel {
  final int? status; //200 - 204 - 400 - 404
  final List<BeritaModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;
  BeritaListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});
  factory BeritaListModel.fromJson(Map<String, dynamic> jsonData) {
    return BeritaListModel(
        status: jsonData['status'],
        content: jsonData['content']
            .map<BeritaModel>((data) => BeritaModel.fromJson(data))
            .toList(),
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }
}
