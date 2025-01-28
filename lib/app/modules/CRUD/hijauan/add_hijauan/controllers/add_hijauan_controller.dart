import 'dart:io';
import 'dart:typed_data';

import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddHijauanController extends GetxController {
  TextEditingController alamatC = TextEditingController();
  final FetchData fetchData = FetchData();

  RxBool isLoading = false.obs;
  RxString alamat = ''.obs;
  Rx<File?> fotoHijauan = Rx<File?>(null);
  RxString selectedJenisHijauan = 'Rumput'.obs;

  List<String> jenisHijauan = ["Rumput", "Leguminosa", "Hijauan Campuran"];

  RxString strLatLong =
      'belum mendapatkan lat dan long, silakan tekan tombol'.obs;
  RxString strAlamat = 'mencari lokasi..'.obs;
  RxBool loading = false.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  TextEditingController idC = TextEditingController();
  TextEditingController jenisHijauanC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();

  get selectedSpesies => null;

  @override
  void onClose() {
    idC.dispose();
    alamatC.dispose();
    jenisHijauanC.dispose();
    provinsiC.dispose();
    kabupatenC.dispose();
    kecamatanC.dispose();
    desaC.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  //GET LOCATION
  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
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
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
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

  Future<void> updateAlamatInfo() async {
    try {
      isLoading.value = true;
      Position position = await getGeoLocationPosition();
      await getAddressFromLongLat(position);

      provinsiC.text = getAlamatInfo(5);
      kabupatenC.text = getAlamatInfo(0);
      kecamatanC.text = getAlamatInfo(2);
      desaC.text = getAlamatInfo(1);
    } catch (e) {
      print('Error updating alamat info: $e');
      showErrorMessage("Error updating alamat info: $e");
    } finally {
      isLoading.value = false;
    }
  }

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
      File compressedImage = await compressImage(imageFile);

      fotoHijauan.value = compressedImage;
      update();
    }
  }

  Future<File> compressImage(File imageFile) async {
    Uint8List? imageBytes = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      quality: 20,
    );

    File compressedImageFile = File('${imageFile.path}_compressed.jpg');
    await compressedImageFile.writeAsBytes(imageBytes!);

    return compressedImageFile;
  }

  void removeImage() {
    fotoHijauan.value = null;
    update();
  }

  Future addHijauan(BuildContext context) async {
    try {
      isLoading.value = true;

      if (idC.text.isEmpty) {
        throw "ID tidak boleh kosong.";
      }

      if (fotoHijauan.value == null) {
        throw "Pilih gambar hijauan terlebih dahulu.";
      }

      // Lakukan API call untuk menambahkan data hijauan di sini
      await updateAlamatInfo();

      // Simpan data hijauan (API integration)
      showSuccessMessage("Data Hijauan Berhasil ditambahkan");
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
