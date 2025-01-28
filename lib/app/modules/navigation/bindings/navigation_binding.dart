import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../menu/menu_view/controllers/menu_controller.dart';
import '../../user/controllers/user_controller.dart';
import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MainMenuController>(
      () => MainMenuController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}
