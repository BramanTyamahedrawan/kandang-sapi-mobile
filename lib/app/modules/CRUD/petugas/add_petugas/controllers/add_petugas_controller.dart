import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/data/user_model.dart';
import 'package:crud_flutter_api/app/services/auth_api.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../menu/petugas/controllers/petugas_controller.dart';

class AddPetugasController extends GetxController {
  PetugasModel? petugasModel;
  UserModel? userModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  TextEditingController petugasIdC = TextEditingController();
  TextEditingController nikC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController notlpC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  // List untuk menyimpan data provinsi dari API
  RxList<Map<String, dynamic>> provinces = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> cities = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> districts = <Map<String, dynamic>>[].obs;

  Rx<Map<String, dynamic>?> selectedProvince = Rx<Map<String, dynamic>?>(null);
  Rx<Map<String, dynamic>?> selectedCity = Rx<Map<String, dynamic>?>(null);
  Rx<Map<String, dynamic>?> selectedDistrict = Rx<Map<String, dynamic>?>(null);

  var wilayah = "".obs; // Wilayah akan otomatis terisi
  var selectedJob = Rxn<String>();

  final List<String> jobOptions = ["Pendataan", "Vaksinasi"];

  @override
  onClose() {
    petugasIdC.dispose();
    nikC.dispose();
    namaC.dispose();
    notlpC.dispose();
    emailC.dispose();
    super.onClose();
  }

  // Memanggil provinsi
  void fetchProvinces() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));
      if (response.statusCode == 200) {
        final List provincesData = json.decode(response.body);
        provinces.value =
            provincesData.map((item) => item as Map<String, dynamic>).toList();
        print("Provinces loaded: ${provinces.length}"); // Debugging
      } else {
        print("Failed to load provinces: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching provinces: $e");
    } finally {
      isLoading.value = false;
      update(); // Tambahkan update() agar UI diperbarui
    }
  }

  // Memanggil kabupaten
  void fetchCities(String provinceId) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$provinceId.json"));
      if (response.statusCode == 200) {
        final List citiesData = json.decode(response.body);
        cities.value =
            citiesData.map((item) => item as Map<String, dynamic>).toList();
        print("Cities loaded: ${cities.length}"); // Debugging
      } else {
        print("Failed to load cities: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching cities: $e");
    } finally {
      isLoading.value = false;
      update(); // Tambahkan update() agar UI diperbarui
    }
  }

  // Memanggil kecamatan
  void fetchDistricts(String cityId) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$cityId.json"));
      if (response.statusCode == 200) {
        final List districtsData = json.decode(response.body);
        districts.value =
            districtsData.map((item) => item as Map<String, dynamic>).toList();
        print("Districts loaded: ${districts.length}"); // Debugging
      } else {
        print("Failed to load districts: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching districts: $e");
    } finally {
      isLoading.value = false;
      update(); // Tambahkan update() agar UI diperbarui
    }
  }

  void updateWilayah() {
    if (selectedProvince.value != null &&
        selectedCity.value != null &&
        selectedDistrict.value != null) {
      wilayah.value =
          "${selectedProvince.value!['name']}, ${selectedCity.value!['name']}, ${selectedDistrict.value!['name']}";
    } else {
      wilayah.value = "";
    }
  }

  Future addUser(BuildContext context) async {
    userModel = await AuthApi().addUserAPI(
      petugasIdC.text, // id petugas
      namaC.text, // name
      nikC.text, // username
      emailC.text, // email
      nikC.text, //password
    );
  }

  Future addPetugas(BuildContext context) async {
    try {
      isLoading.value = true;

      if (namaC.text.isEmpty) {
        throw "Nama tidak boleh kosong.";
      }

      petugasModel = await PetugasApi().addPetugasApi(
          petugasIdC.text, nikC.text, namaC.text, notlpC.text, emailC.text);

      if (petugasModel != null) {
        if (petugasModel?.status == 201) {
          final PetugasController petugasController =
              Get.put(PetugasController());
          petugasController.reInitialize();
          Get.back();
          showSuccessMessage("Petugas Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan petugas dengan status ${petugasModel?.status}");
        }
      }
    } catch (e) {
      // Tangani error di sini
      showCupertinoDialog(
        context: context, // Gunakan context yang diberikan sebagai parameter.
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Kesalahan"),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
