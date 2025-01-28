import 'dart:async';

import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/user_model.dart';
import 'package:crud_flutter_api/app/modules/menu/peternak/controllers/peternak_controller.dart';
import 'package:crud_flutter_api/app/services/auth_api.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPeternakController extends GetxController {
  final FetchData fetchdata = FetchData();
  UserModel? userModel;
  PeternakModel? peternakModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs; // Gunakan .obs untuk membuat Rx variabel

  TextEditingController idPeternakC = TextEditingController();
  TextEditingController nikPeternakC = TextEditingController();
  TextEditingController namaPeternakC = TextEditingController();
  TextEditingController idISIKHNASC = TextEditingController();
  TextEditingController lokasiC = TextEditingController();
  TextEditingController tanggalPendaftaranC = TextEditingController();

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
  }

  Future addUser(BuildContext context) async {
    userModel = await AuthApi().addUserAPI(
      namaPeternakC.text, // name
      nikPeternakC.text, // username
      nikPeternakC.text + '@gmail.com', // email
      nikPeternakC.text, //password
      '3', //role peternak
    );
  }

  Future addPeternak(BuildContext context) async {
    try {
      isLoading.value = true;
      print(idPeternakC.text);
      print(nikPeternakC.text);
      print(namaPeternakC.text);
      print(idISIKHNASC.text);
      print(idISIKHNASC.text);
      print(lokasiC.text);
      print(fetchdata.selectedPetugasId.value);
      print(tanggalPendaftaranC.text);
      peternakModel = await PeternakApi().addPeternakAPI(
          idPeternakC.text,
          nikPeternakC.text,
          namaPeternakC.text,
          idISIKHNASC.text,
          lokasiC.text,
          fetchdata.selectedPetugasId.value,
          tanggalPendaftaranC.text);

      if (peternakModel != null) {
        if (peternakModel!.status == 201) {
          final PeternakController peternakController =
              Get.put(PeternakController());
          peternakController.reInitialize();
          Get.back();
          showSuccessMessage("Peternak Baru berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan Peternak dengan status ${peternakModel?.status}");
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
