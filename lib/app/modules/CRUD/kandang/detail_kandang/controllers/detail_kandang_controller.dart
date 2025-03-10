import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
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
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:url_launcher/url_launcher.dart';

class DetailKandangController extends GetxController {
  final box = GetStorage();
  String? get role => box.read('role');
  final FetchData fetchdata = Get.put(FetchData());
  final KandangController kandangController = Get.put(KandangController());

  final Map<String, dynamic> argsData = Get.arguments;
  KandangModel? kandangModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;
  final formattedDate = ''.obs;
  SharedApi sharedApi = SharedApi();
  RxBool loading = false.obs;
  RxString selectedPeternakIdInEditMode = ''.obs;
  RxString selectedJenisHewanIdInEditMode = ''.obs;

  RxString strLatLong =
      'belum mendapatkan lat dan long, silakan tekan tombol'.obs;
  RxString strAlamat = 'mencari lokasi..'.obs;
  RxString selcetedProvinsi = ''.obs;
  RxString selcetedKabupaten = ''.obs;
  RxString selcetedKecamatan = ''.obs;
  RxString selcetedDesa = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString selectSpecies = ''.obs;
  gmaps.LatLng? selectedLocation;
  Rx<gmaps.Marker> marker = gmaps.Marker(
    markerId: const gmaps.MarkerId("selected-location"),
    position: gmaps.LatLng(-6.2088, 106.8456), // Default Jakarta
  ).obs;
  RxBool manualAlamatEdited =
      false.obs; // Menandai apakah user sudah edit manual
  RxString alamatLengkap = ''.obs;
  RxString provinsi = "".obs;
  RxString kabupaten = "".obs;
  RxString kecamatan = "".obs;
  RxString desa = "".obs;

  Rx<File?> fotoKandang = Rx<File?>(null);

  TextEditingController idKandangC = TextEditingController();
  TextEditingController idPeternakC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController namaKandangC = TextEditingController();
  TextEditingController jenisKandangC = TextEditingController();
  TextEditingController luasC = TextEditingController();
  TextEditingController kapasitasC = TextEditingController();
  TextEditingController nilaiBangunanC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController idJenisHewanC = TextEditingController();
  TextEditingController jenisC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();
  TextEditingController latitudeC = TextEditingController();
  TextEditingController longitudeC = TextEditingController();

  String originalIdKandang = "";
  String originalIdPeternak = "";
  String originalNamaPeternak = "";
  String originalLuas = "";
  String originalJenisKandang = "";
  String originalNamaKandang = "";
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
  String originalIdJenisHewan = "";
  String originaljenis = "";
  String originalLatitudeC = "";
  String originalLongitudeC = "";

  @override
  onClose() {
    idKandangC.dispose();
    idPeternakC.dispose();
    namaPeternakC.dispose();
    namaKandangC.dispose();
    jenisKandangC.dispose();
    luasC.dispose();
    kapasitasC.dispose();
    nilaiBangunanC.dispose();
    alamatC.dispose();
    desaC.dispose();
    kecamatanC.dispose();
    kabupatenC.dispose();
    provinsiC.dispose();
    idJenisHewanC.dispose();
    jenisC.dispose();
    latitudeC.dispose();
    longitudeC.dispose();
    ever<File?>(fotoKandang, (_) {
      update();
    });
  }

