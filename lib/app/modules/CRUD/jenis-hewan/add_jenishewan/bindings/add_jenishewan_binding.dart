import 'package:get/get.dart';

import '../controllers/add_jenishewan_controller.dart';

class AddJenisHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddJenisHewanController>(
      () => AddJenisHewanController(),
    );
  }
}
