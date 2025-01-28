import 'package:get/get.dart';

import '../controllers/peternak_controller.dart';

class PeternakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeternakController>(
      () => PeternakController(),
    );
  }
}