  @override
  void onInit() {
    role;
    super.onInit();

    fetchdata.fetchPeternaks();
    fetchdata.fetchJenisHewan();

    isEditing.value = false;

    if (Get.arguments != null) {
      fetchdata.selectedIdJenisHewan.value = argsData["idJenisHewan"] ?? "";
    }

    idKandangC.text = argsData["idKandang"];
    fetchdata.selectedPeternakId.value = argsData["idPeternak"] ?? "";
    idPeternakC.text = argsData["idPeternak"] ?? "";
    namaPeternakC.text = argsData["namaPeternak"] ?? "";
    namaKandangC.text = argsData["namaKandang"] ?? "";
    jenisKandangC.text = argsData["jenisKandang"] ?? "";
    jenisC.text = argsData["jenis"] ?? "";
    luasC.text = argsData["luas"] ?? "";
    kapasitasC.text = argsData["kapasitas"] ?? "";
    nilaiBangunanC.text = argsData["nilaiBangunan"] ?? "";
    alamatC.text = argsData["alamat"] ?? "";
    desaC.text = argsData["desa"] ?? "";
    kecamatanC.text = argsData["kecamatan"] ?? "";
    kabupatenC.text = argsData["kabupaten"] ?? "";
    provinsiC.text = argsData["provinsi"] ?? "";
    latitudeC.text = argsData["latitude"] ?? "";
    longitudeC.text = argsData["longitude"] ?? "";

    ever(fetchdata.selectedPeternakId, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PeternakModel? selectedPeternak = fetchdata.peternakList.firstWhere(
          (peternak) => peternak.idPeternak == selectedId,
          orElse: () => PeternakModel());

      fetchdata.selectedPeternakId.value =
          selectedPeternak.idPeternak ?? argsData["idPeternak"];
      update();
    });

    ever(fetchdata.selectedIdJenisHewan, (String? selectedId) {
      if (selectedId != null) {
        // Tambahkan null check
        JenisHewanModel? selectedJenisHewan =
            fetchdata.jenisHewanList.firstWhere(
          (jenisHewan) => jenisHewan.idJenisHewan == selectedId,
          orElse: () => JenisHewanModel(),
        );

        fetchdata.selectedIdJenisHewan.value =
            selectedJenisHewan.idJenisHewan ?? argsData["idJenisHewan"] ?? "";
      }
      update();
    });

    print("✅ ID Jenis Hewan Terpilih: ${fetchdata.selectedIdJenisHewan.value}");

    print(argsData["fotoKandang"]);

