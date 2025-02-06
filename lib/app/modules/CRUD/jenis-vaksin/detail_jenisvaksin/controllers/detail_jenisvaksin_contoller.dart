
import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/jenis-vaksin/controllers/jenisvaksin_controller.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:crud_flutter_api/app/services/jenisvaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../widgets/message/successMessage.dart';

class DetailJenisVaksinController extends GetxController {
  final Map<String, dynamic> argsData = Get.arguments;
  JenisVaksinModel? jenisVaksinModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  String originalId = "";
  String originalJenis = "";
  String originalDeskripsi = "";

  TextEditingController idJenisVaksinC = TextEditingController();
  TextEditingController jenisC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  @override
  onClose() {
    idJenisVaksinC.dispose();
    jenisC.dispose();
    deskripsiC.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    // Buat Detail Data
    idJenisVaksinC.text = argsData["idJenisVaksin"];
    jenisC.text = argsData["jenis"];
    deskripsiC.text = argsData["deskripsi"];

    // Buat batal edit
    originalId = argsData["idJenisVaksin"];
    originalJenis = argsData["jenis"];
    originalDeskripsi = argsData["deskripsi"];
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
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
        idJenisVaksinC.text = originalId;
        jenisC.text = originalJenis;
        deskripsiC.text = originalDeskripsi;
        isEditing.value = false;
      },
    );
  }

  Future<void> deletePost() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Jenis Vaksin",
      message: "Apakah anda ingin menghapus data Jenis Vaksin ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        jenisVaksinModel =
            await JenisVaksinApi().deleteJenisVaksinApi(argsData["idJenisVaksin"]);

        if (jenisVaksinModel?.status == 200) {
          showSuccessMessage("Berhasil Hapus Data Jenis Vaksin");
        } else {
          showErrorMessage("Gagal Hapus Data Jenis Vaksin");
        }

        final JenisVaksinController jenisVaksinController =
            Get.put(JenisVaksinController());
        jenisVaksinController.reInitialize();
        update();
        Get.offAllNamed(Routes.JENISVAKSIN);
      },
    );
  }

  Future<void> editJenisVaksin() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Edit Data Jenis Vaksin",
      message: "Apakah Anda ingin mengedit data Jenis Vaksin ini?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          final response = await JenisVaksinApi().editJenisVaksinApi(
              idJenisVaksinC.text, jenisC.text, deskripsiC.text);

          if (response != null) {
            jenisVaksinModel = response;

            if (jenisVaksinModel?.status == 201 ||
                jenisVaksinModel?.message ==
                    "Jenis Vaksin Updated Successfully") {
              showSuccessMessage("Jenis Vaksin berhasil diubah");

              update();
              Get.back();
              Get.back();
            } else {
              showErrorMessage(
                  "Gagal mengubah jenis Vaksin. Pesan: ${jenisVaksinModel?.message ?? 'Unknown error'}");
            }
          } else {
            showErrorMessage("Gagal mendapatkan respons dari server.");
          }
        } catch (e) {
          showErrorMessage("Terjadi kesalahan: ${e.toString()}");
        } finally {
          isLoading.value = false;
          isEditing.value = false;
        }
      },
    );
  }
}
