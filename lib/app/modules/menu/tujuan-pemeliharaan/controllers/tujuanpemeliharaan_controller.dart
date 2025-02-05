import 'package:crud_flutter_api/app/data/TujuanPemeliharaan_model.dart';
import 'package:crud_flutter_api/app/services/tujuanpemeliharaan_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';

class TujuanPemeliharaanController extends GetxController {
  var posts = TujuanPemeliharaanListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<TujuanPemeliharaanModel> filteredPosts =
      RxList<TujuanPemeliharaanModel>();

  @override
  void onInit() {
    loadTujuanPemeliharaan();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadTujuanPemeliharaan() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await TujuanPemeliharaanApi().loadTujuanPemeliharaanApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<TujuanPemeliharaanModel> filteredList =
          posts.value.content!.toList();

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

  void searchTujuanPemeliharaan(String keyword) {
    final List<TujuanPemeliharaanModel> filteredList =
        posts.value.content!.where((tujuan) {
      return tujuan.tujuanPemeliharaan!
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
