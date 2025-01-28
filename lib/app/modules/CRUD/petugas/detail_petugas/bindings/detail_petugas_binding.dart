import 'package:get/get.dart';

import '../controllers/detail_petugas_controller.dart';

class DetailPetugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPetugasController>(
      () => DetailPetugasController(),
    );
  }
}
