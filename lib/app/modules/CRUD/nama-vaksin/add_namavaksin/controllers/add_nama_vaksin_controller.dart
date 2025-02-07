import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/nama-vaksin/controllers/namavaksin_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/namavaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNamaVaksinController extends GetxController {
  final FetchData fetchdata = FetchData();

  NamaVaksinModel? namaVaksinModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs;

  TextEditingController namaC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();
  @override
  onClose() {
    namaC.dispose();
    deskripsiC.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchdata.fetchJenisVaksin();
  }

  Future addNamaVaksin(BuildContext context) async {
    try {
      isLoading.value = true;

      if (fetchdata.selectedIdJenisVaksin.value.isEmpty) {
        throw "Pilih jenis vaksin terlebih dahulu.";
      }

      namaVaksinModel = await NamavaksinApi().addNamaVaksinAPI(
        fetchdata.selectedIdJenisVaksin.value,
        namaC.text,
        deskripsiC.text,
      );

      if (namaVaksinModel != null) {
        if (namaVaksinModel!.status == 201) {
          final NamaVaksinController namaVaksinController =
              Get.put(NamaVaksinController());
          namaVaksinController.reInitialize();
          Get.back();
          showSuccessMessage("Data Nama Vaksin Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Data Nama Vaksin dengan status ${namaVaksinModel?.status}");
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
}
