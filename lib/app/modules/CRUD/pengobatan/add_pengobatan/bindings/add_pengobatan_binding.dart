import 'package:get/get.dart';

import '../controllers/add_pengobatan_controller.dart';

class AddPengobatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPengobatanController>(
      () => AddPengobatanController(),
    );
  }
}
