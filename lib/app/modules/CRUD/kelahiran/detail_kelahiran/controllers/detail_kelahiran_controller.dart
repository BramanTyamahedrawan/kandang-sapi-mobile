import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/kelahiran_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/kelahiran/controllers/kelahiran_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/services/kelahiran_api.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailKelahiranController extends GetxController {
  final box = GetStorage();
  String? get role => box.read('role');
  final FetchData fetchData = Get.put(FetchData());
  final KelahiranController kelahiranController =
      Get.put(KelahiranController());

  final Map<String, dynamic> argsData = Get.arguments;
  KelahiranModel? kelahiranModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;
  RxString selectedPeternakIdInEditMode = ''.obs;
  RxString selectedGender = ''.obs;
  RxString selectedSpesies = ''.obs;
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
  TextEditingController tanggalLahirC = TextEditingController();
  TextEditingController tanggalLaporanC = TextEditingController();
  TextEditingController idPeternakC = TextEditingController();
  TextEditingController kodeEartagNasionalC = TextEditingController();
  TextEditingController idKandangC = TextEditingController();
  TextEditingController idInseminasiC = TextEditingController();
  TextEditingController petugasPelaporC = TextEditingController();
  TextEditingController eartagAnakC = TextEditingController();
  TextEditingController jenisKelaminAnakC = TextEditingController();
  TextEditingController spesiesAnakC = TextEditingController();

  String originalidKejadian = "";
  String originaltanggalLaporan = "";
  String originaltanggalLahir = "";
  String originalidPeternak = "";
  String originalnamaPeternak = "";
  String originalkodeEartagNasional = "";
  String originalidKandang = "";
  String originalidInseminasi = "";
  String originalpetugasPelapor = "";
  String originaleartagAnak = "";
  String originaljenisKelaminAnak = "";
  String originalspesiesAnak = "";

  @override
  onClose() {
    idKejadianC.dispose();
    tanggalLaporanC.dispose();
    tanggalLahirC.dispose();
    idPeternakC.dispose();
    petugasPelaporC.dispose();

    eartagAnakC.dispose();
    jenisKelaminAnakC.dispose();
    spesiesAnakC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData.fetchPeternaks();
    fetchData.fetchHewan();
    fetchData.fetchPetugas();
    fetchData.fetchKandangs();
    fetchData.fetchInseminasi();

    fetchData.selectedPeternakId.listen((peternakId) {
      fetchData.filterHewanByPeternak(peternakId);
      fetchData.filterKandangByPeternak(peternakId);
      fetchData.filterInseminasiByPeternak(peternakId);
    });
    role;
    selectedSpesies(argsData["spesies_anak_detail"]);

    selectedGender(argsData["kelamin_anak_detail"]);

    idKejadianC.text = argsData["id_kejadian_detail"];
    tanggalLaporanC.text = argsData["tanggal_laporan_detail"];
    tanggalLahirC.text = argsData["tanggal_lahir_detail"];
    idPeternakC.text = argsData["id_peternak_detail"];
    kodeEartagNasionalC.text = argsData["kodeEartagNasional"];
    idKandangC.text = argsData["id_kandang_detail"];
    petugasPelaporC.text = argsData["petugas_pelapor_detail"];
    idInseminasiC.text = argsData["id_inseminasi_detail"];
    eartagAnakC.text = argsData["eartag_anak_detail"];
    jenisKelaminAnakC.text = argsData["kelamin_anak_detail"];
    spesiesAnakC.text = argsData["spesies_anak_detail"];

    ever(fetchData.selectedPeternakId, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PeternakModel? selectedPeternak = fetchData.peternakList.firstWhere(
          (peternak) => peternak.idPeternak == selectedId,
          orElse: () => PeternakModel());
      idPeternakC.text =
          selectedPeternak.namaPeternak ?? argsData["id_peternak_detail"];
      update();
    });

    ever(fetchData.selectedHewanEartag, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      HewanModel? selectedHewan = fetchData.hewanList.firstWhere(
          (peternak) => peternak.kodeEartagNasional == selectedId,
          orElse: () => HewanModel());
      kodeEartagNasionalC.text =
          selectedHewan.kodeEartagNasional ?? argsData["kodeEartagNasional"];
      update();
    });

    ever(fetchData.selectedPetugasId, (String? selectedName) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PetugasModel? selectedPetugassss = fetchData.petugasList.firstWhere(
          (petugas) => petugas.nikPetugas == selectedName,
          orElse: () => PetugasModel());
      fetchData.selectedPetugasId.value =
          selectedPetugassss.nikPetugas ?? argsData["petugas_pelapor_detail"];
      // namaPeternakC.text = selectedPetugassss.namaPetugas ??
      //     argsData["nama_peternak_hewan_detail"];
      //print(selectedPetugasId.value);
      update();
    });

    originalidKejadian = argsData["id_kejadian_detail"];
    originaltanggalLaporan = argsData["tanggal_laporan_detail"];
    originaltanggalLahir = argsData["tanggal_lahir_detail"];
    originalidPeternak = argsData["id_peternak_detail"];
    originalkodeEartagNasional = argsData["kodeEartagNasional"];
    originalidKandang = argsData["id_kandang_detail"];
    originalpetugasPelapor = argsData["petugas_pelapor_detail"];
    originalidInseminasi = argsData["id_inseminasi_detail"];
    originaleartagAnak = argsData["eartag_anak_detail"];
    originaljenisKelaminAnak = argsData["kelamin_anak_detail"];
    originalspesiesAnak = argsData["spesies_anak_detail"];
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
    selectedPeternakIdInEditMode.value = fetchData.selectedPeternakId.value;
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
        idKejadianC.text = originalidKejadian;
        tanggalLaporanC.text = originaltanggalLaporan;
        tanggalLahirC.text = originaltanggalLahir;
        idPeternakC.text = originalidPeternak;
        fetchData.selectedPeternakId.value = originalidPeternak;
        kodeEartagNasionalC.text = originalkodeEartagNasional;
        fetchData.selectedHewanEartag.value = originalkodeEartagNasional;
        petugasPelaporC.text = originalpetugasPelapor;
        fetchData.selectedPetugasId.value = originalpetugasPelapor;
        idKandangC.text = originalidKandang;
        fetchData.selectedKandangId.value = originalidKandang;
        idInseminasiC.text = originalidInseminasi;
        fetchData.selectedInseminasiId.value = originalidInseminasi;
        eartagAnakC.text = originaleartagAnak;
        jenisKelaminAnakC.text = originaljenisKelaminAnak;
        spesiesAnakC.text = originalspesiesAnak;
        selectedSpesies.value = originalspesiesAnak;
        selectedGender.value = originaljenisKelaminAnak;

        isEditing.value = false;
      },
    );
  }

  Future<void> deleteKelahiran() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data todo",
      message: "Apakah anda ingin menghapus data todo ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        kelahiranModel = await KelahiranApi()
            .deleteKelahiranAPI(argsData["id_kejadian_detail"]);
        if (kelahiranModel != null) {
          if (kelahiranModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Data Kelahiran dengan ID: ${idKejadianC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Kelahiran ");
          }
        }
        final KelahiranController kelahiranController =
            Get.put(KelahiranController());
        kelahiranController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  Future<void> editKelahiran() async {
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Kelahiran",
      message: "Apakah anda ingin mengedit data Kelahiran ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        kelahiranModel = await KelahiranApi().editKelahiranApi(
          idKejadianC.text,
          tanggalLaporanC.text,
          tanggalLahirC.text,
          fetchData.selectedPeternakId.value,
          fetchData.selectedHewanEartag.value,
          fetchData.selectedKandangId.value,
          fetchData.selectedInseminasiId.value,
          fetchData.selectedPetugasId.value,
          eartagAnakC.text,
          selectedGender.value,
          selectedSpesies.value,
        );
        isEditing.value = false;
        if (kelahiranModel != null) {
          if (kelahiranModel!.status == 201) {
            showSuccessMessage(
                "Berhasil Edit Data Kelahiran dengan ID: ${idKejadianC.text}");
          } else {
            showErrorMessage("Gagal Edit Data Kelahiran ");
          }
        }
        final KelahiranController kelahiranController =
            Get.put(KelahiranController());
        kelahiranController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
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
