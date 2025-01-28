import 'package:crud_flutter_api/app/data/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainMenuController extends GetxController {
  Rx<UserModel> user = UserModel().obs;
  final box = GetStorage();
  bool homeScreen = false;

  RxBool isAdmin = false.obs;
  RxBool isPetugas = false.obs;
  RxBool isUser = false.obs;

  @override
  void onInit() {
    setRoleFromAuthInfo(user.value);
    fetchUserData();
    super.onInit();
  }

  @override
  void onClose() {}

  void fetchUserData() {
    String role = box.read('role') ?? '';
    user.value = UserModel(role: role);
    setRoleFromAuthInfo(user.value);
  }

  void setRoleFromAuthInfo(UserModel user) {
    String role = user.role ?? '';

    isAdmin.value = role == 'ROLE_ADMINISTRATOR';
    isPetugas.value = role == 'ROLE_PETUGAS';
    isUser.value = role == 'ROLE_PETERNAK';

    // print(isAdmin.value);
    // print(isPetugas.value);
    // print(isUser.value);
    // print(role);
    // print(user);
    update();
  }
}
