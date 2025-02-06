import 'package:crud_flutter_api/app/modules/CRUD/jenis-vaksin/add_jenisvaksin/controllers/add_jenisvaksin_controller.dart';
import 'package:get/get.dart';


class AddJenisVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddJenisVaksinController>(
      () => AddJenisVaksinController(),
    );
  }
}
