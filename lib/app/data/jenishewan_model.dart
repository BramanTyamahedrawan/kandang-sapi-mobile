class JenisHewanModel {
  final String? idJenisHewan;
  final String? jenis;
  final String? deskripsi;
  final int? status;
  final String?
      message; // Menambahkan properti message untuk menyimpan pesan dari API

  JenisHewanModel(
      {this.idJenisHewan,
      this.jenis,
      this.deskripsi,
      this.status,
      this.message});

  factory JenisHewanModel.fromJson(Map<String, dynamic> jsonData) {
    return JenisHewanModel(
      status: jsonData['status'] ?? 0,
      idJenisHewan: jsonData['idJenisHewan'] ?? "",
      jenis: jsonData['jenis'] ?? "",
      deskripsi: jsonData['deskripsi'] ?? "",
      message: jsonData['message'] ?? "", // Menambahkan mapping message
    );
  }
}

class JenisHewanListModel {
  final int? status;
  final List<JenisHewanModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;

  JenisHewanListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});

  factory JenisHewanListModel.fromJson(Map<String, dynamic> jsonData) {
    return JenisHewanListModel(
        status: jsonData['status'],
        content: jsonData['content'] != null
            ? jsonData['content']
                .map<JenisHewanModel>((data) => JenisHewanModel.fromJson(data))
                .toList()
            : [],
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }

  void assignAll(List<JenisHewanModel> filteredList) {}
}
