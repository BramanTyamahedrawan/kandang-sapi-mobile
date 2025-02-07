import 'package:get/get.dart';

import '../controllers/detail_nama_vaksin_controller.dart';

class DetailNamaVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNamaVaksinController>(
      () => DetailNamaVaksinController(),
    );
  }
}
