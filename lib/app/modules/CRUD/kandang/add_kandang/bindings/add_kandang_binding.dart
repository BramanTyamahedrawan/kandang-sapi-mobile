import 'package:get/get.dart';

import '../controllers/add_kandang_controller.dart';

class AddKandangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKandangController>(
      () => AddKandangController(),
    );
  }
}
