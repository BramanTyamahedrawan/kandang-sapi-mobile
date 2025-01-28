import 'package:get/get.dart';

import '../controllers/detail_kelahiran_controller.dart';

class DetailKelahiranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailKelahiranController>(
      () => DetailKelahiranController(),
    );
  }
}
