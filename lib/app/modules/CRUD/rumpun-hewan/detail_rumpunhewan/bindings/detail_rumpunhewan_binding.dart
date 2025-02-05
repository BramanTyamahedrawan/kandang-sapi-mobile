import 'package:get/get.dart';

import '../controllers/detail_rumpunhewan_controller.dart';

class DetailRumpunHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRumpunHewanController>(
      () => DetailRumpunHewanController(),
    );
  }
}
