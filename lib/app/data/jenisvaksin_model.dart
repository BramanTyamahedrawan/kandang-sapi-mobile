class JenisVaksinModel {
  final String? idJenisVaksin;
  final String? jenis;
  final String? deskripsi;
  final int? status;
  final String?
      message; // Menambahkan properti message untuk menyimpan pesan dari API

  JenisVaksinModel(
      {this.idJenisVaksin,
      this.jenis,
      this.deskripsi,
      this.status,
      this.message});

  factory JenisVaksinModel.fromJson(Map<String, dynamic> jsonData) {
    return JenisVaksinModel(
      status: jsonData['status'] ?? 0,
      idJenisVaksin: jsonData['idJenisVaksin'] ?? "",
      jenis: jsonData['jenis'] ?? "",
      deskripsi: jsonData['deskripsi'] ?? "",
      message: jsonData['message'] ?? "", // Menambahkan mapping message
    );
  }
}

class JenisVaksinListModel {
  final int? status;
  final List<JenisVaksinModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;

  JenisVaksinListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});

  factory JenisVaksinListModel.fromJson(Map<String, dynamic> jsonData) {
    return JenisVaksinListModel(
        status: jsonData['status'],
        content: jsonData['content'] != null
            ? jsonData['content']
                .map<JenisVaksinModel>((data) => JenisVaksinModel.fromJson(data))
                .toList()
            : [],
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }

  void assignAll(List<JenisVaksinModel> filteredList) {}
}
