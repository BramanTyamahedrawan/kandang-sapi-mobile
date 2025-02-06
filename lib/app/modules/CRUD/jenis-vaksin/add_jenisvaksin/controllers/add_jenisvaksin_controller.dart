import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/modules/menu/jenis-vaksin/controllers/jenisvaksin_controller.dart';
import 'package:crud_flutter_api/app/services/jenisvaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddJenisVaksinController extends GetxController {
  JenisVaksinModel? jenisVaksinModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  TextEditingController jenisC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  @override
  onClose() {
    jenisC.dispose();
    deskripsiC.dispose();
  }

  Future AddJenisVaksin(BuildContext context) async {
    try {
      isLoading.value = true;

      if (jenisC.text.isEmpty) {
        throw "Jenis Vaksin tidak boleh kosong.";
      }

      if (deskripsiC.text.isEmpty) {
        throw "Deskripsi tidak boleh kosong.";
      }

      jenisVaksinModel =
          await JenisVaksinApi().addJenisVaksinApi(jenisC.text, deskripsiC.text);

      if (jenisVaksinModel != null) {
        if (jenisVaksinModel?.status == 201) {
          final JenisVaksinController jenisVaksinController =
              Get.put(JenisVaksinController());
          jenisVaksinController.reInitialize();
          Get.back();
          showSuccessMessage("Jenis Vaksin Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan jenis Vaksin dengan status ${jenisVaksinModel?.status}");
        }
      }
    } catch (e) {
      // Tangani error di sini
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


















// import 'package:crud_flutter_api/app/data/petugas_model.dart';
// import 'package:crud_flutter_api/app/routes/app_pages.dart';
// import 'package:crud_flutter_api/app/services/petugas_api.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class AddJenisVaksinController extends GetxController {
//   PetugasModel? petugasModel;
//   RxBool isLoading = false.obs;
//   RxBool isLoadingCreateTodo = false.obs;
//   TextEditingController nikC = TextEditingController();
//   TextEditingController namaC = TextEditingController();
//   TextEditingController notlpC = TextEditingController();
//   TextEditingController emailC = TextEditingController();

//   @override
//   onClose() {
//     nikC.dispose();
//     namaC.dispose();
//     notlpC.dispose();
//     emailC.dispose();
//   }

//   Future addPost() async {
//     update();
//     petugasModel = await PetugasApi().AddJenisVaksinApi(nikC.text, namaC.text);
//     if (petugasModel!.status == 200) {
//       update();
//       Get.offAndToNamed(Routes.HOME); //ganti route sesuai data menu
//     } else if (petugasModel!.status == 404) {
//       update();
//     }
//   }


// }
