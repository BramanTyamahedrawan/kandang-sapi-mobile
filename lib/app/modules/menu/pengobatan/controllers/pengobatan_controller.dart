import 'package:crud_flutter_api/app/data/pengobatan_model.dart';
import 'package:crud_flutter_api/app/services/pengobatan_api..dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PengobatanController extends GetxController {
  var posts = PengobatanListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<PengobatanModel> filteredPosts = RxList<PengobatanModel>();

  @override
  void onInit() {
    super.onInit();
    loadPengobatan();
  }

  void reInitialize() {
    onInit();
  }

  // Future<void> refreshPengobatan() async {
  //   posts = await PengobatanApi().loadPengobatanAPI();
  //   update();
  //   print("refresh");
  // }

  loadPengobatan() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await PengobatanApi().loadPengobatanAPI();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<PengobatanModel> filteredList = posts.value.content!.toList();

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

  void searchPengobatan(String keyword) {
    final List<PengobatanModel> filteredList =
        posts.value.content!.where((pengobatan) {
      return pengobatan.idKasus!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
