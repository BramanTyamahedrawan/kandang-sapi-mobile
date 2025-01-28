import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/services/read_role.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HewanController extends GetxController {
  var posts = HewanListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<HewanModel> filteredPosts = RxList<HewanModel>();

  @override
  void onInit() {
    loadHewan();
    role;
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadHewan() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await HewanApi().loadHewanApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<HewanModel> filteredList = posts.value.content!.toList();

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

  void searchHewan(String keyword) {
    final List<HewanModel> filteredList = posts.value.content!.where((hewan) {
      return hewan.kodeEartagNasional!
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
