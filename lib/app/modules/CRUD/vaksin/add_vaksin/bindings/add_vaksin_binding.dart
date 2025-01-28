import 'package:get/get.dart';

import '../controllers/add_vaksin_controller.dart';

class AddVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVaksinController>(
      () => AddVaksinController(),
    );
  }
}
