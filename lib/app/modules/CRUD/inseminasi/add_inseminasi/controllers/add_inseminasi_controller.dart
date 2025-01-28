import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/menu/inseminasi/controllers/inseminasi_controller.dart';
import 'package:crud_flutter_api/app/services/fetch_data.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../../../services/inseminasi_api.dart';

class AddInseminasiController extends GetxController {
  final FetchData fetchdata = FetchData();

  InseminasiModel? inseminasiModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  final formattedDate = ''.obs; // Gunakan .obs untuk membuat Rx variabel

  RxString selectedSpesies = 'Sapi'.obs;
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

  TextEditingController idInseminasiC = TextEditingController();
  TextEditingController idPembuatanC = TextEditingController();
  TextEditingController idPejantanC = TextEditingController();
  TextEditingController bangsaPejantanC = TextEditingController();
  TextEditingController ibC = TextEditingController();
  // TextEditingController ib2C = TextEditingController();
  // TextEditingController ib3C = TextEditingController();
  // TextEditingController ibLainC = TextEditingController();
  TextEditingController produsenC = TextEditingController();
  TextEditingController idPeternakC = TextEditingController();
  //TextEditingController lokasiC = TextEditingController();
  TextEditingController tanggalIBC = TextEditingController();
  @override
  onClose() {
    idInseminasiC.dispose();
    idPembuatanC.dispose();
    idPejantanC.dispose();
    bangsaPejantanC.dispose();
    ibC.dispose();
    // ib2C.dispose();
    // ib3C.dispose();
    // ibLainC.dispose();
    produsenC.dispose();
    idPeternakC.dispose();
    // lokasiC.dispose();
    tanggalIBC.dispose();
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
  }

//ADD INSEMINASI
  Future addInseminasi(BuildContext context) async {
    try {
      isLoading.value = true;
      inseminasiModel = await InseminasiApi().addInseminasiAPI(
          idInseminasiC.text,
          fetchdata.selectedHewanEartag.value,
          idPembuatanC.text,
          idPejantanC.text,
          //bangsaPejantanC.text,
          selectedSpesies.value,
          ibC.text,
          // ib2C.text,
          // ib3C.text,
          // ibLainC.text,
          produsenC.text,
          fetchdata.selectedPeternakId.value,
          // lokasiC.text,
          fetchdata.selectedPetugasId.value,
          tanggalIBC.text);

      if (inseminasiModel != null) {
        if (inseminasiModel!.status == 201) {
          final InseminasiController inseminasiController =
              Get.put(InseminasiController());
          inseminasiController.reInitialize();
          Get.back();
          showSuccessMessage("Data Inseminasi Baru Berhasil ditambahkan");
        } else if (inseminasiModel!.status == 404) {
          showErrorMessage(
              "Gagal menambahkan Data Inseminasi dengan status ${inseminasiModel?.status}");
        }
      }
    } catch (e) {
      showCupertinoDialog(
        context: context, // context yang diberikan sebagai parameter.
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
      tanggalIBC.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
}
