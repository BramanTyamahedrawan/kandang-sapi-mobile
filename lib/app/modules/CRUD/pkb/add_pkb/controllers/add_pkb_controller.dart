import 'package:crud_flutter_api/app/data/pkb_model.dart';
import 'package:crud_flutter_api/app/modules/menu/PKB/controllers/pkb_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/pkb_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPkbController extends GetxController {
  final FetchData fecthaddData = FetchData();

  PKBModel? pkbModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs; // Gunakan .obs untuk membuat Rx variabel
  RxString selectedSpesies = 'Sapi'.obs;
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

  TextEditingController idPeternakC = TextEditingController();
  TextEditingController jumlahC = TextEditingController();
  TextEditingController kategoriC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController umurKebuntinganC = TextEditingController();
  TextEditingController pemeriksaKebuntinganC = TextEditingController();
  TextEditingController tanggalPkbC = TextEditingController();
  @override
  onClose() {
    idKejadianC.dispose();
    idPeternakC.dispose();
    jumlahC.dispose();
    kategoriC.dispose();
    lokasiC.dispose();
    umurKebuntinganC.dispose();
    pemeriksaKebuntinganC.dispose();
    tanggalPkbC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fecthaddData.fetchPeternaks();
    fecthaddData.fetchHewan();
    fecthaddData.fetchPetugas();

    fecthaddData.selectedPeternakId.listen((peternakId) {
      fecthaddData.filterHewanByPeternak(peternakId);
      fecthaddData.filterKandangByPeternak(peternakId);
    });
    update();
  }

  Future addPKB(BuildContext context) async {
    try {
      isLoading.value = true;
      pkbModel = await PKBApi().addPKBAPI(
        idKejadianC.text,
        fecthaddData.selectedPeternakId.value,
        fecthaddData.selectedHewanEartag.value,
        fecthaddData.selectedPetugasId.value,
        selectedSpesies.value,
        umurKebuntinganC.text,
        tanggalPkbC.text,
      );

      if (pkbModel != null) {
        if (pkbModel?.status == 201) {
          final PKBController pkbController = Get.put(PKBController());
          pkbController.reInitialize();
          Get.back();
          showSuccessMessage("Kelahiran Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Kelahiran dengan status ${pkbModel?.status}");
        }
      }
    } catch (e) {
      showCupertinoDialog(
        context: context, // Gunakan context yang diberikan sebagai parameter.
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Kesalahan"),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updateFormattedDate(String newDate) {
    formattedDate.value = newDate;
  }

  late DateTime selectedDate = DateTime.now();

  Future<void> tanggalPkb(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tanggalPkbC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
