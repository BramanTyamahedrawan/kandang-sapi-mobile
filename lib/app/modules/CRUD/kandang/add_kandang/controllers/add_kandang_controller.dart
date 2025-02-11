import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/modules/menu/kandang/controllers/kandang_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/kandang_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';

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
    Placemark street = placemarks[1];

    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();

    strAlamat.value =
        ' ${street.street}, ${place.subAdministrativeArea}, ${place.subLocality}, ${place.locality}, '
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
      provinsiC.text = getAlamatInfo(2); //benar 5
      kabupatenC.text = getAlamatInfo(3); //benar 0
      kecamatanC.text = getAlamatInfo(1); //benar 2
      desaC.text = getAlamatInfo(6); //benar 1
      alamatC.text = getAlamatInfo(0);
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
