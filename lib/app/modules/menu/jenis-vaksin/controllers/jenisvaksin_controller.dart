
import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/services/jenisvaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JenisVaksinController extends GetxController {
  var posts = JenisVaksinListModel().obs;
  final box = GetStorage();
  bool homeScreen = false;
  RxBool isSearching = false.obs;

  RxList<JenisVaksinModel> filteredPosts = RxList<JenisVaksinModel>();

  @override
  void onInit() {
    loadJenisVaksin();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadJenisVaksin() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await JenisVaksinApi().loadJenisVaksinApi();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<JenisVaksinModel> filteredList = posts.value.content!.toList();

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

  void searchJenisVaksin(String keyword) {
    final List<JenisVaksinModel> filteredList =
        posts.value.content!.where((jenis) {
      return jenis.jenis!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
