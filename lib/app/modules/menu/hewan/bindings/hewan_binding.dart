import 'package:get/get.dart';

import '../controllers/hewan_controller.dart';

class HewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HewanController>(
      () => HewanController(),
    );
  }
}
