class TujuanPemeliharaanModel {
  final String? idTujuanPemeliharaan;
  final String? tujuanPemeliharaan;
  final String? deskripsi;
  final int? status;
  final String? message;

  TujuanPemeliharaanModel(
      {this.idTujuanPemeliharaan,
      this.tujuanPemeliharaan,
      this.deskripsi,
      this.status,
      this.message});

  factory TujuanPemeliharaanModel.fromJson(Map<String, dynamic> jsonData) {
    return TujuanPemeliharaanModel(
      status: jsonData['status'] ?? 0,
      idTujuanPemeliharaan: jsonData['idTujuanPemeliharaan'] ?? "",
      tujuanPemeliharaan: jsonData['tujuanPemeliharaan'] ?? "",
      deskripsi: jsonData['deskripsi'] ?? "",
      message: jsonData['message'] ?? "",
    );
  }
}

class TujuanPemeliharaanListModel {
  final int? status;
  final List<TujuanPemeliharaanModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;

  TujuanPemeliharaanListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});

  factory TujuanPemeliharaanListModel.fromJson(Map<String, dynamic> jsonData) {
    return TujuanPemeliharaanListModel(
        status: jsonData['status'],
        content: jsonData['content'] != null
            ? jsonData['content']
                .map<TujuanPemeliharaanModel>(
                    (data) => TujuanPemeliharaanModel.fromJson(data))
                .toList()
            : [],
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }

  void assignAll(List<TujuanPemeliharaanModel> filteredList) {}
}
