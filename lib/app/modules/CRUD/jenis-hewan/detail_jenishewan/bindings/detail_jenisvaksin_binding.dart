import 'package:crud_flutter_api/app/modules/CRUD/jenis-hewan/detail_jenishewan/controllers/detail_jenishewan_contoller.dart';
import 'package:get/get.dart';


class DetailJenisHewanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailJenisHewanController>(
      () => DetailJenisHewanController(),
    );
  }
}
