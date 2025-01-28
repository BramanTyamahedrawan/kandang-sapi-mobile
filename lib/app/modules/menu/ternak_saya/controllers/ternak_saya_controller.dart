import 'package:get/get.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';

class TernakSayaController extends GetxController {
  var posts = PetugasListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<PetugasModel> filteredPosts = RxList<PetugasModel>();

  @override
  void onInit() {
    loadPetugas();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadPetugas() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await PetugasApi().loadPetugasApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<PetugasModel> filteredList = posts.value.content!.toList();

      filteredPosts.assignAll(filteredList);
      homeScreen = true;
      update();
    } else if (posts.value.status == 204) {
      print("Empty");
    } else if (posts.value.status == 404) {
      homeScreen = true;
      update();
    } else if (posts.value.status == 401) {
    } else {
      print("someting wrong 400");
    }
  }

  void searchPetugas(String keyword) {
    final List<PetugasModel> filteredList =
        posts.value.content!.where((petugas) {
      return petugas.nikPetugas!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
