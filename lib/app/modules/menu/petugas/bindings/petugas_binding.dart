import 'package:get/get.dart';

import '../controllers/petugas_controller.dart';

class PetugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetugasController>(
      () => PetugasController(),
    );
  }
}
