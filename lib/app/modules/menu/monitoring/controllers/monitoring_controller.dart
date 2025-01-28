import 'dart:async';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class MonitoringController extends GetxController {
  //TODO: Implement MenuMonitoringController
  RxString ammonia = ''.obs;
  RxString windSpeed = ''.obs;
  RxString humidity = ''.obs;
  RxString cuaca = ''.obs;
  late VideoPlayerController videoPlayerController;
  final VideoPlayerController videoControllerJOSSS =
      VideoPlayerController.asset('assets/videos/sapi2.mp4');
  late Timer dataUpdateTimer;

  String videoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void onInit() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        videoPlayerController.play();
        update();
        //Get.reload();
      });
    // Inisialisasi timer untuk memperbarui data setiap detik
    dataUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateData(); // Memanggil metode untuk memperbarui data
    });
    super.onInit();
    ammonia.value;
    windSpeed.value;
    humidity.value;
    cuaca.value;
  }


  @override
  void onClose() {
    // Pastikan untuk melepas sumber daya video saat widget dihapus
    dataUpdateTimer.cancel();
    // videoPlayerController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    videoControllerJOSSS.dispose();
    super.dispose();
  }

  // Metode untuk memperbarui data secara acak
  void updateData() {
    ammonia.value =
        '${35 + (10 * DateTime.now().millisecond % 40)} ppm';
    windSpeed.value =
        '${4 + (7 * DateTime.now().millisecond % 230)} m/s';
    humidity.value = '${30 + (10 * DateTime.now().second % 15)}%';
    cuaca.value =
        '${20 + (1 * DateTime.now().second % 34)}°C\nlebih dingin';
    print(
        "Updated Data: Ammonia - ${ammonia.value}, Wind Speed - ${windSpeed.value}, Humidity - ${humidity.value}, Cuaca - ${cuaca.value}");
    update(); // Memperbarui tampilan setelah nilai diubah
  }
}
