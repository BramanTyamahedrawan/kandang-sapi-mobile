import 'package:get/get.dart';

import '../controllers/add_nama_vaksin_controller.dart';

class AddNamaVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNamaVaksinController>(
      () => AddNamaVaksinController(),
    );
  }
}
