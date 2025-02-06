import 'package:crud_flutter_api/app/modules/CRUD/jenis-vaksin/detail_jenisvaksin/controllers/detail_jenisvaksin_contoller.dart';
import 'package:get/get.dart';


class DetailJenisVaksinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailJenisVaksinController>(
      () => DetailJenisVaksinController(),
    );
  }
}
