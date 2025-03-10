import 'dart:io';

import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/kelahiran_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/hewan/controllers/hewan_controller.dart';
import 'package:crud_flutter_api/app/modules/menu/kelahiran/controllers/kelahiran_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/services/kelahiran_api.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddkelahiranController extends GetxController {
  final FetchData fetchdata = FetchData();

  HewanModel? hewanModel;
  KelahiranModel? kelahiranModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxString selectedSpesies = 'Sapi'.obs;
  RxString selectedGender = 'Jantan'.obs;
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

  TextEditingController idKejadianC = TextEditingController();
  TextEditingController tanggalLaporanC = TextEditingController();
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController eartagAnakC = TextEditingController();

  @override
  onClose() {
    idKejadianC.dispose();
    tanggalLaporanC.dispose();
    tanggalLahirC.dispose();

    eartagAnakC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPeternaks();
    fetchdata.fetchPetugas();
    fetchdata.fetchHewan();
    fetchdata.fetchKandangs();
    fetchdata.fetchInseminasi();

    fetchdata.selectedPeternakId.listen((peternakId) {
      fetchdata.filterHewanByPeternak(peternakId);
      fetchdata.filterKandangByPeternak(peternakId);
      fetchdata.filterInseminasiByPeternak(peternakId);
    });
  }

  Future addHewan(BuildContext context) async {
    try {
      isLoading.value = true;
      // hewanModel = await HewanApi().addHewanAPI(
      //   eartagAnakC.text, //eartag
      //   "", //no kartu ternak
      //   "", // prov
      //   "", //kab
      //   "", //kec
      //   "", //des
      //   "Perbaharui alamat hewan", //alamat
      //   fetchdata.selectedPeternakId.value, //peternak
      //   fetchdata.selectedKandangId.value, // kandang
      //   selectedSpesies.value, //spesies
      //   selectedGender.value, //gender /sex
      //   "", //umur
      //   "", // identifikasi hewan
      //   fetchdata.selectedPetugasId.value, //petugas
      //   tanggalLaporanC.text, //tanggal terdaftar
      //   null, //fotohewan
      //   // latitude: '', //lat
      //   // longitude: '' //long
      // );
      if (hewanModel != null) {
        if (hewanModel?.status == 201) {
          Get.back();
          showSuccessMessage("Data Hewan Anak Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Hewan Anak dengan status ${hewanModel?.status}");
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

  Future addKelahiran(BuildContext context) async {
    try {
      isLoading.value = true;
      if (idKejadianC.text.isEmpty) {
        throw "ID Kejadian tidak boleh kosong.";
      }

      if (fetchdata.selectedPeternakId.value.isEmpty) {
        throw "Pilih Peternak terlebih dahulu.";
      }

      if (fetchdata.selectedPetugasId.value.isEmpty) {
        throw "Pilih Petugas terlebih dahulu.";
      }

      kelahiranModel = await KelahiranApi().addKelahiranAPI(
        idKejadianC.text, //kejadian
        tanggalLaporanC.text, //tanggal lap
        tanggalLahirC.text, // tgl lahir
        fetchdata.selectedPeternakId.value, //id peternak
        fetchdata.selectedHewanEartag.value, // id hwan
        fetchdata.selectedKandangId.value, // id kandang
        fetchdata.selectedPetugasId.value, //id petugas
        fetchdata.selectedInseminasiId.value, //id inseminasi
        eartagAnakC.text, //eartag anak
        selectedGender.value, //kelamin
        selectedSpesies.value, //spesies
      );

      if (kelahiranModel != null) {
        if (kelahiranModel?.status == 201) {
          final KelahiranController kelahiranController =
              Get.put(KelahiranController());
          kelahiranController.reInitialize();
          //  Get.back();
          showSuccessMessage("Kelahiran Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Kelahiran dengan status ${kelahiranModel?.status}");
        }
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
    } finally {
      isLoading.value = false;
    }
  }

  late DateTime selectedDate = DateTime.now();
  late DateTime selectedDate1 = DateTime.now();

  Future<void> tanggalLaporan(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalLaporanC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> tanggalLahir(BuildContext context) async {
    final DateTime? picked1 = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked1 != null && picked1 != selectedDate1) {
      selectedDate1 = picked1;
      tanggalLahirC.text = DateFormat('dd/MM/yyyy').format(picked1);
    }
  }
}
