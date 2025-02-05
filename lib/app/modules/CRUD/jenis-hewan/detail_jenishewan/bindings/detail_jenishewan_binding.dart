import 'package:get/get.dart';

import '../controllers/detail_jenishewan_controller.dart';

class DetailJenisHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailJenisHewanController>(
      () => DetailJenisHewanController(),
    );
  }
}
