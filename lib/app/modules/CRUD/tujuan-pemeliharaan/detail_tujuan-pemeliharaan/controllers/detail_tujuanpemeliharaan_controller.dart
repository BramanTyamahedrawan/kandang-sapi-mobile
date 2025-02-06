import 'package:crud_flutter_api/app/data/TujuanPemeliharaan_model.dart';
import 'package:crud_flutter_api/app/modules/menu/tujuan-pemeliharaan/controllers/tujuanpemeliharaan_controller.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:crud_flutter_api/app/services/tujuanpemeliharaan_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../widgets/message/successMessage.dart';

class DetailTujuanPemeliharaanController extends GetxController {
  final Map<String, dynamic> argsData = Get.arguments;
  TujuanPemeliharaanModel? tujuaPemeliharaanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  String originalId = "";
  String originalTujuan = "";
  String originalDeskripsi = "";

  TextEditingController idTujuanPemeliharaanC = TextEditingController();
  TextEditingController tujanPemeliharaanC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  @override
  onClose() {
    idTujuanPemeliharaanC.dispose();
    tujanPemeliharaanC.dispose();
    deskripsiC.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    // Buat Detail Data
    idTujuanPemeliharaanC.text = argsData["idTujuanPemeliharaan"];
    tujanPemeliharaanC.text = argsData["tujuanPemeliharaan"];
    deskripsiC.text = argsData["deskripsi"];

    // Buat batal edit
    originalId = argsData["idTujuanPemeliharaan"];
    originalTujuan = argsData["tujuanPemeliharaan"];
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
        idTujuanPemeliharaanC.text = originalId;
        tujanPemeliharaanC.text = originalTujuan;
        deskripsiC.text = originalDeskripsi;
        isEditing.value = false;
      },
    );
  }

  Future<void> deletePost() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Tujuan Pemeliharaan",
      message: "Apakah anda ingin menghapus data Tujuan Pemeliharaan ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        tujuaPemeliharaanModel = await TujuanPemeliharaanApi()
            .deleteTujuanPemeliharaanApi(argsData["idTujuanPemeliharaan"]);

        if (tujuaPemeliharaanModel?.status == 200) {
          showSuccessMessage("Berhasil Hapus Data Tujuan Pemeliharaan");
        } else {
          showErrorMessage("Gagal Hapus Data Tujuan Pemeliharaan");
        }

        final TujuanPemeliharaanController tujuanPemeliharaanController =
            Get.put(TujuanPemeliharaanController());
        tujuanPemeliharaanController.reInitialize();
        update();
        Get.offAllNamed(Routes.TUJUANPEMELIHARAAN);
      },
    );
  }

  Future<void> editTujuanPemeliharaan() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Edit Data Tujuan Pemeliharaan",
      message: "Apakah Anda ingin mengedit data Tujuan Pemeliharaan ini?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          final response = await TujuanPemeliharaanApi()
              .editTujuanPemeliharaanApi(idTujuanPemeliharaanC.text,
                  tujanPemeliharaanC.text, deskripsiC.text);

          if (response != null) {
            tujuaPemeliharaanModel = response;

            if (tujuaPemeliharaanModel?.status == 201 ||
                tujuaPemeliharaanModel?.message ==
                    "Tujuan Pemeliharaan Updated Successfully") {
              showSuccessMessage("Tujuan Pemeliharaan berhasil diubah");

              update();
              Get.back();
              Get.back();
            } else {
              showErrorMessage(
                  "Gagal mengubah tujuan pemeliharaan. Pesan: ${tujuaPemeliharaanModel?.message ?? 'Unknown error'}");
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
