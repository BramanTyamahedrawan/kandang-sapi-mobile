import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/modules/menu/kandang/controllers/kandang_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/kandang_api.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class DetailKandangController extends GetxController {
  final box = GetStorage();
  String? get role => box.read('role');
  final FetchData fetchdata = Get.put(FetchData());
  final KandangController kandangController = Get.put(KandangController());
  //TODO: Implement DetailPostController
  final Map<String, dynamic> argsData = Get.arguments;
  KandangModel? kandangModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;
  final formattedDate = ''.obs;
  SharedApi sharedApi = SharedApi();
  RxBool loading = false.obs;
  RxString selectedPeternakIdInEditMode = ''.obs;

  RxString strLatLong =
      'belum mendapatkan lat dan long, silakan tekan tombol'.obs;
  RxString strAlamat = 'mencari lokasi..'.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  Rx<File?> fotoKandang = Rx<File?>(null);

  TextEditingController idKandangC = TextEditingController();
  TextEditingController idPeternakC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController luasC = TextEditingController();
  TextEditingController kapasitasC = TextEditingController();
  TextEditingController nilaiBangunanC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController jenisHewanC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();

  String originalIdKandang = "";
  String originalIdPeternak = "";
  String originalNamaPeternak = "";
  String originalLuas = "";
  String originalKapasitas = "";
  String originalNilaiBangunan = "";
  String originalAlamat = "";
  String originalDesa = "";
  String originalKecamatan = "";
  String originalKabupaten = "";
  String originalProvinsi = "";
  String originalFotoKandang = "";
  String originalLatitude = "";
  String originalLongitude = "";
  String originaljenisHewan = "";

  @override
  onClose() {
    idKandangC.dispose();
    idPeternakC.dispose();
    namaPeternakC.dispose();
    luasC.dispose();
    kapasitasC.dispose();
    nilaiBangunanC.dispose();
    alamatC.dispose();
    desaC.dispose();
    kecamatanC.dispose();
    kabupatenC.dispose();
    provinsiC.dispose();
    jenisHewanC.dispose();
    ever<File?>(fotoKandang, (_) {
      update();
    });
  }

  @override
  void onInit() {
    role;
    super.onInit();
    fetchdata.fetchPeternaks();
    isEditing.value = false;

    idKandangC.text = argsData["idKandang"];
    fetchdata.selectedPeternakId.value = argsData["idPeternak"];
    idPeternakC.text = argsData["idPeternak"];
    namaPeternakC.text = argsData["namaPeternak"];
    luasC.text = argsData["luas"];
    kapasitasC.text = argsData["kapasitas"];
    nilaiBangunanC.text = argsData["nilaiBangunan"];
    alamatC.text = argsData["alamat"];
    desaC.text = argsData["desa"];
    kecamatanC.text = argsData["kecamatan"];
    kabupatenC.text = argsData["kabupaten"];
    provinsiC.text = argsData["provinsi"];
    latitude.value = argsData["latitude"];
    longitude.value = argsData["longitude"];
    jenisHewanC.text = argsData["jenisHewan"];

    // ever(selectedPeternakId, (String? selectedId) {
    //   // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
    //   PeternakModel? selectedPeternak = peternakList.firstWhere(
    //       (peternak) => peternak.idPeternak == selectedId,
    //       orElse: () => PeternakModel());
    //   namaPeternakC.text =
    //       selectedPeternak.namaPeternak ?? argsData["idPeternak"];
    //   update();
    // });

    ever(fetchdata.selectedPeternakId, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PeternakModel? selectedPeternak = fetchdata.peternakList.firstWhere(
          (peternak) => peternak.idPeternak == selectedId,
          orElse: () => PeternakModel());

      fetchdata.selectedPeternakId.value =
          selectedPeternak.idPeternak ?? argsData["idPeternak"];
      update();
    });

    print(argsData["fotoKandang"]);

    originalIdKandang = argsData["idKandang"];
    originalIdPeternak = argsData["idPeternak"];
    originalNamaPeternak = argsData["namaPeternak"];
    originalLuas = argsData["luas"];
    originalKapasitas = argsData["kapasitas"];
    originalNilaiBangunan = argsData["nilaiBangunan"];
    originalAlamat = argsData["alamat"];
    originalDesa = argsData["desa"];
    originalKecamatan = argsData["kecamatan"];
    originalKabupaten = argsData["kabupaten"];
    originalProvinsi = argsData["provinsi"];
    originalFotoKandang = argsData["fotoKandang"];
    originalLatitude = argsData["latitude"];
    originalLongitude = argsData["longitude"];
    originaljenisHewan = argsData["jenisHewan"];
  }

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

  /// Fungsi untuk memilih gambar dari galeri
  Future<void> pickImage(bool fromCamera) async {
    final ImageSource source =
        fromCamera ? ImageSource.camera : ImageSource.gallery;
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Kompresi gambar sebelum menyimpannya
      File compressedImage = await compressImage(imageFile);

      fotoKandang.value = compressedImage;
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

  // // Fungsi untuk memilih gambar dari galeri
  // Future<void> pickImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     fotoHewan.value = File(pickedFile.path);
  //     update(); // Perbarui UI setelah memilih gambar
  //   }
  // }

  // Fungsi untuk menghapus gambar yang sudah dipilih
  void removeImage() {
    fotoKandang.value = null;
    update(); // Perbarui UI setelah menghapus gambar
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
    selectedPeternakIdInEditMode.value = fetchdata.selectedPeternakId.value;
    refresh();
    update();
    update();
  }

  Future<void> tutupEdit() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Batal Edit",
      message: "Apakah anda ingin keluar dari edit ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        Get.back();
        update();
        // Reset data ke yang sebelumnya
        idKandangC.text = originalIdKandang;
        fetchdata.selectedPeternakId.value = originalIdPeternak;
        namaPeternakC.text = originalNamaPeternak;
        luasC.text = originalLuas;
        kapasitasC.text = originalKapasitas;
        nilaiBangunanC.text = originalNilaiBangunan;
        alamatC.text = originalAlamat;
        desaC.text = originalDesa;
        kecamatanC.text = originalKecamatan;
        kabupatenC.text = originalKabupaten;
        provinsiC.text = originalProvinsi;
        fotoKandang.value = null;
        latitude.value = originalLatitude;
        longitude.value = originalLongitude;

        isEditing.value = false;
      },
    );
  }

  Future<void> deleteKandang() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Kandang",
      message: "Apakah anda ingin menghapus data Kandang ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        kandangModel =
            await KandangApi().deleteKandangAPI(argsData["idKandang"]);
        if (kandangModel != null) {
          if (kandangModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Kandang dengan ID: ${idKandangC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Kandang ");
          }
        }
        //kandangController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  Future<void> editKandang() async {
    if (fotoKandang.value == null) {
      showErrorMessage("Anda harus mengunggah foto terbaru");
      return;
    }
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Kandang",
      message: "Apakah anda ingin mengedit data Kandang ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        //print(kandangModel);
        kandangModel = await KandangApi().editKandangApi(
          idKandangC.text,
          fetchdata.selectedPeternakId.value,

          luasC.text,
          kapasitasC.text,
          nilaiBangunanC.text,
          alamatC.text,
          desaC.text,
          kecamatanC.text,
          kabupatenC.text,
          provinsiC.text,
          fotoKandang.value,
          //originalFotoKandang,
          latitude: latitude.value,
          longitude: longitude.value,
        );

        if (kandangModel != null && kandangModel!.status == 201) {
          await updateAlamatInfo();
          isEditing.value = false;
          showSuccessMessage(
              "Berhasil mengedit Kandang dengan ID: ${idKandangC.text}");
        } else {
          showErrorMessage("Gagal mengedit Data Kandang ");
        }

        kandangController.reInitialize();

        Get.back();
        Get.back();
        update();
      },
    );
  }

  // void updateFormattedDate(String newDate) {
  //   formattedDate.value = newDate;
  // }

  // late DateTime selectedDate = DateTime.now();

  // Future<void> tanggalPendaftaran(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );

  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //     tanggalPendaftaranC.text = DateFormat('dd/MM/yyyy').format(picked);
  //   }
  // }
}
