import 'package:get/get.dart';

import '../controllers/kelahiran_controller.dart';

class KelahiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KelahiranController>(
      () => KelahiranController(),
    );
  }
}
