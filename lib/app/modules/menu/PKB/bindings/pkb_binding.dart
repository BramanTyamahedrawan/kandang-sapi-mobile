import 'package:get/get.dart';

import '../controllers/pkb_controller.dart';

class PkbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PKBController>(
      () => PKBController(),
    );
  }
}
