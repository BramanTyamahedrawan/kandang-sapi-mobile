import 'package:crud_flutter_api/app/modules/menu/menu_view/controllers/menu_controller.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final MainMenuController mainMenuController = Get.put(MainMenuController());
  //TODO: Implement NavigationController

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
    Get.reloadAll();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {}
  // void increment() => count.value++;
}
