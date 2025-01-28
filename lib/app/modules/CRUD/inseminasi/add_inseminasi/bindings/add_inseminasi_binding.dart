import 'package:get/get.dart';

import '../controllers/add_inseminasi_controller.dart';

class AddInseminasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInseminasiController>(
      () => AddInseminasiController(),
    );
  }
}
