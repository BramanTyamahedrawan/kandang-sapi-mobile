import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/peternak/controllers/peternak_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPeternakController extends GetxController {
  final FetchData fetchdata = FetchData();

  //TODO: Implement DetailPostController
  final Map<String, dynamic> argsData = Get.arguments;
  PeternakModel? peternakModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;
  final formattedDate = ''.obs;

  TextEditingController idPeternakC = TextEditingController();
  TextEditingController nikPeternakC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController idISIKHNASC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController petugasPendaftarC = TextEditingController();
  TextEditingController tanggalPendaftaranC = TextEditingController();

  String originalIdPeternak = "";
  String originalNikPeternak = "";
  String originalNamaPeternak = "";
  String originalIdIskhnas = "";
  String originalLokasi = "";
  String originalPetugasPendaftar = "";
  String originalTanggalPendaftaran = "";

  @override
  onClose() {
    idPeternakC.dispose();
    nikPeternakC.dispose();
    namaPeternakC.dispose();
    idISIKHNASC.dispose();
    lokasiC.dispose();
    tanggalPendaftaranC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPetugas();

    idPeternakC.text = argsData["idPeternak"];
    nikPeternakC.text = argsData["nikPeternak"];
    namaPeternakC.text = argsData["namaPeternak"];
    idISIKHNASC.text = argsData["idISIKHNAS"];
    lokasiC.text = argsData["lokasi"];
    petugasPendaftarC.text = argsData["petugas_id"];
    tanggalPendaftaranC.text = argsData["tanggalPendaftaran"];
    // selectedPetugas.value = argsData["petugasPendaftar"];

    ever(fetchdata.selectedPetugasId, (String? selectedName) {
      PetugasModel? selectedPetugassss = fetchdata.petugasList.firstWhere(
          (petugas) => petugas.nikPetugas == selectedName,
          orElse: () => PetugasModel());
      fetchdata.selectedPetugasId.value =
          selectedPetugassss.nikPetugas ?? argsData["petugas_id"];
      // petugasPendaftarC.text =
      //     selectedPetugassss.nikPetugas ?? argsData["petugasPendaftar"];
      print(fetchdata.selectedPetugasId.value);
      update();
    });

    originalIdPeternak = argsData["idPeternak"];
    originalNikPeternak = argsData["nikPeternak"];
    originalNamaPeternak = argsData["namaPeternak"];
    originalIdIskhnas = argsData["idISIKHNAS"];
    originalLokasi = argsData["lokasi"];
    originalPetugasPendaftar = argsData["petugas_id"];
    originalTanggalPendaftaran = argsData["tanggalPendaftaran"];
  }

  // //GET DATA PETUGAS
  // Future<List<PetugasModel>> fetchPetugas() async {
  //   try {
  //     final PetugasListModel petugasListModel =
  //         await PetugasApi().loadPetugasApi();
  //     final List<PetugasModel> petugass = petugasListModel.content ?? [];
  //     if (petugass.isNotEmpty) {
  //       selectedPetugas.value = petugass.first.nikPetugas ?? '';
  //     }
  //     petugasList.assignAll(petugass);
  //     return petugass;
  //   } catch (e) {
  //     print('Error fetching Petugas: $e');
  //     showErrorMessage("Error fetching Petugas: $e");
  //     return [];
  //   }
  // }

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
        idPeternakC.text = originalIdPeternak;
        nikPeternakC.text = originalNikPeternak;
        namaPeternakC.text = originalNamaPeternak;
        idISIKHNASC.text = originalIdIskhnas;
        lokasiC.text = originalLokasi;
        // selectedPetugas.value = originalPetugasPendaftar;
        petugasPendaftarC.text = originalPetugasPendaftar;
        tanggalPendaftaranC.text = originalTanggalPendaftaran;

        isEditing.value = false;
      },
    );
  }

  Future<void> deletePeternak() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Peternak",
      message: "Apakah anda ingin menghapus data Peternak ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        peternakModel =
            await PeternakApi().deletePeternakAPI(argsData["idPeternak"]);
        if (peternakModel != null) {
          if (peternakModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Peternak dengan ID: ${idPeternakC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Peternak ");
          }
        }
        final PeternakController peternakController =
            Get.put(PeternakController());
        peternakController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  Future<void> editPeternak() async {
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Peternak",
      message: "Apakah anda ingin mengedit data Peternak ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        print(tanggalPendaftaranC.text);
        peternakModel = await PeternakApi().editPeternakApi(
          idPeternakC.text,
          nikPeternakC.text,
          namaPeternakC.text,
          idISIKHNASC.text,
          lokasiC.text,
          fetchdata.selectedPetugasId.value,
          tanggalPendaftaranC.text,
        );
        isEditing.value = false;

        // await PetugasApi().editPetugasApi(argsData["nikPetugas"], argsData["namaPetugas"], argsData["noTelp"],argsData["email"]);
        if (peternakModel != null) {
          if (peternakModel!.status == 201) {
            showSuccessMessage(
                "Berhasil mengedit Peternak dengan ID: ${idPeternakC.text}");
          } else {
            showErrorMessage("Gagal mengedit Data Peternak ");
          }
        }
        final PeternakController peternakController =
            Get.put(PeternakController());
        peternakController.reInitialize();
        Get.back();
        Get.back(); // close modal
        update();
      },
    );
  }

  void updateFormattedDate(String newDate) {
    formattedDate.value = newDate;
  }

  late DateTime selectedDate = DateTime.now();

  Future<void> tanggalPendaftaran(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalPendaftaranC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
