import 'package:get/get.dart';

import '../controllers/rumpunhewan_controller.dart';

class RumpunHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RumpunHewanController>(
      () => RumpunHewanController(),
    );
  }
}
