import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/modules/menu/hewan/controllers/hewan_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddHewanController extends GetxController {
  final FetchData fetchdata = FetchData();

  HewanModel? hewanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs;
  final formattedDate1 = ''.obs;
  RxString alamat = ''.obs;
  RxString selectedGender = 'Jantan'.obs;
  RxString selectedSpesies = 'Sapi'.obs;
  Rx<File?> fotoHewan = Rx<File?>(null);

  List<String> genders = ["Jantan", "Betina"];
  List<String> spesies = [
    "Banteng",
    "Domba",
    "Kambing",
    "Sapi",
    "Sapi Brahman",
    "Sapi Brangus",
    "Sapi Limosin",
    "Sapi fh",
    "Sapi Perah",
    "Sapi PO",
    "Sapi Simental"
  ];

  RxString strLatLong =
      'belum mendapatkan lat dan long, silakan tekan tombol'.obs;
  RxString strAlamat = 'mencari lokasi..'.obs;
  RxBool loading = false.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  TextEditingController kodeEartagNasionalC = TextEditingController();
  TextEditingController noKartuTernakC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController umurC = TextEditingController();
  TextEditingController identifikasiHewanC = TextEditingController();
  TextEditingController tanggalTerdaftarC = TextEditingController();

  @override
  onClose() {
    kodeEartagNasionalC.dispose();
    noKartuTernakC.dispose();
    provinsiC.dispose();
    kabupatenC.dispose();
    kecamatanC.dispose();
    desaC.dispose();
    umurC.dispose();
    identifikasiHewanC.dispose();
    tanggalTerdaftarC.dispose();
    ever<File?>(fotoHewan, (_) {
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPeternaks();
    fetchdata.fetchPetugas();
    fetchdata.fetchKandangs();

    fetchdata.selectedPeternakId.listen((peternakId) {
      fetchdata.filterHewanByPeternak(peternakId);
      fetchdata.filterKandangByPeternak(peternakId);
    });
  }

//GET LOCATION
  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);

    Placemark place = placemarks[0];

    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();

    strAlamat.value =
        '${place.subAdministrativeArea}, ${place.subLocality}, ${place.locality}, '
        '${place.postalCode}, ${place.country}, ${place.administrativeArea}';
  }

  // Fungsi untuk mendapatkan alamat dari geolocation dan mengupdate nilai provinsi, kabupaten, kecamatan, dan desa
  Future<void> updateAlamatInfo() async {
    try {
      isLoading.value = true;

      // Mendapatkan posisi geolokasi
      Position position = await getGeoLocationPosition();

      // Mendapatkan alamat dari geolokasi
      await getAddressFromLongLat(position);

      // Mengupdate nilai provinsi, kabupaten, kecamatan, dan desa berdasarkan alamat
      provinsiC.text = getAlamatInfo(5); //benar 5
      kabupatenC.text = getAlamatInfo(0); //benar 0
      kecamatanC.text = getAlamatInfo(2); //benar 2
      desaC.text = getAlamatInfo(1); //benar 1
    } catch (e) {
      print('Error updating alamat info: $e');
      showErrorMessage("Error updating alamat info: $e");
    } finally {
      isLoading.value = false;
    }
  }

// Fungsi untuk mendapatkan informasi alamat berdasarkan index
  String getAlamatInfo(int index) {
    List<String> alamatInfo = strAlamat.value.split(', ');
    if (index < alamatInfo.length) {
      return alamatInfo[index];
    } else {
      return '';
    }
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> pickImage(bool fromCamera) async {
    final ImageSource source =
        fromCamera ? ImageSource.camera : ImageSource.gallery;
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Kompresi gambar sebelum menyimpannya
      File compressedImage = await compressImage(imageFile);

      fotoHewan.value = compressedImage;
      update(); // Perbarui UI setelah memilih gambar
    }
  }

  Future<File> compressImage(File imageFile) async {
    // Kompresi gambar dengan ukuran tertentu (misalnya, kualitas 85)
    Uint8List? imageBytes = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 20, // Sesuaikan dengan kebutuhan kamu
    );

    // Simpan gambar yang telah dikompresi
    File compressedImageFile = File('${imageFile.path}_compressed.jpg');
    await compressedImageFile.writeAsBytes(imageBytes!);

    return compressedImageFile;
  }

  // Fungsi untuk menghapus gambar yang sudah dipilih
  void removeImage() {
    fotoHewan.value = null;
    update(); // Perbarui UI setelah menghapus gambar
  }

  Future addHewan(BuildContext context) async {
    try {
      isLoading.value = true;

      if (kodeEartagNasionalC.text.isEmpty) {
        throw "Kode Eartag tidak boleh kosong.";
      }

      if (fetchdata.selectedPeternakId.value.isEmpty) {
        throw "Pilih Peternak terlebih dahulu.";
      }

      if (fetchdata.selectedPetugasId.value.isEmpty) {
        throw "Pilih Petugas terlebih dahulu.";
      }

      File? fotoHewanFile = fotoHewan.value;

      if (fotoHewanFile == null) {
        throw "Pilih gambar hewan terlebih dahulu.";
      }

      hewanModel = await HewanApi().addHewanAPI(
        kodeEartagNasionalC.text,
        noKartuTernakC.text,
        provinsiC.text,
        kabupatenC.text,
        kecamatanC.text,
        desaC.text,
        alamat.value = strAlamat.value,
        fetchdata.selectedPeternakId.value,
        fetchdata.selectedKandangId.value,
        selectedSpesies.value,
        selectedGender.value,
        umurC.text,
        identifikasiHewanC.text,
        fetchdata.selectedPetugasId.value,
        tanggalTerdaftarC.text,
        fotoHewanFile,
        latitude: latitude.value,
        longitude: longitude.value,
      );
      await updateAlamatInfo();

      if (hewanModel != null) {
        if (hewanModel?.status == 201) {
          final HewanController hewanController = Get.put(HewanController());
          hewanController.reInitialize();
          Get.back();
          showSuccessMessage("Data Hewan Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Hewan dengan status ${hewanModel?.status}");
        }
      }
    } catch (e) {
      showCupertinoDialog(
        context: context,
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

  void updateFormattedDate(String newDate) {
    formattedDate.value = newDate;
  }

  void updateFormattedDate1(String newDate) {
    formattedDate1.value = newDate;
  }

  late DateTime selectedDate = DateTime.now();
  late DateTime selectedDate1 = DateTime.now();

  Future<void> tanggalTerdaftar(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalTerdaftarC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> tanggalLahir(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate1) {
      selectedDate1 = picked;
      umurC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
