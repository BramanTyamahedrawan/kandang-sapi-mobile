import 'package:get/get.dart';

class HijauanController extends GetxController {
  // Variabel yang bisa digunakan di view
  var title = 'Menu Hijauan'.obs;

  // Variabel untuk menampung data hijauan (contoh list sederhana)
  var hijauanList = <String>[].obs;

  // Fungsi untuk menambahkan data hijauan
  void addHijauan(String item) {
    hijauanList.add(item);
  }

  // Fungsi untuk menghapus data hijauan
  void removeHijauan(String item) {
    hijauanList.remove(item);
  }

  // Bisa juga menambahkan fungsi lain untuk logika yang lebih kompleks
}
