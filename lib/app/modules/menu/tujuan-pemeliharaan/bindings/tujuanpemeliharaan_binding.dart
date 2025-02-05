import 'package:get/get.dart';

import '../controllers/tujuanpemeliharaan_controller.dart';

class TujuanPemeliharaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TujuanPemeliharaanController>(
      () => TujuanPemeliharaanController(),
    );
  }
}
