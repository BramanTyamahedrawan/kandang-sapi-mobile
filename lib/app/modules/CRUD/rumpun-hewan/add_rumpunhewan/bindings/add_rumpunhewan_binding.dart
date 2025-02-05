import 'package:get/get.dart';

import '../controllers/add_rumpunhewan_controller.dart';

class AddRumpunHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRumpunHewanController>(
      () => AddRumpunHewanController(),
    );
  }
}
