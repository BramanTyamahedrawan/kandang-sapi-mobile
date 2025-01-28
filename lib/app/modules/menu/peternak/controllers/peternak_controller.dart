import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PeternakController extends GetxController {
  var posts = PeternakListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<PeternakModel> filteredPosts = RxList<PeternakModel>();

  @override
  void onInit() {
    loadPeternak();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadPeternak() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await PeternakApi().loadPeternakApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<PeternakModel> filteredList = posts.value.content!.toList();

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

  void searchPeternak(String keyword) {
    final List<PeternakModel> filteredList =
        posts.value.content!.where((peternak) {
      return peternak.idPeternak!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
