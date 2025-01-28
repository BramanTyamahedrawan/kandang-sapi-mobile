import 'package:get/get.dart';

import '../controllers/detail_pkb_controller.dart';

class DetailPkbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPkbController>(
      () => DetailPkbController(),
    );
  }
}
