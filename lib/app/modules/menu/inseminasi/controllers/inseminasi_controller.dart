import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/services/inseminasi_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InseminasiController extends GetxController {
  var posts = InseminasiListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;

  RxList<InseminasiModel> filteredPosts = RxList<InseminasiModel>();

  @override
  void onInit() {
    role;
    loadInseminasi();
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadInseminasi() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await InseminasiApi().loadInseminasiAPI();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<InseminasiModel> filteredList = posts.value.content!.toList();

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

  void searchInseminasi(String keyword) {
    final List<InseminasiModel> filteredList =
        posts.value.content!.where((inseminasi) {
      return inseminasi.idInseminasi!
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
