// import 'package:get/get.dart'; // Untuk menggunakan GetXController dan RxBool
// import 'package:get_storage/get_storage.dart'; // Untuk menggunakan GetStorage
// import 'package:flutter/material.dart'; // Untuk menggunakan TextEditingController
// import 'package:crud_flutter_api/app/data/user_model.dart'; // Untuk menggunakan UserModel
// import 'package:crud_flutter_api/app/routes/app_pages.dart'; // Untuk menggunakan Routes
// import 'package:crud_flutter_api/app/services/auth_api.dart';

// class RegisterController extends GetxController {
//   UserModel? userModel;
//   final box = GetStorage();
//   RxBool isLoading = false.obs;
//   RxBool obsecureText = true.obs;
//   TextEditingController nameC = TextEditingController();
//   TextEditingController emailC = TextEditingController();
//   TextEditingController passC = TextEditingController();
//   Future registration() async {
//     update();
//     userModel =
//         await AuthApi().registerAPI(nameC.text, emailC.text, passC.text);
//     if (userModel!.status == 200) {
//       await box.write("token", userModel!.accessToken);
//       // await box.write("id", userModel!.id);
//       // await box.write("username", userModel!.username);
//       // await box.write("name", userModel!.name);
//       // await box.write("role", userModel!.role);

//       // await box.write("avatar", userModel!.avatar);

//       update();
//       Get.offAndToNamed(Routes.NAVIGATION);
//     } else if (userModel!.status == 404) {
//       update();
//     }
//   }
// }
