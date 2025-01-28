import 'package:get/get.dart';

import '../controllers/add_kelahiran_controller.dart';

class AddkelahiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddkelahiranController>(
      () => AddkelahiranController(),
    );
  }
}
