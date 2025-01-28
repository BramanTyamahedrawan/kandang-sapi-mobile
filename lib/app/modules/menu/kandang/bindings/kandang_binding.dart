import 'package:get/get.dart';

import '../controllers/kandang_controller.dart';

class KandangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KandangController>(
      () => KandangController(),
    );
  }
}
