import 'package:crud_flutter_api/app/data/vaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/vaksin/controllers/vaksin_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/vaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailVaksinController extends GetxController {
  final box = GetStorage();
  String? get role => box.read('role');

  final FetchData fetchData = FetchData();
  final VaksinController vaksinController = Get.put(VaksinController());

  final Map<String, dynamic> argsData = Get.arguments;
  VaksinModel? vaksinModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  RxString selectedPeternakIdInEditMode = ''.obs;
  RxString selectedIdHewanInEditMode = ''.obs;
  RxString selectedIdNamaVaksinInEditMode = ''.obs;
  RxString selectedIdJenisVaksinInEditMode = ''.obs;
  RxString selectedPetugasIdInEditMode = ''.obs;

  TextEditingController idVaksinC = TextEditingController();
  TextEditingController batchVaksinC = TextEditingController();
  TextEditingController vaksinKeC = TextEditingController();
  TextEditingController tglVaksinC = TextEditingController();

  String originalIdVaksin = "";
  String originalIdHewan = "";
  String originalIdPeternak = "";
  String originalIdNamaVaksin = "";
  String originalIdJenisVaksin = "";
  String originalBatchVaksin = "";
  String originalVaksinKe = "";
  String originaltglVaksin = "";
  String originalPetugas = "";

  @override
  onClose() {
    idVaksinC.dispose();
    batchVaksinC.dispose();
    vaksinKeC.dispose();
    tglVaksinC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData.fetchPeternaks();
    fetchData.fetchHewan();
    fetchData.fetchPetugas();
    fetchData.fetchJenisVaksin();
    fetchData.fetchNamaVaksin();
    fetchData.selectedPeternakId.listen((peternakId) {
      fetchData.filterHewanByPeternak(peternakId);
    });

    role;

    idVaksinC.text = argsData["idVaksin"];
    batchVaksinC.text = argsData["batchVaksin"];
    vaksinKeC.text = argsData["vaksinKe"];
    tglVaksinC.text = argsData["tglVaksin"];

    final idHewan = argsData["kodeEartagNasional"];
    final idPeternak = argsData["idPeternak"];
    final idNamaVaksin = argsData["namaVaksin"];
    final idJenisVaksin = argsData["jenisVaksin"];
    final idPetugas = argsData["inseminator"];

    originalIdVaksin = argsData["idVaksin"];
    originalIdHewan = argsData["kodeEartagNasional"];
    originalIdPeternak = argsData["idPeternak"];
    originalIdNamaVaksin = argsData["namaVaksin"];
    originalIdJenisVaksin = argsData["jenisVaksin"];
    originalBatchVaksin = argsData["batchVaksin"];
    originalVaksinKe = argsData["vaksinKe"];
    originaltglVaksin = argsData["tglVaksin"];
    originalPetugas = argsData["inseminator"];

    fetchData.fetchPeternaks().then((_) {
      if (idPeternak != null) {
        bool isValid = fetchData.peternakList
            .any((peternaks) => peternaks.idPeternak == idPeternak);
        if (isValid) {
          fetchData.selectedPeternakId.value = idPeternak;
        } else {
          print(
              "❌ ID Peternak dari argsData tidak ditemukan di daftar peternak!");
        }
      } else {
        print("�� ID Peternak kosong! Harap mengisi ID Peternak yang valid.");
      }
    });

    fetchData.fetchHewan().then((_) {
      if (idHewan != null) {
        bool isValid =
            fetchData.hewanList.any((hewans) => hewans.idHewan == idHewan);
        if (isValid) {
          fetchData.selectedHewanEartag.value = idHewan;
          print("data controller ${fetchData.selectedHewanEartag.value}");
        } else {
          print("�� ID Hewan dari argsData tidak ditemukan di daftar hewan!");
        }
      } else {
        print("�� ID Hewan kosong! Harap mengisi ID Hewan yang valid.");
      }
    });

    fetchData.fetchPetugas().then((_) {
      if (idPetugas != null) {
        bool isValid = fetchData.petugasList
            .any((petugas) => petugas.petugasId == idPetugas);
        if (isValid) {
          fetchData.selectedPetugasId.value = idPetugas;
        } else {
          print(
              "�� ID Petugas dari argsData tidak ditemukan di daftar petugas!");
        }
      } else {
        print("�� ID Petugas kosong! Harap mengisi ID Petugas yang valid.");
      }
      update();
    });

    fetchData.fetchJenisVaksin().then((_) {
      if (idJenisVaksin != null) {
        bool isValid = fetchData.jenisVaksinList
            .any((vaksin) => vaksin.idJenisVaksin == idJenisVaksin);
        if (isValid) {
          fetchData.selectedIdJenisVaksin.value = idJenisVaksin;
        } else {
          print(
              "�� ID Jenis Vaksin dari argsData tidak ditemukan di daftar jenis vaksin!");
        }
      } else {
        print(
            "�� ID Jenis Vaksin kosong! Harap mengisi ID Jenis Vaksin yang valid.");
      }
      update();
    });

    fetchData.fetchNamaVaksin().then((_) {
      if (idNamaVaksin != null) {
        bool isValid = fetchData.namaVaksinList
            .any((vaksin) => vaksin.idNamaVaksin == idNamaVaksin);
        if (isValid) {
          fetchData.selectedIdNamaVaksin.value = idNamaVaksin;
        } else {
          print(
              "�� ID Nama Vaksin dari argsData tidak ditemukan di daftar nama vaksin!");
        }
      } else {
        print(
            "�� ID Nama Vaksin kosong! Harap mengisi ID Nama Vaksin yang valid.");
      }
      update();
    });
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
    selectedPeternakIdInEditMode.value = fetchData.selectedPeternakId.value;
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
        idVaksinC.text = originalIdVaksin;
        batchVaksinC.text = originalBatchVaksin;
        vaksinKeC.text = originalVaksinKe;
        tglVaksinC.text = originaltglVaksin;
        selectedPeternakIdInEditMode.value = originalIdPeternak;
        selectedIdHewanInEditMode.value = originalIdHewan;
        selectedIdJenisVaksinInEditMode.value = originalIdJenisVaksin;
        selectedIdNamaVaksinInEditMode.value = originalIdNamaVaksin;
        selectedPetugasIdInEditMode.value = originalPetugas;
        isEditing.value = false;
      },
    );
  }

  Future<void> deleteVaksin() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Vaksin",
      message: "Apakah anda ingin menghapus data ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        vaksinModel = await VaksinApi().deleteVaksinApi(argsData["idVaksin"]);
        if (vaksinModel != null) {
          if (vaksinModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Data Vaksin dengan ID: ${idVaksinC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Vaksin ");
          }
        }
        final VaksinController vaksinController = Get.put(VaksinController());
        vaksinController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  Future<void> editVaksin() async {
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Vaksin",
      message: "Apakah anda ingin mengedit data Vaksin ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        vaksinModel = await VaksinApi().editVaksinApi(
          idVaksinC.text,
          fetchData.selectedPeternakId.value,
          fetchData.selectedHewanEartag.value,
          fetchData.selectedPetugasId.value,
          fetchData.selectedIdNamaVaksin.value,
          fetchData.selectedIdJenisVaksin.value,
          batchVaksinC.text,
          vaksinKeC.text,
          tglVaksinC.text,
        );
        isEditing.value = false;
        if (vaksinModel != null) {
          if (vaksinModel!.status == 201) {
            showSuccessMessage(
                "Berhasil mengedit Data Vaksin dengan ID: ${idVaksinC.text}");
          } else {
            showErrorMessage("Gagal mengedit Data Vaksin ");
          }
        }
        final VaksinController vaksinController = Get.put(VaksinController());
        vaksinController.reInitialize();
        Get.back(); // close modal
        Get.back();
        update();
      },
    );
  }

  late DateTime selectedDate = DateTime.now();

  Future<void> Kalender(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tglVaksinC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
