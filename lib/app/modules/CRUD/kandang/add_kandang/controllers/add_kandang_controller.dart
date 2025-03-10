import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/modules/menu/kandang/controllers/kandang_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/kandang_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

class AddKandangController extends GetxController {
  final FetchData fetchdata = FetchData();
  final spesiess = <String>[].obs;
  KandangModel? kandangModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs; // Gunakan .obs untuk membuat Rx variabel
  final KandangController kandangController = Get.put(KandangController());
  Rx<File?> fotoKandang = Rx<File?>(null);

  RxString strLatLong =
      'belum mendapatkan lat dan long, silakan tekan tombol'.obs;
  RxString strAlamat = 'mencari lokasi..'.obs;
  RxBool loading = false.obs;
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

  TextEditingController idKandangC = TextEditingController();
  TextEditingController luasC = TextEditingController();
  TextEditingController namaKandangC = TextEditingController();
  TextEditingController kapasitasC = TextEditingController();
  TextEditingController nilaiBangunanC = TextEditingController();
  TextEditingController jenisKandangC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController latitudeC = TextEditingController();
  TextEditingController longitudeC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();

  get selectedSpesies => null;

  get spesies => null;

  List<String> get spesiesList => spesies;

  @override
  onClose() {
    idKandangC.dispose();

    luasC.dispose();
    kapasitasC.dispose();
    nilaiBangunanC.dispose();
    namaKandangC.dispose();
    jenisKandangC.dispose();
    alamatC.dispose();
    desaC.dispose();
    kecamatanC.dispose();
    kabupatenC.dispose();
    latitudeC.dispose();
    longitudeC.dispose();
    provinsiC.dispose();
    ever<File?>(fotoKandang, (_) {
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPeternaks();
    fetchdata.fetchJenisHewan();

    getGeoLocationPosition();

    fetchdata.selectedPeternakId.listen((peternakId) {
      fetchdata.filterHewanByPeternak(peternakId);
    });
  }

  void fetchSpesies() {
    // Contoh pengisian data, ini bisa diganti dengan panggilan API
    spesies.assignAll([
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
    ]);
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

  // Fungsi untuk mendapatkan alamat dari geolocation dan mengupdate nilai provinsi, kabupaten, kecamatan, dan desa
  // Future<void> updateAlamatInfo() async {
  //   try {
  //     isLoading.value = true;

  //     // Mendapatkan posisi geolokasi
  //     Position position = await getGeoLocationPosition();

  //     // Mendapatkan alamat dari geolokasi
  //     await getAddressFromLongLat(position);

  //     // Mengupdate nilai provinsi, kabupaten, kecamatan, dan desa berdasarkan alamat
  //     provinsiC.text = getAlamatInfo(2); //benar 5
  //     kabupatenC.text = getAlamatInfo(3); //benar 0
  //     kecamatanC.text = getAlamatInfo(1); //benar 2
  //     desaC.text = getAlamatInfo(6); //benar 1
  //     alamatC.text = getAlamatInfo(0);
  //   } catch (e) {
  //     print('Error updating alamat info: $e');
  //     showErrorMessage("Error updating alamat info: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

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

  // Fungsi untuk menghapus gambar yang sudah dipilih
  void removeImage() {
    fotoKandang.value = null;
    update(); // Perbarui UI setelah menghapus gambar
  }

  var uuid = Uuid();

  Future addKandang(BuildContext context) async {
    print("Mulai proses submit kandang...");

    try {
      isLoading.value = true;

      // Fungsi untuk menghasilkan ID Kandang secara acak

      String idKandang = uuid.v4();

      // Debugging - Log semua input sebelum dikirim
      print("ID Kandang: ${idKandang}");
      print("Peternak ID: ${fetchdata.selectedPeternakId.value}");
      print("Jenis Hewan ID: ${fetchdata.selectedIdJenisHewan.value}");
      print("Nama Kandang: ${namaKandangC.text}");
      print("Jenis Kandang: ${jenisKandangC.text}");
      print("Luas: ${luasC.text}");
      print("Kapasitas: ${kapasitasC.text}");
      print("Nilai Bangunan: ${nilaiBangunanC.text}");
      print("Alamat: ${alamatC.text}");
      print(
          "Latitude: ${latitudeC.text.isNotEmpty ? latitudeC.text : 'Tidak diisi'}");
      print(
          "Longitude: ${longitudeC.text.isNotEmpty ? longitudeC.text : 'Tidak diisi'}");
      print("Foto Kandang: ${fotoKandang.value}");

      if (fetchdata.selectedPeternakId.value.isNotEmpty &&
          fetchdata.selectedPeternakId.value == "") {
        throw "Pilih Peternak terlebih dahulu.";
      }

      if (fetchdata.selectedIdJenisHewan.value.isEmpty &&
          fetchdata.selectedIdJenisHewan.value == "") {
        throw "Jenis hewan tidak boleh kosong.";
      }

      String idPeternak = fetchdata.selectedPeternakId.value;

      String idJenisHewan = fetchdata.selectedIdJenisHewan.value;

      // Jika gambar tidak dipilih, set sebagai `null`
      File? selectedFotoKandang = fotoKandang.value;

      String jenisKandang = jenisKandangC.text;

      // Kirim data kandang ke API
      print("Mengirim data kandang ke API..." +
          "idKandang: $idKandang, peternakId: $idPeternak, idJenisHewan: $idJenisHewan, luas: ${luasC.text}, namaKandang: ${namaKandangC.text}, kapasitas: ${kapasitasC.text}, nilaiBangunan: ${nilaiBangunanC.text}, alamat: ${alamatC.text}, latitude: ${latitudeC.text}, longitude: ${longitudeC.text}, jenisKandang: ${jenisKandangC.text}");
      kandangModel = await KandangApi().addKandangAPI(
        idKandang,
        idPeternak,
        luasC.text, // luas
        namaKandangC.text, // namaKandang
        jenisKandangC.text, // jenisKandang
        kapasitasC.text,
        nilaiBangunanC.text,
        alamatC.text,
        desaC.text, // desa
        kecamatanC.text, // kecamatan
        kabupatenC.text, // kabupaten
        provinsiC.text, // provinsi
        selectedFotoKandang, // Jika null, maka akan diabaikan
        latitudeC.text.isNotEmpty ? latitudeC.text : '',
        longitudeC.text.isNotEmpty ? longitudeC.text : '',
        idJenisHewan, // idJenisHewan
      );

      print("Response dari API: ${kandangModel?.status}");

      if (kandangModel != null) {
        if (kandangModel!.status == 201) {
          final KandangController kandangController =
              Get.put(KandangController());
          kandangController.reInitialize();
          Get.back();
          showSuccessMessage("Data Kandang Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Data Kandang dengan status ${kandangModel?.status}");
        }
      }
    } catch (e) {
      print("❌ Error saat submit kandang: $e");
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
}
