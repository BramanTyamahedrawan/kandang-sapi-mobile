import 'package:get/get.dart';

import '../controllers/add_hewan_controller.dart';

class AddHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddHewanController>(
      () => AddHewanController(),
    );
  }
}
