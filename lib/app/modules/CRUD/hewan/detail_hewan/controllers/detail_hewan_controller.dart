import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/modules/menu/hewan/controllers/hewan_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/utils/api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailHewanController extends GetxController {
  final box = GetStorage();
  String? get role => box.read('role');
  final FetchData fetchdata = FetchData();
  final HewanController hewanController = Get.put(HewanController());

  final Map<String, dynamic> argsData = Get.arguments;
  HewanModel? hewanModel;
  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  final formattedDate = ''.obs;
  final formattedDate1 = ''.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxString selectedGender = ''.obs;
  SharedApi sharedApi = SharedApi();
  RxString selectedPeternakIdInEditMode = ''.obs;
  RxString selectedKandangIdInEditMode = ''.obs;
  RxString selectedPetugasIdInEditMode = ''.obs;
  RxString selectedIdJenisHewanInEditMode = ''.obs;
  RxString selectedIdRumpunHewanInEditMode = ''.obs;
  RxString selectedIdTujuanPemeliharaanInEditMode = ''.obs;

  List<String> genders = ["Jantan", "Betina"];

  // RxString strLatLong =
  //     'belum mendapatkan lat dan long, silakan tekan tombol'.obs;
  // RxString strAlamat = 'mencari lokasi..'.obs;
  RxBool loading = false.obs;
  // RxString latitude = ''.obs;
  // RxString longitude = ''.obs;
  Rx<File?> fotoHewan = Rx<File?>(null);

  TextEditingController idHewanC = TextEditingController();
  TextEditingController kodeEartagNasionalC = TextEditingController();
  TextEditingController noKartuTernakC = TextEditingController();
  TextEditingController idIsikhnasHewanC = TextEditingController();
  TextEditingController umurC = TextEditingController();
  TextEditingController tempatLahirC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController identifikasiHewanC = TextEditingController();
  TextEditingController tanggalTerdaftarC = TextEditingController();

  String originalEartag = "";
  String originalNoKartuTernak = "";
  String originalIdIsikhnasTernak = "";
  String originalIdJenisHewan = "";
  String originalIdRumpunHewan = "";
  String originalIdTujuanPemeliharaan = "";
  String originalIdKandang = "";
  String originalIdPetugas = "";
  String originalIdPeternak = "";
  String originalTempatLahir = "";
  String originalTanggalLahir = "";
  String originalSex = "";
  String originalUmur = "";
  String originalIdentifikasi = "";
  String originalTanggal = "";
  String originalfotoHewan = "";

  @override
  onClose() {
    kodeEartagNasionalC.dispose();
    noKartuTernakC.dispose(); //
    idIsikhnasHewanC.dispose();
    umurC.dispose();
    tempatLahirC.dispose();
    tanggalLahirC.dispose();
    identifikasiHewanC.dispose();
    tanggalTerdaftarC.dispose();
    ever<File?>(fotoHewan, (_) {
      update();
    });
    //fotoHewanC.dispose();
    //fotoHewanC;
  }

  @override
  void onInit() {
    super.onInit();

    // Fetch Data
    fetchdata.fetchPeternaks();
    fetchdata.fetchPetugas();
    fetchdata.fetchKandangs();
    fetchdata.fetchJenisHewan();
    fetchdata.fetchRumpunHewan();
    fetchdata.fetchTujuanPemeliharaan();

    fetchdata.selectedPeternakId.listen((peternakId) {
      fetchdata.filterHewanByPeternak(peternakId);
      fetchdata.filterKandangByPeternak(peternakId);
    });

    role;
    isEditing.value = false;

    final idPeternak = argsData["id_peternak_hewan_detail"] ?? '';
    final idKandang = argsData["id_kandang_hewan_detail"] ?? '';
    final idJenisHewan = argsData["id_jenishewan_detail"] ?? '';
    final idRumpunHewan = argsData["id_rumpun_detail"] ?? '';
    final idTujuanPemeliharaan = argsData["id_tujuanpemeliharaan_detail"] ?? '';
    final idPetugas = argsData["petugas_terdaftar_hewan_detail"] ?? '';

    idHewanC.text = argsData["idHewan"] ?? '';
    kodeEartagNasionalC.text = argsData["eartag_hewan_detail"] ?? '';
    noKartuTernakC.text = argsData["kartu_hewan_detail"] ?? '';
    idIsikhnasHewanC.text = argsData["id_isikhnas_detail"] ?? '';
    genders.val(argsData["kelamin_hewan_detail"] ?? '');
    umurC.text = argsData["umur_hewan_detail"] ?? '';
    tempatLahirC.text = argsData["tempat_lahir_detail"] ?? '';
    tanggalLahirC.text = argsData["tanggal_lahir_detail"] ?? '';
    identifikasiHewanC.text = argsData["identifikasi_hewan_detail"] ?? '';
    tanggalTerdaftarC.text = argsData["tanggal_terdaftar_hewan_detail"] ?? '';

    originalIdPeternak = idPeternak;
    originalIdKandang = idKandang;
    originalIdJenisHewan = idJenisHewan;
    originalIdRumpunHewan = idRumpunHewan;
    originalIdTujuanPemeliharaan = idTujuanPemeliharaan;
    originalIdPetugas = idPetugas;
    originalSex = argsData["kelamin_hewan_detail"] ?? '';

    // Validasi id Peternak
    fetchdata.fetchPeternaks().then((_) {
      if (idPeternak.isNotEmpty) {
        bool isValid = fetchdata.peternakList
            .any((peternaks) => peternaks.idPeternak == idPeternak);
        if (isValid) {
          fetchdata.selectedPeternakId.value = idPeternak;
        } else {
          print("Id Peternak dari args data tidak ditemukan");
        }
      } else {
        print("Id Peternak kosong");
      }
    });

    // Validasi id Kandang
    fetchdata.fetchKandangs().then((_) {
      if (idKandang.isNotEmpty) {
        bool isValid = fetchdata.kandangList
            .any((kandangs) => kandangs.idKandang == idKandang);
        if (isValid) {
          fetchdata.selectedKandangId.value = idKandang;
        } else {
          print("Id Kandang dari args data tidak ditemukan");
        }
      } else {
        print("Id Kandang kosong");
      }
    });

    // Validasi id Jenis Hewan
    fetchdata.fetchJenisHewan().then((_) {
      if (idJenisHewan.isNotEmpty) {
        bool isValid = fetchdata.jenisHewanList
            .any((jenisHewans) => jenisHewans.idJenisHewan == idJenisHewan);
        if (isValid) {
          fetchdata.selectedIdJenisHewan.value = idJenisHewan;
        } else {
          print("Id Jenis Hewan dari args data tidak ditemukan");
        }
      } else {
        print("Id Jenis Hewan kosong");
      }
    });

    // Validasi id Rumpun Hewan
    fetchdata.fetchRumpunHewan().then((_) {
      if (idRumpunHewan.isNotEmpty) {
        bool isValid = fetchdata.rumpunHewanList
            .any((rumpunHewans) => rumpunHewans.idRumpunHewan == idRumpunHewan);
        if (isValid) {
          fetchdata.selectedIdRumpunHewan.value = idRumpunHewan;
        } else {
          print("Id Rumpun Hewan dari args data tidak ditemukan");
        }
      } else {
        print("Id Rumpun Hewan kosong");
      }
    });

    // Validasi id Tujuan Pemeliharaan
    fetchdata.fetchTujuanPemeliharaan().then((_) {
      if (idTujuanPemeliharaan.isNotEmpty) {
        bool isValid = fetchdata.tujuanPemeliharaanList.any(
            (tujuanPemeliharaans) =>
                tujuanPemeliharaans.idTujuanPemeliharaan ==
                idTujuanPemeliharaan);
        if (isValid) {
          fetchdata.selectedIdTujuanPemeliharaan.value = idTujuanPemeliharaan;
        } else {
          print("Id Tujuan Pemeliharaan dari args data tidak ditemukan");
        }
      } else {
        print("Id Tujuan Pemeliharaan kosong");
      }
    });

    // Validasi id Petugas
    fetchdata.fetchPetugas().then((_) {
      if (idPetugas.isNotEmpty) {
        bool isValid = fetchdata.petugasList
            .any((petugas) => petugas.petugasId == idPetugas);
        if (isValid) {
          fetchdata.selectedPetugasId.value = idPetugas;
        } else {
          print("Id Petugas terdaftar dari args data tidak ditemukan");
        }
      } else {
        print("Id Petugas terdaftar kosong");
      }
    });

    update();
  }

//   Future<Position> getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     //location service not enabled, don't continue
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location service Not Enabled');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permission denied');
//       }
//     }

