import 'package:crud_flutter_api/app/data/RumpunHewan_model.dart';
import 'package:crud_flutter_api/app/services/RumpunHewan_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';

class RumpunHewanController extends GetxController {
  var posts = RumpunHewanListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<RumpunHewanModel> filteredPosts = RxList<RumpunHewanModel>();

  @override
  void onInit() {
    loadRumpunHewan();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadRumpunHewan() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await RumpunHewanApi().loadRumpunHewanApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<RumpunHewanModel> filteredList = posts.value.content!.toList();

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

  void searchRumpunHewan(String keyword) {
    final List<RumpunHewanModel> filteredList =
        posts.value.content!.where((rumpun) {
      return rumpun.rumpun!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
