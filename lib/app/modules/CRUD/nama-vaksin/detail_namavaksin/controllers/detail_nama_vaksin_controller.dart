import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/nama-vaksin/controllers/namavaksin_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/namavaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailNamaVaksinController extends GetxController {
  final box = GetStorage();

  final FetchData fetchData = FetchData();
  final NamaVaksinController namaVaksinController =
      Get.put(NamaVaksinController());

  final Map<String, dynamic> argsData = Get.arguments;
  NamaVaksinModel? namaVaksinModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  RxString selectedIdJenisVaksinInEditMode = ''.obs;

  TextEditingController idNamaVaksinC = TextEditingController();
  TextEditingController idJenisVaksinC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  String originalIdNamaVaksin = "";
  String originalIdJenisVaksin = "";
  String originalNama = "";
  String originalDeskripsi = "";

  @override
  onClose() {
    idNamaVaksinC.dispose();
    idJenisVaksinC.dispose();
    namaC.dispose();
    deskripsiC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    // Periksa apakah argsData["idJenisVaksin"] adalah model atau string
    final idJenisVaksin = argsData["idJenisVaksin"];

    fetchData.fetchJenisVaksin().then((_) {
      if (idJenisVaksin != null) {
        bool isValid = fetchData.jenisVaksinList
            .any((jenis) => jenis.idJenisVaksin == idJenisVaksin);

        if (isValid) {
          fetchData.selectedIdJenisVaksin.value = idJenisVaksin;
          print(
              "✅ Selected ID Jenis Vaksin berhasil di-set: ${fetchData.selectedIdJenisVaksin.value}");
        } else {
          print(
              "❌ ID Jenis Vaksin dari argsData tidak ditemukan di daftar jenis vaksin!");
        }
      } else {
        print("⚠️ argsData idJenisVaksin kosong atau null!");
      }

      update();
    });
    idNamaVaksinC.text = argsData["idNamaVaksin"];
    namaC.text = argsData["nama"];
    deskripsiC.text = argsData["deskripsi"];
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
    selectedIdJenisVaksinInEditMode.value =
        fetchData.selectedIdJenisVaksin.value;
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
        idNamaVaksinC.text = originalIdNamaVaksin;
        idJenisVaksinC.text = originalIdJenisVaksin;
        namaC.text = originalNama;
        deskripsiC.text = originalDeskripsi;
        isEditing.value = false;
      },
    );
  }

  Future<void> deleteNamaVaksin() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Nama Vaksin",
      message: "Apakah anda ingin menghapus data ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        namaVaksinModel =
            await NamavaksinApi().deleteNamaVaksinApi(argsData["idNamaVaksin"]);
        if (namaVaksinModel != null) {
          if (namaVaksinModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Data Nama Vaksin dengan ID: ${idNamaVaksinC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Nama Vaksin ");
          }
        }
        final NamaVaksinController namaVaksinController =
            Get.put(NamaVaksinController());
        namaVaksinController.reInitialize();
        update();
        refresh();
        Get.back();
        Get.back();
      },
    );
  }

  Future<void> editNamaVaksin() async {
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Nama Vaksin",
      message: "Apakah anda ingin mengedit data Nama Vaksin ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          final response = await NamavaksinApi().editNamaVaksinApi(
            idNamaVaksinC.text,
            fetchData.selectedIdJenisVaksin.value,
            namaC.text,
            deskripsiC.text,
          );

          if (response != null) {
            namaVaksinModel = response;

            if (namaVaksinModel?.status == 201) {
              showSuccessMessage("Nama Vaksin berhasil diubah");
              update();
              refresh();
              Get.back();
              Get.back();
            } else {
              showErrorMessage(
                  "Gagal mengubah jenis hewan. Pesan: ${namaVaksinModel?.message ?? 'Unknown error'}");
            }
          } else {
            showErrorMessage("Gagal mendapatkan respons dari server.");
          }
        } catch (e) {
          showErrorMessage("Terjadi kesalahan: ${e.toString()}");
        } finally {
          final NamaVaksinController namaVaksinController =
              Get.put(NamaVaksinController());
          namaVaksinController.reInitialize();
          update();
          isLoading.value = false;
          isEditing.value = false;
        }
      },
    );
  }
}
