import 'package:get/get.dart';

import '../controllers/detail_hijauan_controller.dart';

class DetailHijauanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailHijauanController>(
      () => DetailHijauanController(),
    );
  }
}
