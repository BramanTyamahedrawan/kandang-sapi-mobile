import 'package:get/get.dart';

import '../controllers/detail_inseminasi_controller.dart';

class DetailInseminasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailInseminasiController>(
      () => DetailInseminasiController(),
    );
  }
}
