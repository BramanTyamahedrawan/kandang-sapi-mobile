import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/services/jenishewan_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';

class JenisHewanController extends GetxController {
  var posts = JenisHewanListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<JenisHewanModel> filteredPosts = RxList<JenisHewanModel>();

  @override
  void onInit() {
    loadJenisHewan();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadJenisHewan() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await JenisHewanApi().loadJenisHewanApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<JenisHewanModel> filteredList = posts.value.content!.toList();

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

  void searchJenisHewan(String keyword) {
    final List<JenisHewanModel> filteredList =
        posts.value.content!.where((jenis) {
      return jenis.jenis!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
