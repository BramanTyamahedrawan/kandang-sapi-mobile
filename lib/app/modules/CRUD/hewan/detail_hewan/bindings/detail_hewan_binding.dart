import 'package:get/get.dart';

import '../controllers/detail_hewan_controller.dart';

class DetailHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHewanController>(
      () => DetailHewanController(),
    );
  }
}
