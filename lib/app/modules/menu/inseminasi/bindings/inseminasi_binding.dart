import 'package:get/get.dart';

import '../controllers/inseminasi_controller.dart';

class InseminasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InseminasiController>(
      () => InseminasiController(),
    );
  }
}
