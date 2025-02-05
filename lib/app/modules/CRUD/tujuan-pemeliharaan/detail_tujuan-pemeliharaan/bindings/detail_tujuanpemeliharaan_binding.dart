import 'package:get/get.dart';

import '../controllers/detail_tujuanpemeliharaan_controller.dart';

class DetailTujuanPemeliharaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTujuanPemeliharaanController>(
      () => DetailTujuanPemeliharaanController(),
    );
  }
}
