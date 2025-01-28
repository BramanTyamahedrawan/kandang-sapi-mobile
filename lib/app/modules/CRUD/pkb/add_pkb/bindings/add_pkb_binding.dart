import 'package:get/get.dart';

import '../controllers/add_pkb_controller.dart';

class AddPkbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPkbController>(
      () => AddPkbController(),
    );
  }
}
