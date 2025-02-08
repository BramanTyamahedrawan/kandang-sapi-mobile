import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/services/namavaksin_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NamaVaksinController extends GetxController {
  var posts = NamaVaksinListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;

  RxList<NamaVaksinModel> filteredPosts = RxList<NamaVaksinModel>();

  @override
  void onInit() {
    role;
    super.onInit();
    loadNamaVaksin();
  }

  void reInitialize() {
    onInit();
  }

  loadNamaVaksin() async {
    homeScreen = false;
    update();
    showLoading();
    posts.value = await NamaVaksinApi().loadNamaVaksinAPI();
    update();
    stopLoading();
    if (posts.value.status == 200) {
      final List<NamaVaksinModel> filteredList = posts.value.content!.toList();
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

  void searchNamaVaksin(String keyword) {
    final List<NamaVaksinModel> filteredList =
        posts.value.content!.where((namavaksin) {
      return namavaksin.idNamaVaksin!
          .toLowerCase()
          .contains(keyword.toLowerCase());
    }).toList();

    filteredPosts.assignAll(filteredList);
  }
}
