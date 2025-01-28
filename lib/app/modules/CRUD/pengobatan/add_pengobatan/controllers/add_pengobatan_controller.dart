import 'package:crud_flutter_api/app/data/pengobatan_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/pengobatan/controllers/pengobatan_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/pengobatan_api..dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPengobatanController extends GetxController {
  final FetchData fetchdata = FetchData();

  PengobatanModel? pengobatanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs;
  TextEditingController idKasusC = TextEditingController();
  TextEditingController tanggalPengobatanC = TextEditingController();
  TextEditingController tanggalKasusC = TextEditingController();
  TextEditingController namaInfrastrukturC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController dosisC = TextEditingController();
  TextEditingController sindromC = TextEditingController();
  TextEditingController dignosaBandingC = TextEditingController();

  @override
  onClose() {
    idKasusC.dispose();
    tanggalPengobatanC.dispose();
    tanggalKasusC.dispose();
    namaInfrastrukturC.dispose();
    lokasiC.dispose();
    dosisC.dispose();
    sindromC.dispose();
    dignosaBandingC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchPetugas();
  }

  Future addPengobatan(BuildContext context) async {
    try {
      print(fetchdata.selectedPetugasId.value);
      isLoading.value = true;
      pengobatanModel = await PengobatanApi().addPengobatanAPI(
        idKasusC.text,
        tanggalPengobatanC.text,
        tanggalKasusC.text,
        fetchdata.selectedPetugasId.value,
        namaInfrastrukturC.text,
        lokasiC.text,
        dosisC.text,
        sindromC.text,
        dignosaBandingC.text,
      );

      if (pengobatanModel != null) {
        if (pengobatanModel!.status == 201) {
          final PengobatanController peternakController =
              Get.put(PengobatanController());
          peternakController.reInitialize();
          Get.back();
          showSuccessMessage("Peternak Baru berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Peternak dengan status ${pengobatanModel?.status}");
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