//     //permission denied forever
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//         'Location permission denied forever, we cannot access',
//       );
//     }
//     //continue accessing the position of device
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   }

//   //getAddress
//   Future<void> getAddressFromLongLat(Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);

//     Placemark place = placemarks[0];

//     latitude.value = position.latitude.toString();
//     longitude.value = position.longitude.toString();

//     // String subLocality = place.subLocality ?? '';
//     // String locality = place.locality ?? '';
//     // String administrativeArea = place.administrativeArea ?? '';

//     // String desiredAddress = '$subLocality $locality $administrativeArea';

//     // strAlamat.value = desiredAddress.trim();

//     strAlamat.value =
//         '${place.subAdministrativeArea}, ${place.subLocality}, ${place.locality}, '
//         '${place.postalCode}, ${place.country}, ${place.administrativeArea}';
//   }

//   // Fungsi untuk mendapatkan alamat dari geolocation dan mengupdate nilai provinsi, kabupaten, kecamatan, dan desa
//   Future<void> updateAlamatInfo() async {
//     try {
//       isLoading.value = true;

//       // Mendapatkan posisi geolokasi
//       Position position = await getGeoLocationPosition();

//       // Mendapatkan alamat dari geolokasi
//       await getAddressFromLongLat(position);

//       // Mengupdate nilai provinsi, kabupaten, kecamatan, dan desa berdasarkan alamat
//       provinsiC.text = getAlamatInfo(5); //benar 5
//       kabupatenC.text = getAlamatInfo(0); //benar 0
//       kecamatanC.text = getAlamatInfo(2); //benar 2
//       desaC.text = getAlamatInfo(1); //benar 1
//     } catch (e) {
//       print('Error updating alamat info: $e');
//       showErrorMessage("Error updating alamat info: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

