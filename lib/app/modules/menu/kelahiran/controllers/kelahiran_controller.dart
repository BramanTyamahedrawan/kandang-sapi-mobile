import 'package:crud_flutter_api/app/data/kelahiran_model.dart';
import 'package:crud_flutter_api/app/services/kelahiran_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KelahiranController extends GetxController {
  var posts = KelahiranListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;

  RxList<KelahiranModel> filteredPosts = RxList<KelahiranModel>();

  @override
  void onInit() {
    role;
    super.onInit();
    loadkelahiran();
  }

  void reInitialize() {
    onInit();
  }

  loadkelahiran() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await KelahiranApi().loadKelahiranAPI();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<KelahiranModel> filteredList = posts.value.content!.toList();

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

  void searchKelahiran(String keyword) {
    final List<KelahiranModel> filteredList =
        posts.value.content!.where((kelahiran) {
      return kelahiran.idKejadian!
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
