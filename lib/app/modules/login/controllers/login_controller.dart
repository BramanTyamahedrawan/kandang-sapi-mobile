// import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
// import 'package:get/get.dart'; // Untuk menggunakan GetXController dan RxBool
// import 'package:get_storage/get_storage.dart'; // Untuk menggunakan GetStorage
// import 'package:flutter/material.dart'; // Untuk menggunakan TextEditingController
// import 'package:crud_flutter_api/app/data/user_model.dart'; // Untuk menggunakan UserModel
// import 'package:crud_flutter_api/app/routes/app_pages.dart'; // Untuk menggunakan Routes
// import 'package:crud_flutter_api/app/services/auth_api.dart'; // Untuk menggunakan AuthApi

// class LoginController extends GetxController {
//   UserModel? userModel;
//   final box = GetStorage();
//   bool loginScreen = false;
//   RxBool isLoading = false.obs;
//   RxBool obsecureText = true.obs;
//   TextEditingController emailC = TextEditingController();
//   TextEditingController passC = TextEditingController();

//   Future login() async {
//     loginScreen = false;
//     update();
//     try {
//       userModel = await AuthApi().loginAPI(emailC.text, passC.text);

//       if (userModel != null) {
//         if (userModel!.status == 200) {
//           await box.write("id", userModel!.id);
//           await box.write("username", userModel!.username);
//           await box.write("name", userModel!.name);
//           await box.write("role", userModel!.role);
//           await box.write("email", userModel!.email);
//           await box.write("avatar", userModel!.avatar);
//           await box.write("token", userModel!.accessToken);
//           update();
//           Get.offAndToNamed(Routes.NAVIGATION);
//         } else if (userModel!.status == 401) {
//           loginScreen = true;
//           update();
//         }
//       } else {
//         showErrorMessage("error");
//         print("Login failed: User data not available");
//       }
//     } catch (e) {
//       // Handle kesalahan lain yang mungkin terjadi selama login
//       // print("Login error: $e");
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter_api/app/data/user_model.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:crud_flutter_api/app/services/auth_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';

class LoginController extends GetxController {
  UserModel? userModel;
  final box = GetStorage();
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  Future<void> login() async {
    isLoading.value = true;
    try {
      userModel = await AuthApi().loginAPI(emailC.text, passC.text);

      if (userModel != null) {
        if (userModel!.status == 200) {
          await box.write("id", userModel!.id);
          await box.write("username", userModel!.username);
          await box.write("name", userModel!.name);
          await box.write("role", userModel!.role);
          await box.write("email", userModel!.email);
          await box.write("avatar", userModel!.avatar);
          await box.write("token", userModel!.accessToken);
          Get.offAndToNamed(Routes.NAVIGATION);
        } else if (userModel!.status == 401) {
          showErrorMessage("Username atau Password salah");
        } else {
          showErrorMessage("Login gagal. Silakan coba lagi.");
        }
      } else {
        showErrorMessage("Data pengguna tidak tersedia.");
      }
    } catch (e) {
      showErrorMessage(
          "Terjadi kesalahan: 'PASSWORD atau USERNAME Tidak sesuai' ");
    } finally {
      isLoading.value = false;
    }
  }
}

//   Future login() async {
//     loginScreen = false;
//     update();
//     userModel = await AuthApi().loginAPI(emailC.text, passC.text);
//     //print(userModel!.accessToken);
    
//     if (userModel!.status == 200) {
//       await box.write("id", userModel!.id);
//       await box.write("username", userModel!.username);
//       await box.write("name", userModel!.name);
//       await box.write("role", userModel!.role);
//       await box.write("email", userModel!.email);
//       await box.write("avatar", userModel!.avatar);
//       await box.write("token", userModel!.accessToken);
//       update();
//       Get.offAndToNamed(Routes.NAVIGATION);
//     } else if (userModel!.status == 401) {
//       loginScreen = true;
//       update();
//     }
//   }
// }
