import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/data/vaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/vaksin/controllers/vaksin_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
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

  TextEditingController idVaksinC = TextEditingController();
  TextEditingController idPeternakC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController eartagC = TextEditingController();
  TextEditingController inseminatorC = TextEditingController();
  TextEditingController namaVaksinC = TextEditingController();
  TextEditingController jenisVaksinC = TextEditingController();
  TextEditingController tglVaksinC = TextEditingController();

  String originalIdVaksin = "";
  String originalIdPeternak = "";
  String originalNamaPeternak = "";
  String originalEartag = "";
  String originalInseminator = "";
  String originalnamaVaksin = "";
  String originaljenisVaksin = "";
  String originaltglVaksin = "";

  @override
  onClose() {
    idVaksinC.dispose();
    idPeternakC.dispose();
    namaPeternakC.dispose();
    eartagC.dispose();
    inseminatorC.dispose();
    namaVaksinC.dispose();
    jenisVaksinC.dispose();
    tglVaksinC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData.fetchPeternaks();
    fetchData.fetchHewan();
    fetchData.fetchPetugas();

    fetchData.selectedPeternakId.listen((peternakId) {
      fetchData.filterHewanByPeternak(peternakId);
    });

    role;

    idVaksinC.text = argsData["idVaksin"];
    idPeternakC.text = argsData["idPeternak"];
    namaPeternakC.text = argsData["namaPeternak"];
    eartagC.text = argsData["kodeEartagNasional"];
    inseminatorC.text = argsData["inseminator"];
    namaVaksinC.text = argsData["namaVaksin"];
    jenisVaksinC.text = argsData["jenisVaksin"];
    tglVaksinC.text = argsData["tglVaksin"];

    ever(fetchData.selectedPeternakId, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PeternakModel? selectedPeternak = fetchData.peternakList.firstWhere(
          (peternak) => peternak.idPeternak == selectedId,
          orElse: () => PeternakModel());
      namaPeternakC.text =
          selectedPeternak.namaPeternak ?? argsData["namaPeternak"];
      update();
    });

    ever(fetchData.selectedHewanEartag, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      HewanModel? selectedHewan = fetchData.hewanList.firstWhere(
          (peternak) => peternak.kodeEartagNasional == selectedId,
          orElse: () => HewanModel());
      eartagC.text =
          selectedHewan.kodeEartagNasional ?? argsData["kodeEartagNasional"];
      update();
    });

    ever(fetchData.selectedPetugasId, (String? selectedName) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PetugasModel? selectedPetugassss = fetchData.petugasList.firstWhere(
          (petugas) => petugas.nikPetugas == selectedName,
          orElse: () => PetugasModel());
      // selectedPetugasId.value = selectedPetugassss.nikPetugas ??
      //     argsData["petugas_terdaftar_hewan_detail"];
      inseminatorC.text =
          selectedPetugassss.namaPetugas ?? argsData["inseminator"];
      //print(selectedPetugasId.value);
      update();
    });

    originalIdVaksin = argsData["idVaksin"];
    originalIdPeternak = argsData["idPeternak"];
    originalNamaPeternak = argsData["namaPeternak"];
    originalEartag = argsData["kodeEartagNasional"];
    originalInseminator = argsData["inseminator"];
    originalnamaVaksin = argsData["namaVaksin"];
    originaljenisVaksin = argsData["jenisVaksin"];
    originaltglVaksin = argsData["tglVaksin"];
    update();
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
        idPeternakC.text = originalIdPeternak;
        namaPeternakC.text = originalNamaPeternak;
        eartagC.text = originalEartag;
        inseminatorC.text = originalInseminator;
        namaVaksinC.text = originalnamaVaksin;
        jenisVaksinC.text = originaljenisVaksin;
        tglVaksinC.text = originaltglVaksin;

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
          namaVaksinC.text,
          jenisVaksinC.text,
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