// // Fungsi untuk mendapatkan informasi alamat berdasarkan index
//   String getAlamatInfo(int index) {
//     List<String> alamatInfo = strAlamat.value.split(', ');
//     if (index < alamatInfo.length) {
//       return alamatInfo[index];
//     } else {
//       return '';
//     }
//   }

  /// Fungsi untuk memilih gambar dari galeri
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
        kodeEartagNasionalC.text = originalEartag;
        noKartuTernakC.text = originalNoKartuTernak;
        idIsikhnasHewanC.text = originalIdIsikhnasTernak;
        tempatLahirC.text = originalTempatLahir;
        tanggalLahirC.text = originalTanggalLahir;
        selectedGender.value = originalSex;
        umurC.text = originalUmur;
        identifikasiHewanC.text = originalIdentifikasi;
        tanggalTerdaftarC.text = originalTanggal;
        selectedIdJenisHewanInEditMode.value = originalIdJenisHewan;
        selectedIdRumpunHewanInEditMode.value = originalIdRumpunHewan;
        selectedIdTujuanPemeliharaanInEditMode.value =
            originalIdTujuanPemeliharaan;
        selectedKandangIdInEditMode.value = originalIdKandang;
        selectedPeternakIdInEditMode.value = originalIdPeternak;
        selectedPetugasIdInEditMode.value = originalIdPetugas;
        fotoHewan.value = null;
        isEditing.value = false;
      },
    );
  }

  Future<void> deleteHewan() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Hewan",
      message: "Apakah anda ingin menghapus data Hewan ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        hewanModel =
            await HewanApi().deleteHewanApi(argsData["eartag_hewan_detail"]);
        if (hewanModel?.status == 200) {
          showSuccessMessage(
              "Berhasil Hapus Data Hewan dengan ID: ${kodeEartagNasionalC.text}");
        } else {
          showErrorMessage("Gagal Hapus Data Hewan");
        }
        final HewanController hewanController = Get.put(HewanController());
        hewanController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  Future<void> editHewan() async {
    if (fotoHewan.value == null) {
      showErrorMessage("Anda harus mengunggah foto terbaru");
      return;
    }
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Hewan",
      message: "Apakah anda ingin mengedit data ini data Petugas ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        if (fotoHewan.value != null) {
          // Jika ada foto baru, gunakan foto baru
          fotoHewan.value = fotoHewan.value;
        } else {
          // Jika tidak ada perubahan pada foto, gunakan foto lama
          fotoHewan.value = File(originalfotoHewan);
        }
        hewanModel = await HewanApi().editHewanApi(
            idHewanC.text,
            kodeEartagNasionalC.text,
            noKartuTernakC.text,
            idIsikhnasHewanC.text,
            fetchdata.selectedIdJenisHewan.value,
            fetchdata.selectedIdRumpunHewan.value,
            fetchdata.selectedIdTujuanPemeliharaan.value,
            fetchdata.selectedPeternakId.value,
            fetchdata.selectedKandangId.value,
            selectedGender.value,
            tempatLahirC.text,
            tanggalLahirC.text,
            fetchdata.selectedPetugasId.value,
            tanggalTerdaftarC.text,
            fotoHewan.value);

        if (hewanModel != null && hewanModel!.status == 201) {
          // Jika tagging berhasil, update data dan reset isEditin
          isEditing.value = false;
          showSuccessMessage(
              "Berhasil mengedit Hewan dengan ID: ${kodeEartagNasionalC.text}");
        } else {
          // Jika tagging gagal, tidak perlu merubah data dan status isEditing
          showErrorMessage("Gagal mengedit Data Hewan ");
        }

        // Tetap reinitialize jika berhasil atau tidak
        hewanController.reInitialize();

        Get.back();
        Get.back();
        update();
      },
    );
  }
}
