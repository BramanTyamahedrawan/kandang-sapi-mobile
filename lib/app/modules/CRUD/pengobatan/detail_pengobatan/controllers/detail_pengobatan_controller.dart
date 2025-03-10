import 'package:crud_flutter_api/app/data/pengobatan_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/pengobatan/controllers/pengobatan_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/pengobatan_api..dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPengobatanController extends GetxController {
  final FetchData fetchData = FetchData();
  final PengobatanController pengobatanController =
      Get.put(PengobatanController());

  final Map<String, dynamic> argsData = Get.arguments;
  PengobatanModel? pengobatanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  String orginalIdPengobatan = "";
  String originalIdKasus = "";
  String originalTanggalPengobatan = "";
  String originalTanggalKasus = "";
  String originalNamaPetugas = "";
  String originalNamaInfrastuktur = "";
  String originalLokasi = "";
  String originalDosis = "";
  String originalSindrom = "";
  String originalDiagnosa = "";
  String originalProvinsiPengobatan = "";
  String originalKabupatenPengobatan = "";
  String originalKecamatanPengobatan = "";
  String originalDesaPengobatan = "";

  TextEditingController idPengobatanC = TextEditingController();
  TextEditingController idKasusC = TextEditingController();
  TextEditingController tanggalPengobatanC = TextEditingController();
  TextEditingController tanggalKasusC = TextEditingController();
  TextEditingController namaPetugasC = TextEditingController();
  TextEditingController namaInfrastrukturC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController dosisC = TextEditingController();
  TextEditingController sindromC = TextEditingController();
  TextEditingController diagnosaBandingC = TextEditingController();
  TextEditingController provinsiPengobatanC = TextEditingController();
  TextEditingController kabupatenPengobatanC = TextEditingController();
  TextEditingController kecamatanPengobatanC = TextEditingController();
  TextEditingController desaPengobatanC = TextEditingController();

  @override
  onClose() {
    idPengobatanC.dispose();
    idKasusC.dispose();
    tanggalPengobatanC.dispose();
    tanggalKasusC.dispose();
    namaPetugasC.dispose();
    namaInfrastrukturC.dispose();
    lokasiC.dispose();
    dosisC.dispose();
    sindromC.dispose();
    diagnosaBandingC.dispose();
    provinsiPengobatanC.dispose();
    kabupatenPengobatanC.dispose();
    kecamatanPengobatanC.dispose();
    desaPengobatanC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData.fetchPetugas();
    if (Get.arguments != null) {
      fetchData.selectedPetugasId.value = Get.arguments["petugasId"] ?? "";
    }

    idPengobatanC.text = argsData["idPengobatan"];
    idKasusC.text = argsData["idKasus"];
    tanggalPengobatanC.text = argsData["tanggalPengobatan"];
    tanggalKasusC.text = argsData["tanggalKasus"];
    namaPetugasC.text = argsData["namaPetugas"];
    namaInfrastrukturC.text = argsData["namaInfrastruktur"];
    lokasiC.text = argsData["lokasi"];
    dosisC.text = argsData["dosis"];
    sindromC.text = argsData["sindrom"];
    diagnosaBandingC.text = argsData["diagnosaBanding"];

    ever(fetchData.selectedPetugasId, (String? selectedName) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PetugasModel? selectedPetugassss = fetchData.petugasList.firstWhere(
          (petugas) => petugas.petugasId == selectedName,
          orElse: () => PetugasModel());
      // selectedPetugasId.value = selectedPetugassss.nikPetugas ??
      //     argsData["petugas_terdaftar_hewan_detail"];
      namaPetugasC.text =
          selectedPetugassss.namaPetugas ?? argsData["namaPetugas"];
      //print(selectedPetugasId.value);
      update();
    });

    // Buat batal edit
    orginalIdPengobatan = argsData["idPengobatan"];
    originalIdKasus = argsData["idKasus"];
    originalTanggalPengobatan = argsData["tanggalPengobatan"];
    originalTanggalKasus = argsData["tanggalKasus"];
    originalNamaPetugas = argsData["namaPetugas"];
    originalNamaInfrastuktur = argsData["namaInfrastruktur"];
    originalLokasi = argsData["lokasi"];
    originalDosis = argsData["dosis"];
    originalSindrom = argsData["sindrom"];
    originalDiagnosa = argsData["diagnosaBanding"];
    originalProvinsiPengobatan = argsData["provinsiPengobatan"];
    originalKabupatenPengobatan = argsData["kabupatenPengobatan"];
    originalKecamatanPengobatan = argsData["kecamatanPengobatan"];
    originalDesaPengobatan = argsData["desaPengobatan"];
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
    refresh();
    update();
  }

  Future<void> tutupEdit() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Batal Edit",
      message: "Apakah anda ingin keluar dari edit ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        // Reset data ke yang sebelumnya
        idPengobatanC.text = orginalIdPengobatan;
        idKasusC.text = originalIdKasus;
        tanggalPengobatanC.text = originalTanggalPengobatan;
        tanggalKasusC.text = originalTanggalKasus;
        namaPetugasC.text = originalNamaPetugas;
        namaInfrastrukturC.text = originalNamaInfrastuktur;
        lokasiC.text = originalLokasi;
        dosisC.text = originalDosis;
        sindromC.text = originalSindrom;
        diagnosaBandingC.text = originalDiagnosa;
        provinsiPengobatanC.text = originalProvinsiPengobatan;
        kabupatenPengobatanC.text = originalKabupatenPengobatan;
        kecamatanPengobatanC.text = originalKecamatanPengobatan;
        desaPengobatanC.text = originalDesaPengobatan;

        final PengobatanController pengobatanController =
            Get.put(PengobatanController());
        pengobatanController.reInitialize();

        isEditing.value = false;

        Get.back();
        update();
      },
    );
  }

  Future<void> deletePengobatan() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Pengobatan",
      message: "Apakah anda ingin menghapus data ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        pengobatanModel =
            await PengobatanApi().deletePengobatanAPI(argsData["idPengobatan"]);

        if (pengobatanModel != null) {
          if (pengobatanModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Data Pengobatan dengan ID: ${idKasusC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Pengobatan ");
          }
        }

        final PengobatanController pengobatanController =
            Get.put(PengobatanController());
        pengobatanController.reInitialize();
        update();
        Get.back();
        Get.back();
      },
    );
  }

  Future<void> editPengobatan() async {
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Pengobatan",
      message: "Apakah anda ingin mengedit data Pengobatan ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        try {
          final response = await PengobatanApi().editPengobatanApi(
            idPengobatanC.text,
            idKasusC.text,
            tanggalPengobatanC.text,
            tanggalKasusC.text,
            fetchData.selectedPetugasId.value,
            namaInfrastrukturC.text,
            lokasiC.text,
            dosisC.text,
            sindromC.text,
            diagnosaBandingC.text,
            provinsiPengobatanC.text,
            kabupatenPengobatanC.text,
            kecamatanPengobatanC.text,
            desaPengobatanC.text,
          );

          if (response != null) {
            pengobatanModel = response;

            if (pengobatanModel!.status == 201 ||
                pengobatanModel!.message == "Data Pengobatan Berhasil Diubah") {
              showSuccessMessage("Berhasil mengedit Data Pengobatan");
              update();
              Get.back();
              Get.back();
            } else {
              showErrorMessage(
                  "Gagal mengedit Data Pengobatan ${pengobatanModel?.message ?? 'Unknown Error'}");
            }
          } else {
            showErrorMessage("Gagal mendapatkan respons dari server.");
          }
        } catch (e) {
          showErrorMessage("Terjadi Kesalahan ${e.toString()}");
        } finally {
          final PengobatanController pengobatanController =
              Get.put(PengobatanController());
          pengobatanController.reInitialize();
          update();
          isLoading.value = false;
          isEditing.value = false;
        }
      },
    );
  }

  late DateTime selectedDate = DateTime.now();
  late DateTime selectedDate1 = DateTime.now();

  Future<void> tanggalPengobatan(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalPengobatanC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  Future<void> tanggalKasus(BuildContext context) async {
    final DateTime? picked1 = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked1 != null && picked1 != selectedDate1) {
      selectedDate1 = picked1;
      tanggalKasusC.text = DateFormat('dd/MM/yyyy').format(picked1);
    }
  }
}
