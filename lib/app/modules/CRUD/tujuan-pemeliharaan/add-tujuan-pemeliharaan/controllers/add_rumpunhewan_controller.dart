import 'package:crud_flutter_api/app/data/TujuanPemeliharaan_model.dart';
import 'package:crud_flutter_api/app/modules/menu/tujuan-pemeliharaan/controllers/tujuanpemeliharaan_controller.dart';
import 'package:crud_flutter_api/app/services/tujuanpemeliharaan_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:crud_flutter_api/app/widgets/message/successMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddTujuanPemeliharaanController extends GetxController {
  TujuanPemeliharaanModel? tujuanPemeliharaanModel;
  RxBool isLoading = false.obs;
  RxBool isLoadingCreateTodo = false.obs;
  TextEditingController tujuanPemeliharaanC = TextEditingController();
  TextEditingController deskripsiC = TextEditingController();

  @override
  onClose() {
    tujuanPemeliharaanC.dispose();
    deskripsiC.dispose();
  }

  Future AddTujuanPemeliharaan(BuildContext context) async {
    try {
      isLoading.value = true;

      if (tujuanPemeliharaanC.text.isEmpty) {
        throw "Tujuan Pemeliharaan tidak boleh kosong.";
      }

      if (deskripsiC.text.isEmpty) {
        throw "Deskripsi tidak boleh kosong.";
      }

      tujuanPemeliharaanModel = await TujuanPemeliharaanApi()
          .addTujuanPemeliharaanApi(tujuanPemeliharaanC.text, deskripsiC.text);

      if (tujuanPemeliharaanModel != null) {
        if (tujuanPemeliharaanModel?.status == 201) {
          final TujuanPemeliharaanController tujuanPemeliharaanController =
              Get.put(TujuanPemeliharaanController());
          tujuanPemeliharaanController.reInitialize();
          Get.back();
          showSuccessMessage("Tujuan Pemeliharaan Baru Berhasil ditambahkan");
        } else {
          showErrorMessage(
              "Gagal menambahkan tujuan pemeliharaan dengan status ${tujuanPemeliharaanModel?.status}");
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

// class AddJenisHewanController extends GetxController {
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
//     petugasModel = await PetugasApi().AddJenisHewanApi(nikC.text, namaC.text);
//     if (petugasModel!.status == 200) {
//       update();
//       Get.offAndToNamed(Routes.HOME); //ganti route sesuai data menu
//     } else if (petugasModel!.status == 404) {
//       update();
//     }
//   }


// }
