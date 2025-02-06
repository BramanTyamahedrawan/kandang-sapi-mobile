import 'package:get/get.dart';

import '../controllers/jenisvaksin_controller.dart';

class JenisVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JenisVaksinController>(
      () => JenisVaksinController(),
    );
  }
}
