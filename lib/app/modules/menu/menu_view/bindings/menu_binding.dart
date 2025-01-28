import 'package:get/get.dart';

import '../controllers/menu_controller.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMenuController>(
      () => MainMenuController(),
    );
  }
}
