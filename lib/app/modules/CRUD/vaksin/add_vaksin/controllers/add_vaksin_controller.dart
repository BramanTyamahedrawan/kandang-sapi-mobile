import 'package:crud_flutter_api/app/data/vaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/vaksin/controllers/vaksin_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/vaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddVaksinController extends GetxController {
  final FetchData fetchdata = FetchData();

  VaksinModel? vaksinModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs;

  TextEditingController idVaksinC = TextEditingController();
  TextEditingController batchVaksinC = TextEditingController();
  TextEditingController vaksinKeC = TextEditingController();
  TextEditingController tglVaksinC = TextEditingController();
  @override
  onClose() {
    idVaksinC.dispose();
    batchVaksinC.dispose();
    vaksinKeC.dispose();
    tglVaksinC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPeternaks();
    fetchdata.fetchHewan();
    fetchdata.fetchPetugas();
    fetchdata.fetchJenisVaksin();
    fetchdata.fetchNamaVaksin();

    fetchdata.selectedPeternakId.listen((peternakId) {
      fetchdata.filterHewanByPeternak(peternakId);
      fetchdata.filterKandangByPeternak(peternakId);
    });
  }

  Future addPost(BuildContext context) async {
    try {
      isLoading.value = true;

      if (fetchdata.selectedPeternakId.value.isEmpty &&
          fetchdata.selectedPeternakId.value == "") {
        throw "Pilih Peternak terlebih dahulu.";
      }
      if (fetchdata.selectedHewanEartag.value.isEmpty &&
          fetchdata.selectedHewanEartag.value == "") {
        throw "Pilih No Eartag Hewan terlebih dahulu.";
      }
      if (fetchdata.selectedIdNamaVaksin.value.isEmpty) {
        throw "Pilih Vaksin terlebih dahulu.";
      }
      if (fetchdata.selectedIdJenisVaksin.value.isEmpty) {
        throw "Pilih Jenis Vaksin terlebih dahulu.";
      }
      if (fetchdata.selectedPetugasId.value.isEmpty) {
        throw "Pilih Petugas terlebih dahulu.";
      }

      vaksinModel = await VaksinApi().addVaksinAPI(
          fetchdata.selectedPeternakId.value,
          fetchdata.selectedHewanEartag.value,
          fetchdata.selectedPetugasId.value,
          fetchdata.selectedIdNamaVaksin.value,
          fetchdata.selectedIdJenisVaksin.value,
          batchVaksinC.text,
          vaksinKeC.text,
          tglVaksinC.text);

      if (vaksinModel != null) {
        if (vaksinModel!.status == 201) {
          final VaksinController vaksinController = Get.put(VaksinController());
          vaksinController.reInitialize();
          Get.back();
          showSuccessMessage("Data Vaksin Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Data Vaksin dengan status ${vaksinModel?.status}");
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

  Future<void> tanggalIB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      tglVaksinC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
