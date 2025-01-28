import 'package:crud_flutter_api/app/data/vaksin_model.dart';
import 'package:crud_flutter_api/app/services/vaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VaksinController extends GetxController {
  var posts = VaksinListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;

  RxList<VaksinModel> filteredPosts = RxList<VaksinModel>();

  @override
  void onInit() {
    role;
    super.onInit();
    loadVaksin();
  }

  void reInitialize() {
    onInit();
  }

  loadVaksin() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await VaksinApi().loadVaksinAPI();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<VaksinModel> filteredList = posts.value.content!.toList();
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

  void searchVaksin(String keyword) {
    final List<VaksinModel> filteredList = posts.value.content!.where((vaksin) {
      return vaksin.idVaksin!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
