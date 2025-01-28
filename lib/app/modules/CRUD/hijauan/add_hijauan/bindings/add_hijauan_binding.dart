import 'package:get/get.dart';

import '../controllers/add_Hijauan_controller.dart';

class AddHijauanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddHijauanController>(() => AddHijauanController());
  }
}
