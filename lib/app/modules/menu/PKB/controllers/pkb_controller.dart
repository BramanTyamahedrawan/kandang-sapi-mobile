import 'package:crud_flutter_api/app/data/pkb_model.dart';
import 'package:crud_flutter_api/app/services/pkb_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PKBController extends GetxController {
  var posts = PKBListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;

  RxList<PKBModel> filteredPosts = RxList<PKBModel>();

  @override
  void onInit() {
    loadPKB();
    role;
    super.onInit();
  }

  void reInitialize() {
    onInit();
  }

  loadPKB() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await PKBApi().loadPKBAPI();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<PKBModel> filteredList = posts.value.content!.toList();

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

  void searchPKB(String keyword) {
    final List<PKBModel> filteredList = posts.value.content!.where((pkb) {
      return pkb.idKejadian!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