    originalIdKandang = argsData["idKandang"];
    originalIdPeternak = argsData["idPeternak"];
    originalNamaPeternak = argsData["namaPeternak"];
    originalJenisKandang = argsData["jenisKandang"];
    originalNamaKandang = argsData["namaKandang"];
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
    originalLatitudeC = argsData["latitude"];
    originalLongitudeC = argsData["longitude"];
  }

  Future<void> getGeoLocationPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied forever');
    }

    loading.value = true;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
    strLatLong.value =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    selectedLocation = gmaps.LatLng(position.latitude, position.longitude);

    // Update marker sesuai lokasi saat ini
    marker.value = gmaps.Marker(
      markerId: const gmaps.MarkerId("selected-location"),
      position: selectedLocation!,
      draggable: true,
    );

    loading.value = false;
  }

  void openMapDialog(BuildContext context) async {
    // Ambil lokasi saat ini
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Gunakan lokasi saat ini jika tidak ada input sebelumnya
    double lat = latitudeC.text.isNotEmpty
        ? double.parse(latitudeC.text)
        : position.latitude;
    double lon = longitudeC.text.isNotEmpty
        ? double.parse(longitudeC.text)
        : position.longitude;

    latlong2.LatLng selectedPosition = latlong2.LatLng(lat, lon);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Pilih Lokasi",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: selectedPosition,
                        initialZoom: 15.0,
                        onTap: (tapPosition, latlong2.LatLng latLng) async {
                          setState(() {
                            selectedPosition = latLng;
                          });

                          // **AMBIL ALAMAT DARI KOORDINAT YANG DIPILIH**
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                            selectedPosition.latitude,
                            selectedPosition.longitude,
                          );

                          if (placemarks.isNotEmpty) {
                            Placemark place = placemarks.first;

                            String provinsi = place.administrativeArea ?? "";
                            String kabupaten =
                                place.subAdministrativeArea ?? "";
                            String kecamatan = place.locality ?? "";
                            String desa = place.subLocality ?? "";

                            if (!manualAlamatEdited.value) {
                              alamatC.text =
                                  "$provinsi, $kabupaten, $kecamatan, $desa";
                              provinsiC.text = provinsi;
                              kabupatenC.text = kabupaten;
                              kecamatanC.text = kecamatan;
                              desaC.text = desa;
                            }
                          }

                          // **UPDATE LAT & LONG**
                          latitude.value = selectedPosition.latitude.toString();
                          longitude.value =
                              selectedPosition.longitude.toString();
                          latitudeC.text = selectedPosition.latitude.toString();
                          longitudeC.text =
                              selectedPosition.longitude.toString();
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selectedPosition,
                              width: 40.0,
                              height: 40.0,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // **PASTIKAN SEMUA DATA TERSIMPAN SAAT TEKAN "OK"**
                            latitude.value =
                                selectedPosition.latitude.toString();
                            longitude.value =
                                selectedPosition.longitude.toString();
                            latitudeC.text =
                                selectedPosition.latitude.toString();
                            longitudeC.text =
                                selectedPosition.longitude.toString();
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> getFormattedAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String provinsi = place.administrativeArea ?? "";
        String kabupaten = place.subAdministrativeArea ?? "";
        String kecamatan = place.locality ?? "";
        String desa = place.subLocality ?? "";

        String formattedAddress = "$provinsi, $kabupaten, $kecamatan, $desa";

        // **Update alamat, meskipun sudah diedit manual**
        alamatC.text = formattedAddress;
        strAlamat.value = formattedAddress;
        manualAlamatEdited.value = false; // Reset flag setelah peta digunakan
      }
    } catch (e) {
      print("Error mendapatkan alamat: $e");
    }
  }

  Future<void> updateAlamatDariPeta(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Set alamat lengkap
        alamatC.text =
            "${place.administrativeArea}, ${place.subAdministrativeArea}, ${place.locality}, ${place.subLocality}";

        // Update provinsi, kabupaten, kecamatan, desa
        provinsiC.text = place.administrativeArea ?? "";
        kabupatenC.text = place.subAdministrativeArea ?? "";
        kecamatanC.text = place.locality ?? "";
        desaC.text = place.subLocality ?? "";

        // Perbarui GetX state untuk memastikan UI di-refresh
        update();
      }
    } catch (e) {
      print("❌ Gagal mendapatkan alamat: $e");
    }
  }

  //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;

      provinsi.value = place.administrativeArea ?? "";
      kabupaten.value = place.subAdministrativeArea ?? "";
      kecamatan.value = place.locality ?? "";
      desa.value = place.subLocality ?? "";

      // **Hanya update alamat jika user belum mengedit manual**
      if (!manualAlamatEdited.value) {
        alamatC.text =
            "${provinsi.value}, ${kabupaten.value}, ${kecamatan.value}, ${desa.value}";
        provinsiC.text = provinsi.value;
        kabupatenC.text = kabupaten.value;
        kecamatanC.text = kecamatan.value;
        desaC.text = desa.value;
      }
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
    selectedJenisHewanIdInEditMode.value = fetchdata.selectedIdJenisHewan.value;
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
        jenisKandangC.text = originalJenisKandang;
        fetchdata.selectedIdJenisHewan.value = originalIdJenisHewan;
        jenisC.text = originaljenis;
        namaKandangC.text = originalNamaKandang;
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
        latitudeC.text = originalLatitudeC;
        longitudeC.text = originalLongitudeC;

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
          fetchdata.selectedIdJenisHewan.value,

          namaKandangC.text,
          jenisKandangC.text,
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
          latitudeC.text,
          longitudeC.text,
        );

        if (kandangModel != null && kandangModel!.status == 201) {
          await updateAlamatDariPeta(
              double.parse(latitudeC.text), double.parse(longitudeC.text));
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
