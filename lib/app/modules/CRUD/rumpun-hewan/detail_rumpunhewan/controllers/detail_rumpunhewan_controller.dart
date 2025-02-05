import 'package:crud_flutter_api/app/data/RumpunHewan_model.dart';
import 'package:crud_flutter_api/app/modules/menu/rumpun-hewan/controllers/rumpunhewan_controller.dart';
import 'package:crud_flutter_api/app/services/RumpunHewan_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:flutter/widgets.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../../../widgets/message/successMessage.dart';

class DetailRumpunHewanController extends GetxController {
  final Map<String, dynamic> argsData = Get.arguments;
  RumpunHewanModel? rumpunHewanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  String originalId = "";
  String originalRumpun = "";
  String originalDeskripsi = "";

  TextEditingController idRumpunHewanC = TextEditingController();
  TextEditingController rumpunC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  @override
  onClose() {
    idRumpunHewanC.dispose();
    rumpunC.dispose();
    deskripsiC.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    // Buat Detail Data
    idRumpunHewanC.text = argsData["idRumpunHewan"];
    rumpunC.text = argsData["rumpun"];
    deskripsiC.text = argsData["deskripsi"];

    // Buat batal edit
    originalId = argsData["idRumpunHewan"];
    originalRumpun = argsData["rumpun"];
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
        idRumpunHewanC.text = originalId;
        rumpunC.text = originalRumpun;
        deskripsiC.text = originalDeskripsi;
        isEditing.value = false;
      },
    );
  }

  Future<void> deletePost() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Jenis Hewan",
      message: "Apakah anda ingin menghapus data Rumpun Hewan ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        rumpunHewanModel = await RumpunHewanApi()
            .deleteRumpunHewanApi(argsData["idRumpunHewan"]);

        if (rumpunHewanModel?.status == 200) {
          showSuccessMessage("Berhasil Hapus Data Rumpun Hewan");
        } else {
          showErrorMessage("Gagal Hapus Data Rumpun Hewan");
        }

        final RumpunHewanController rumpunHewanController =
            Get.put(RumpunHewanController());
        rumpunHewanController.reInitialize();
        update();
        Get.offAllNamed(Routes.RUMPUNHEWAN);
      },
    );
  }

  Future<void> editRumpunHewan() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Edit Data Rumpun Hewan",
      message: "Apakah Anda ingin mengedit data Rumpun Hewan ini?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          Get.back();
          update();
          final response = await RumpunHewanApi().editRumpunHewanApi(
              idRumpunHewanC.text, rumpunC.text, deskripsiC.text);

          if (response != null) {
            rumpunHewanModel = response;

            if (rumpunHewanModel?.status == 201 ||
                rumpunHewanModel?.message ==
                    "Rumpun Hewan Updated Successfully") {
              showSuccessMessage("Rumpun Hewan berhasil diubah");

              Get.offAllNamed(Routes.RUMPUNHEWAN);
            } else {
              showErrorMessage(
                  "Gagal mengubah rumpun hewan. Pesan: ${rumpunHewanModel?.message ?? 'Unknown error'}");
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
