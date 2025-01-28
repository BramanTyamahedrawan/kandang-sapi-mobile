import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HijauanApi {
  final String baseUrl = 'https://api.example.com'; // Ganti dengan URL API Anda

  // Fungsi untuk mendapatkan semua hijauan
  Future<List<dynamic>> getAllHijauan() async {
    final url = Uri.parse('$baseUrl/hijauan');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load hijauan');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Fungsi untuk menambahkan hijauan baru
  Future<Map<String, dynamic>> addHijauan({
    required String jenisHijauan,
    required String deskripsi,
    required String tanggalPanen,
    File? fotoHijauan, // Optional jika ingin mengupload gambar
  }) async {
    final url = Uri.parse('$baseUrl/hijauan');
    try {
      var request = http.MultipartRequest('POST', url);

      // Tambahkan data form
      request.fields['jenisHijauan'] = jenisHijauan;
      request.fields['deskripsi'] = deskripsi;
      request.fields['tanggalPanen'] = tanggalPanen;

      // Tambahkan file jika ada
      if (fotoHijauan != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'fotoHijauan',
          fotoHijauan.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await http.Response.fromStream(response);
        return json.decode(responseData.body);
      } else {
        throw Exception('Failed to add hijauan');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Fungsi untuk mengedit hijauan yang sudah ada
  Future<Map<String, dynamic>> editHijauan({
    required String idHijauan,
    required String jenisHijauan,
    required String deskripsi,
    required String tanggalPanen,
    File? fotoHijauan, // Optional jika ingin mengubah gambar
  }) async {
    final url = Uri.parse('$baseUrl/hijauan/$idHijauan');
    try {
      var request = http.MultipartRequest('PUT', url);

      // Tambahkan data form
      request.fields['jenisHijauan'] = jenisHijauan;
      request.fields['deskripsi'] = deskripsi;
      request.fields['tanggalPanen'] = tanggalPanen;

      // Tambahkan file jika ada
      if (fotoHijauan != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'fotoHijauan',
          fotoHijauan.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await http.Response.fromStream(response);
        return json.decode(responseData.body);
      } else {
        throw Exception('Failed to edit hijauan');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Fungsi untuk menghapus hijauan
  Future<void> deleteHijauan(String idHijauan) async {
    final url = Uri.parse('$baseUrl/hijauan/$idHijauan');
    try {
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception('Failed to delete hijauan');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
