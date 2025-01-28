import 'package:get/get.dart';

import '../controllers/detail_peternak_controller.dart';

class DetailPeternakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPeternakController>(
      () => DetailPeternakController(),
    );
  }
}
