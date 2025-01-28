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

  var uuid = Uuid();

  TextEditingController idKandangC = TextEditingController();
  TextEditingController luasC = TextEditingController();
  TextEditingController kapasitasC = TextEditingController();
  TextEditingController nilaiBangunanC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();
  TextEditingController jenisHewanC = TextEditingController();

  get selectedSpesies => null;

  get spesies => null;

  List<String> get spesiesList => spesies;

  @override
  onClose() {
    idKandangC.dispose();

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
    super.onInit();
    fetchdata.fetchPeternaks();
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

  Future addKandang(BuildContext context) async {
    // Mencetak data sebelum memanggil API
    print("Data yang akan ditambahkan:");
    print("ID Kandang: ${idKandangC.text}");
    print("ID Peternak: ${fetchdata.selectedPeternakId.value}");
    print("Luas: ${luasC.text}");
    print("Kapasitas: ${kapasitasC.text}");
    print("Nilai Bangunan: ${nilaiBangunanC.text}");
    print("Alamat: ${alamatC.text}");
    print("Provinsi: ${provinsiC.text}");
    print("Kabupaten: ${kabupatenC.text}");
    print("Kecamatan: ${kecamatanC.text}");
    print("Desa: ${desaC.text}");
    print("Jenis Hewan: ${jenisHewanC.text}");
    print("Latitude: ${latitude.value}");
    print("Longitude: ${longitude.value}");
    try {
      isLoading.value = true;

      // Mengenerate UUID untuk ID Kandang
      idKandangC.text = uuid.v4(); // Generate UUID dan set ke idKandangC

      if (idKandangC.text.isEmpty) {
        throw "ID Kandang tidak boleh kosong.";
      }

      if (fetchdata.selectedPeternakId.value.isEmpty ?? true) {
        throw "Pilih Peternak terlebih dahulu.";
      }

      File? fotoKandangFile = fotoKandang.value;

      if (fotoKandangFile == null) {
        throw "Pilih gambar Kandang terlebih dahulu.";
      }

      if (jenisHewanC.text.isEmpty) {
        throw "jenis hewan tidak boleh kosong.";
      }

      kandangModel = await KandangApi().addKandangAPI(
        //  idKandangC.text,
        idKandangC.text,
        fetchdata.selectedPeternakId.value,
        luasC.text,
        kapasitasC.text,
        nilaiBangunanC.text,
        alamatC.text,
        provinsiC.text,
        kabupatenC.text,
        kecamatanC.text,
        desaC.text,
        fotoKandangFile,
        jenisHewan: jenisHewanC.text,
        latitude: latitude.value,
        longitude: longitude.value,
      );
      await updateAlamatInfo();

      if (kandangModel != null) {
        if (kandangModel!.status == 201) {
          final KandangController hewanController =
              Get.put(KandangController());
          hewanController.reInitialize();
          Get.back();
          showSuccessMessage("Data Hewan Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Hewan dengan status ${kandangModel?.status}");
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
}
