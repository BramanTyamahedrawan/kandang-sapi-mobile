import 'package:get/get.dart';

import '../controllers/ternak_saya_controller.dart';

class TernakSayaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TernakSayaController>(
      () => TernakSayaController(),
    );
  }
}
