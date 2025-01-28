import 'package:get/get.dart';

import '../controllers/vaksin_controller.dart';

class VaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VaksinController>(
      () => VaksinController(),
    );
  }
}
