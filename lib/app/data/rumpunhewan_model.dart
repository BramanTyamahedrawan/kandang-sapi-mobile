class RumpunHewanModel {
  final String? idRumpunHewan;
  final String? rumpun;
  final String? deskripsi;
  final int? status;
  final String? message;

  RumpunHewanModel(
      {this.idRumpunHewan,
      this.rumpun,
      this.deskripsi,
      this.status,
      this.message});

  factory RumpunHewanModel.fromJson(Map<String, dynamic> jsonData) {
    return RumpunHewanModel(
      status: jsonData['status'] ?? 0,
      idRumpunHewan: jsonData['idRumpunHewan'] ?? "",
      rumpun: jsonData['rumpun'] ?? "",
      deskripsi: jsonData['deskripsi'] ?? "",
      message: jsonData['message'] ?? "",
    );
  }
}

class RumpunHewanListModel {
  final int? status;
  final List<RumpunHewanModel>? content;
  final int? page;
  final int? size;
  final int? totalElements;
  final int? totalPages;

  RumpunHewanListModel(
      {this.status,
      this.content,
      this.page,
      this.size,
      this.totalElements,
      this.totalPages});

  factory RumpunHewanListModel.fromJson(Map<String, dynamic> jsonData) {
    return RumpunHewanListModel(
        status: jsonData['status'],
        content: jsonData['content'] != null
            ? jsonData['content']
                .map<RumpunHewanModel>(
                    (data) => RumpunHewanModel.fromJson(data))
                .toList()
            : [],
        page: jsonData['page'],
        size: jsonData['size'],
        totalElements: jsonData['totalElements'],
        totalPages: jsonData['totalPages']);
  }

  void assignAll(List<RumpunHewanModel> filteredList) {}
}
