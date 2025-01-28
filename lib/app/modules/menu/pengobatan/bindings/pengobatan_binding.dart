import 'package:get/get.dart';

import '../controllers/pengobatan_controller.dart';

class PengobatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengobatanController>(
      () => PengobatanController(),
    );
  }
}
