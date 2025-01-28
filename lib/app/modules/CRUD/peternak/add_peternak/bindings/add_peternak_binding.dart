import 'package:get/get.dart';

import '../controllers/add_peternak_controller.dart';

class AddPeternakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPeternakController>(
      () => AddPeternakController(),
    );
  }
}
