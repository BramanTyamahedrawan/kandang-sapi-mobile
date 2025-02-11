import 'dart:async';
import 'dart:convert';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/user_model.dart';
import 'package:crud_flutter_api/app/modules/menu/peternak/controllers/peternak_controller.dart';
import 'package:crud_flutter_api/app/services/auth_api.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AddPeternakController extends GetxController {
  final FetchData fetchdata = FetchData();
  final Map<String, List<Map<String, dynamic>>> _citiesCache = {};
  final Map<String, List<Map<String, dynamic>>> _districtsCache = {};
  final Map<String, List<Map<String, dynamic>>> _villagesCache = {};
  UserModel? userModel;
  PeternakModel? peternakModel;
  RxBool isLoadingProvinces = false.obs;
  RxBool isLoadingCities = false.obs;
  RxBool isLoadingDistricts = false.obs;
  RxBool isLoadingVillages = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isDropdownEnabled = true.obs;
  RxString dropdownError = "".obs;
  RxString selectedGender = ''.obs; // Default value
  Timer? _debounceTimer;

  RxList<Map<String, dynamic>> provinces = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> cities = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> districts = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> villages = <Map<String, dynamic>>[].obs;

  var selectedProvince = Rxn<Map<String, dynamic>>();
  var selectedCity = Rxn<Map<String, dynamic>>();
  var selectedDistrict = Rxn<Map<String, dynamic>>();
  var selectedVillage = Rxn<Map<String, dynamic>>();

  var alamat = "".obs; // Wilayah akan otomatis terisi

  final formattedDate = ''.obs; // Gunakan .obs untuk membuat Rx variabel

  TextEditingController idPeternakC = TextEditingController();
  TextEditingController idISIKHNASC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController nikPeternakC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController emailPeternakC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController dusunC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController tanggalPendaftaranC = TextEditingController();

  @override
  void onClose() {
    idPeternakC.dispose();
    idISIKHNASC.dispose();
    namaPeternakC.dispose();
    nikPeternakC.dispose();
    noTelpC.dispose();
    emailPeternakC.dispose();
    tanggalLahirC.dispose();
    dusunC.dispose();
    lokasiC.dispose();
    tanggalPendaftaranC.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    provinces.value = [];
    cities.value = [];
    districts.value = [];
    villages.value = [];
    fetchProvinces();
    fetchdata.fetchPetugas();
  }

  @override
  void dispose() {
    provinces.clear();
    cities.clear();
    districts.clear();
    villages.clear();
    selectedProvince.value = null;
    selectedCity.value = null;
    selectedDistrict.value = null;
    selectedVillage.value = null;
    super.dispose();
  }

  void resetForm() {
    selectedProvince.value = null;
    selectedCity.value = null;
    selectedDistrict.value = null;
    selectedVillage.value = null;
    cities.clear();
    districts.clear();
    villages.clear();
    dropdownError.value = '';
  }

  void debouncedFetch(Function callback) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      callback();
    });
  }

  void handleProvinceChanged(Map<String, dynamic> value) {
    debouncedFetch(() {
      selectedProvince.value = value;
      selectedCity.value = null;
      selectedDistrict.value = null;
      selectedVillage.value = null;
      fetchCities(value['id']);
    });
  }

  // Memanggil provinsi
  void fetchProvinces() async {
    try {
      isLoadingProvinces.value = true;
      isDropdownEnabled.value = false;

      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json"));

      if (response.statusCode == 200) {
        final List provincesData = json.decode(response.body);
        provinces.value =
            provincesData.map((item) => item as Map<String, dynamic>).toList();
        provinces.assignAll(provinces.toSet().toList());
      } else {
        dropdownError.value = 'Gagal memuat data provinsi';
        Get.snackbar("Error", "Gagal memuat provinsi",
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e",
          backgroundColor: Colors.red);
    } finally {
      isLoadingProvinces.value = false;
      isDropdownEnabled.value = true;
    }
  }

  // Memanggil kabupaten
  void fetchCities(String provinceId) async {
    print(
        "Memuat kabupaten untuk provinsi: ${selectedProvince.value?['name']}");
    if (_citiesCache.containsKey(provinceId)) {
      cities.value = _citiesCache[provinceId]!;
      cities.assignAll(cities.toSet().toList()); // Hapus duplikasi
      return;
    }

    isLoadingCities.value = true;
    try {
      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$provinceId.json"));
      if (response.statusCode == 200) {
        final List citiesData = json.decode(response.body);
        final cityList =
            citiesData.map((item) => item as Map<String, dynamic>).toList();
        cities.value = cityList;
        cities.assignAll(cities.toSet().toList()); // Hapus duplikasi
        _citiesCache[provinceId] = cityList;
      }
    } catch (e) {
      print("Error fetching cities: $e");
    } finally {
      isLoadingCities.value = false;
    }
  }

  // Memanggil kecamatan
  void fetchDistricts(String cityId) async {
    if (_districtsCache.containsKey(cityId)) {
      districts.value = _districtsCache[cityId]!;
      districts.assignAll(districts.toSet().toList()); // Hapus duplikasi
      return;
    }
    isLoadingDistricts.value = true;
    try {
      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$cityId.json"));
      if (response.statusCode == 200) {
        final List districtsData = json.decode(response.body);
        final districtList =
            districtsData.map((item) => item as Map<String, dynamic>).toList();
        districts.value = districtList;
        districts.assignAll(districts.toSet().toList()); // Hapus duplikasi
        _districtsCache[cityId] = districtList;
      }
    } catch (e) {
      print("Error fetching districts: $e");
    } finally {
      isLoadingDistricts.value = false;
    }
  }

  // Memanggil desa
  void fetchVillages(String districtId) async {
    if (_villagesCache.containsKey(districtId)) {
      villages.value = _villagesCache[districtId]!;
      villages.assignAll(villages.toSet().toList()); // Hapus duplikasi
      return;
    }
    isLoadingVillages.value = true;
    try {
      final response = await http.get(Uri.parse(
          "https://www.emsifa.com/api-wilayah-indonesia/api/villages/$districtId.json"));
      if (response.statusCode == 200) {
        final List villagesData = json.decode(response.body);
        final villageList =
            villagesData.map((item) => item as Map<String, dynamic>).toList();
        villages.value = villageList;
        villages.assignAll(villages.toSet().toList()); // Hapus duplikasi
        _villagesCache[districtId] = villageList;
      }
    } catch (e) {
      print("Error fetching districts: $e");
    } finally {
      isLoadingVillages.value = false;
      update(); // Tambahkan update() agar UI diperbarui
    }
  }

  void updateAlamat() {
    if (selectedProvince.value != null &&
        selectedCity.value != null &&
        selectedDistrict.value != null &&
        selectedVillage.value != null) {
      alamat.value =
          "${selectedProvince.value!['name']}, ${selectedCity.value!['name']}, ${selectedDistrict.value!['name']}, ${selectedVillage.value!['name']}";
    } else {
      alamat.value = "";
    }
  }

  Future addUser(BuildContext context) async {
    userModel = await AuthApi().addUserAPI(
      namaPeternakC.text, // name
      nikPeternakC.text, // username
      nikPeternakC.text + '@gmail.com', // email
      nikPeternakC.text, //password
      '3', //role peternak
    );
  }

  Future<void> pilihTanggalLahir(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      tanggalLahirC.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future addPeternak(BuildContext context) async {
    List<TextEditingController> controllers = [
      idISIKHNASC,
      nikPeternakC,
      namaPeternakC,
      noTelpC,
      emailPeternakC,
      tanggalLahirC,
      lokasiC,
      tanggalPendaftaranC
    ];

    if (controllers.any((controller) => controller.text.isEmpty)) {
      showErrorMessage("Semua field harus diisi!");
      return;
    }

    try {
      isLoading.value = true;
      String generatedId = Uuid().v4(); // Generate UUID otomatis

      print("Generated ID: $generatedId");
      print(idISIKHNASC.text);
      print(namaPeternakC.text);
      print(nikPeternakC.text);
      print(noTelpC.text);
      print(emailPeternakC.text);
      print(selectedGender.value);
      print(tanggalLahirC.text);
      print(lokasiC.text);
      print(fetchdata.selectedPetugasId.value);
      print(tanggalPendaftaranC.text);

      List<String> koordinat = lokasiC.text.split(",");
      String latitude = koordinat.isNotEmpty ? koordinat[0] : "";
      String longitude = koordinat.length > 1 ? koordinat[1] : "";

      peternakModel = await PeternakApi().addPeternakAPI(
          generatedId, // UUID sebagai ID Peternak
          idISIKHNASC.text,
          namaPeternakC.text,
          nikPeternakC.text,
          noTelpC.text,
          emailPeternakC.text,
          selectedGender.value,
          tanggalLahirC.text,
          dusunC.text,
          latitude,
          longitude,
          fetchdata.selectedPetugasId.value,
          tanggalPendaftaranC.text);

      if (peternakModel != null && peternakModel!.status == 201) {
        final PeternakController peternakController =
            Get.put(PeternakController());
        peternakController.reInitialize();
        Get.back();
        showSuccessMessage("Peternak Baru berhasil ditambahkan");
      } else {
        showErrorMessage(
            "Gagal menambahkan Peternak dengan status ${peternakModel?.status}");
      }
    } catch (e) {
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
      showErrorMessage("Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void updateFormattedDate(String newDate) {
    formattedDate.value = newDate;
  }

  late DateTime selectedDate = DateTime.now();

  Future<void> tanggalPendaftaran(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalPendaftaranC.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }
}
