import 'package:get/get.dart';

import '../controllers/detail_pengobatan_controller.dart';

class DetailPengobatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPengobatanController>(
      () => DetailPengobatanController(),
    );
  }
}
