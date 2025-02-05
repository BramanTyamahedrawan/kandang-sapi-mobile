import 'package:get/get.dart';

import '../controllers/jenishewan_controller.dart';

class JenisHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JenisHewanController>(
      () => JenisHewanController(),
    );
  }
}
