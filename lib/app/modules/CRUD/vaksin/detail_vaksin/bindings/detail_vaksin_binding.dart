import 'package:get/get.dart';

import '../controllers/detail_vaksin_controller.dart';

class DetailVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailVaksinController>(
      () => DetailVaksinController(),
    );
  }
}
