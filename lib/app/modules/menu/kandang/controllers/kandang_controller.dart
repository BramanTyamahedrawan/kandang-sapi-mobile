import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/services/kandang_api.dart';
import 'package:crud_flutter_api/app/widgets/message/loading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class KandangController extends GetxController {
  var posts = KandangListModel().obs;
  final box = GetStorage();
  String? get role => box.read('role');
  bool homeScreen = false;

  RxList<KandangModel> filteredPosts = RxList<KandangModel>();

  get jenisHewanC => null;

  @override
  void onInit() {
    role;
    super.onInit();
    loadKandang();
  }

  void reInitialize() {
    onInit();
  }

  loadKandang() async {
    homeScreen = false;
    update();
    showLoading();

    try {
      posts.value = await KandangApi().loadKandangApi();
      update();
      stopLoading();

      if (posts.value.status == 200) {
        final List<KandangModel> filteredList = posts.value.content!.toList();
        filteredPosts.assignAll(filteredList);
        homeScreen = true;
        update();
      } else if (posts.value.status == 204) {
        print("Empty");
      } else if (posts.value.status == 404) {
        print("Error 404: Data not found.");
        homeScreen = true;
        update();
      } else if (posts.value.status == 401) {
        print("Error 401: Unauthorized access.");
      } else if (posts.value.status == 400) {
        print("Error 400: Bad request. Please check your input.");
      } else {
        print("Unexpected error: ${posts.value.status}");
      }
    } catch (e) {
      stopLoading();
      print("An error occurred: $e");
    }
  }

  void searchKandang(String keyword) {
    final List<KandangModel> filteredList =
        posts.value.content!.where((kandang) {
      return kandang.idKandang!.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    void filterByJenisHewan(String jenisHewanC) {
      final List<KandangModel> filteredList =
          posts.value.content!.where((kandang) {
        return kandang.jenisHewan!
            .toLowerCase()
            .contains(jenisHewanC.toLowerCase());
      }).toList();

      filteredPosts.assignAll(filteredList);
    }
  }
}
