import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/inseminasi/controllers/inseminasi_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/inseminasi_api.dart';
import 'package:crud_flutter_api/app/widgets/message/custom_alert_dialog.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailInseminasiController extends GetxController {
  final box = GetStorage();
  String? get role => box.read('role');
  final FetchData fetchdata = FetchData();
  final InseminasiController inseminasiController = InseminasiController();
  //TODO: Implement DetailPostController
  final Map<String, dynamic> argsData = Get.arguments;
  InseminasiModel? inseminasiModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  RxBool isEditing = false.obs;

  RxString selectedPeternakIdInEditMode = ''.obs;

  RxString selectedSpesies = ''.obs;
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

  TextEditingController idInseminasiC = TextEditingController();
  TextEditingController tanggalIBC = TextEditingController();
  //TextEditingController lokasiC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController idPeternakC = TextEditingController();
  //TextEditingController idHewanC = TextEditingController();
  TextEditingController kodeEartagNasionalC = TextEditingController();
  TextEditingController ibC = TextEditingController();
  // TextEditingController ib2C = TextEditingController();
  // TextEditingController ib3C = TextEditingController();
  // TextEditingController ibLainC = TextEditingController();
  TextEditingController idPejantanC = TextEditingController();
  TextEditingController idPembuatanC = TextEditingController();
  TextEditingController bangsaPejantanC = TextEditingController();
  TextEditingController produsenC = TextEditingController();
  TextEditingController inseminatorC = TextEditingController();

  String originalIdInseminasi = "";
  String originalTanggalIB = "";
  // String originalLokasi = "";
  String originalNamaPeternak = "";
  String originalIdPeternak = "";
  //String originalIdHewan = "";
  String originalEartag = "";
  String originalIb = "";
  // String originalIb2 = "";
  // String originalIb3 = "";
  // String originalIbLain = "";
  String originalIdPejantan = "";
  String originalIdPembuatan = "";
  String originalBangsaPejantan = "";
  String originalProdusen = "";
  String originalInseminator = "";

  @override
  onClose() {
    idInseminasiC.dispose();
    tanggalIBC.dispose();
    // lokasiC.dispose();
    namaPeternakC.dispose();
    idPeternakC.dispose();
    //idHewanC.dispose();
    kodeEartagNasionalC.dispose();
    ibC.dispose();
    // ib2C.dispose();
    // ib3C.dispose();
    // ibLainC.dispose();
    idPejantanC.dispose();
    idPembuatanC.dispose();
    bangsaPejantanC.dispose();
    produsenC.dispose();
    inseminatorC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPeternaks();
    fetchdata.fetchHewan();
    fetchdata.fetchPetugas();

    fetchdata.selectedPeternakId.listen((peternakId) {
      fetchdata.filterHewanByPeternak(peternakId);
      fetchdata.filterKandangByPeternak(peternakId);
    });
    role;
    selectedSpesies(argsData["bangsaPejantan"]);
    isEditing.value = false;
    idInseminasiC.text = argsData["idInseminasi"];
    tanggalIBC.text = argsData["tanggalIB"];
    // lokasiC.text = argsData["lokasi"];
    namaPeternakC.text = argsData["namaPeternak"];
    idPeternakC.text = argsData["idPeternak"];
    //idHewanC.text = argsData["idHewan"];
    kodeEartagNasionalC.text = argsData["kodeEartagNasional"];
    ibC.text = argsData["ib"];
    // ib2C.text = argsData["ib2"];
    // ib3C.text = argsData["ib3"];
    // ibLainC.text = argsData["ibLain"];
    idPejantanC.text = argsData["idPejantan"];
    idPembuatanC.text = argsData["idPembuatan"];
    bangsaPejantanC.text = argsData["bangsaPejantan"];
    produsenC.text = argsData["produsen"];
    inseminatorC.text = argsData["inseminator"];

    ever(fetchdata.selectedPeternakId, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PeternakModel? selectedPeternak = fetchdata.peternakList.firstWhere(
          (peternak) => peternak.idPeternak == selectedId,
          orElse: () => PeternakModel());
      namaPeternakC.text =
          selectedPeternak.namaPeternak ?? argsData["namaPeternak"];
      update();
    });

    ever(fetchdata.selectedHewanEartag, (String? selectedId) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      HewanModel? selectedHewan = fetchdata.hewanList.firstWhere(
          (peternak) => peternak.kodeEartagNasional == selectedId,
          orElse: () => HewanModel());
      kodeEartagNasionalC.text =
          selectedHewan.kodeEartagNasional ?? argsData["kodeEartagNasional"];
      update();
    });

    ever(fetchdata.selectedPetugasId, (String? selectedName) {
      // Perbarui nilai nikPeternakC dan namaPeternakC berdasarkan selectedId
      PetugasModel? selectedPetugassss = fetchdata.petugasList.firstWhere(
          (petugas) => petugas.nikPetugas == selectedName,
          orElse: () => PetugasModel());
      fetchdata.selectedPetugasId.value =
          selectedPetugassss.nikPetugas ?? argsData["inseminator"];
      // inseminatorC.text =
      //     selectedPetugassss.nikPetugas ?? argsData["inseminator"];
      //print(selectedPetugasId.value);
      update();
    });

    originalIdInseminasi = argsData["idInseminasi"];
    originalTanggalIB = argsData["tanggalIB"];
    //originalLokasi = argsData["lokasi"];
    originalNamaPeternak = argsData["namaPeternak"];
    originalIdPeternak = argsData["idPeternak"];
    //originalIdHewan = argsData["idHewan"];
    originalEartag = argsData["kodeEartagNasional"];
    originalIb = argsData["ib"];
    // originalIb2 = argsData["ib2"];
    // originalIb3 = argsData["ib3"];
    // originalIbLain = argsData["ibLain"];
    originalIdPejantan = argsData["idPejantan"];
    originalIdPembuatan = argsData["idPembuatan"];
    originalBangsaPejantan = argsData["bangsaPejantan"];
    originalProdusen = argsData["produsen"];
    originalInseminator = argsData["inseminator"];
  }

  Future<void> tombolEdit() async {
    isEditing.value = true;
    selectedPeternakIdInEditMode.value = fetchdata.selectedPeternakId.value;
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
        idInseminasiC.text = originalIdInseminasi;
        tanggalIBC.text = originalTanggalIB;
        //  lokasiC.text = originalLokasi;
        namaPeternakC.text = originalNamaPeternak;
        idPeternakC.text = originalIdPeternak;
        //idHewanC.text = originalIdHewan;
        fetchdata.selectedPeternakId.value = originalIdPeternak;
        kodeEartagNasionalC.text = originalEartag;
        ibC.text = originalIb;
        // ib2C.text = originalIb2;
        // ib3C.text = originalIb3;
        // ibLainC.text = originalIbLain;
        idPejantanC.text = originalIdPejantan;
        idPembuatanC.text = originalIdPembuatan;
        bangsaPejantanC.text = originalBangsaPejantan;
        produsenC.text = originalProdusen;
        inseminatorC.text = originalInseminator;

        isEditing.value = false;
      },
    );
  }

  Future<void> deleteInseminasi() async {
    CustomAlertDialog.showPresenceAlert(
      title: "Hapus data Insemiansi",
      message: "Apakah anda ingin menghapus data Inseminasi ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        inseminasiModel =
            await InseminasiApi().deleteInseminasiAPI(argsData["idInseminasi"]);

        if (inseminasiModel != null) {
          if (inseminasiModel!.status == 200) {
            showSuccessMessage(
                "Berhasil Hapus Data Inseminsai dengan ID: ${idInseminasiC.text}");
          } else {
            showErrorMessage("Gagal Hapus Data Inseminasi");
          }
        }
        final InseminasiController inseminasiController =
            Get.put(InseminasiController());
        inseminasiController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  Future<void> editInseminasi() async {
    CustomAlertDialog.showPresenceAlert(
      title: "edit data Inseminasi",
      message: "Apakah anda ingin mengedit data Inseminasi ini ?",
      onCancel: () => Get.back(),
      onConfirm: () async {
        print(idInseminasiC.text);
        print(fetchdata.selectedHewanEartag.value);
        print(tanggalIBC.text);
        //  print(lokasiC.text);
        print(namaPeternakC.text);
        print(fetchdata.selectedPeternakId.value);
        print(ibC.text);
        //  print(ib2C.text);
        //  print(ib3C.text);
        //   print(ibLainC.text);
        print(idPembuatanC.text);
        print(bangsaPejantanC.text);
        print(produsenC.text);
        print(fetchdata.selectedPetugasId.value);
        inseminasiModel = await InseminasiApi().editInseminasiApi(
          idInseminasiC.text,
          fetchdata.selectedHewanEartag.value,
          idPejantanC.text,
          idPembuatanC.text,
          selectedSpesies.value,
          // idHewanC.text,
          ibC.text,
          // ib2C.text,
          // ib3C.text,
          // ibLainC.text,
          produsenC.text,
          fetchdata.selectedPeternakId.value,
          // idPeternakC.text,
          // namaPeternakC.text,
          //      lokasiC.text,
          fetchdata.selectedPetugasId.value,
          tanggalIBC.text,
        );
        isEditing.value = false;

        if (inseminasiModel != null) {
          if (inseminasiModel!.status == 201) {
            showSuccessMessage(
                "Berhasil Edit Data Inseminsai dengan ID: ${idInseminasiC.text}");
          } else {
            showErrorMessage("Gagal Edit Data Inseminasi");
          }
        }

        final InseminasiController inseminasiController =
            Get.put(InseminasiController());
        inseminasiController.reInitialize();
        Get.back();
        Get.back();
        update();
      },
    );
  }

  late DateTime selectedDate = DateTime.now();

  Future<void> tanggalIB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalIBC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
