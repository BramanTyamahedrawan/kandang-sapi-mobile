import 'package:get/get.dart';

import '../controllers/namavaksin_controller.dart';

class NamaVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NamaVaksinController>(
      () => NamaVaksinController(),
    );
  }
}
