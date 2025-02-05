import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/modules/menu/jenis-hewan/controllers/jenishewan_controller.dart';
import 'package:crud_flutter_api/app/services/jenishewan_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:flutter/widgets.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../../widgets/message/successMessage.dart';

class DetailJenisHewanController extends GetxController {
  final Map<String, dynamic> argsData = Get.arguments;
  JenisHewanModel? jenisHewanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  String originalId = "";
  String originalJenis = "";
  String originalDeskripsi = "";

  TextEditingController idJenisHewanC = TextEditingController();
  TextEditingController jenisC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  @override
  onClose() {
    idJenisHewanC.dispose();
    jenisC.dispose();
    deskripsiC.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    // Buat Detail Data
    idJenisHewanC.text = argsData["idJenisHewan"];
    jenisC.text = argsData["jenis"];
    deskripsiC.text = argsData["deskripsi"];

    // Buat batal edit
    originalId = argsData["idJenisHewan"];
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
        idJenisHewanC.text = originalId;
        jenisC.text = originalJenis;
        deskripsiC.text = originalDeskripsi;
        isEditing.value = false;
      },
    );
  }

  Future<void> deletePost() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Jenis Hewan",
      message: "Apakah anda ingin menghapus data Jenis Hewan ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        jenisHewanModel =
            await JenisHewanApi().deleteJenisHewanApi(argsData["idJenisHewan"]);

        if (jenisHewanModel?.status == 200) {
          showSuccessMessage("Berhasil Hapus Data Jenis Hewan");
        } else {
          showErrorMessage("Gagal Hapus Data Jenis Hewan");
        }

        final JenisHewanController jenisHewanController =
            Get.put(JenisHewanController());
        jenisHewanController.reInitialize();
        update();
        Get.offAllNamed(Routes.JENISHEWAN);
      },
    );
  }

  Future<void> editJenisHewan() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Edit Data Jenis Hewan",
      message: "Apakah Anda ingin mengedit data Jenis Hewan ini?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          // Close modal
          Get.back();
          update();

          // Memanggil API untuk edit data dan memetakan JSON ke objek JenisHewanModel
          final response = await JenisHewanApi().editJenisHewanApi(
              idJenisHewanC.text, jenisC.text, deskripsiC.text);

          // Periksa apakah response tidak null
          if (response != null) {
            jenisHewanModel = response;

            // Memeriksa apakah status adalah 200 (berhasil)
            if (jenisHewanModel?.status == 201 ||
                jenisHewanModel?.message ==
                    "Jenis Hewan Updated Successfully") {
              // Jika status 200, berarti berhasil
              showSuccessMessage("Jenis Hewan berhasil diubah");

              // Navigasi kembali ke halaman pertama (Home)
              Get.offAllNamed(Routes.JENISHEWAN);
            } else {
              // Jika status bukan 200, tampilkan pesan error
              showErrorMessage(
                  "Gagal mengubah jenis hewan. Pesan: ${jenisHewanModel?.message ?? 'Unknown error'}");
            }
          } else {
            // Tangani jika response null
            showErrorMessage("Gagal mendapatkan respons dari server.");
          }
        } catch (e) {
          // Tangani kesalahan dan tampilkan pesan error
          showErrorMessage("Terjadi kesalahan: ${e.toString()}");
        } finally {
          // Menyelesaikan proses loading
          isLoading.value = false;
          isEditing.value = false;
        }
      },
    );
  }
}
