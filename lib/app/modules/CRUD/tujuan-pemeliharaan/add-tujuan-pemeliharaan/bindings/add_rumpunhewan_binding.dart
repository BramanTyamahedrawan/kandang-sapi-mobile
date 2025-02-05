import 'package:get/get.dart';

import '../controllers/add_rumpunhewan_controller.dart';

class AddTujuanPemeliharaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTujuanPemeliharaanController>(
      () => AddTujuanPemeliharaanController(),
    );
  }
}
