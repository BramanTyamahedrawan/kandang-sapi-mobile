import 'package:get/get.dart';

import '../controllers/hijauan_controller.dart';

class HijauanBinding extends Bindings {
  @override
  void dependencies() {
    // Mengikat (bind) HijauanController ke dalam dependency injection GetX
    Get.lazyPut<HijauanController>(() => HijauanController());
  }
}
