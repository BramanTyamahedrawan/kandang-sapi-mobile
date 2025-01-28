import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:crud_flutter_api/app/data/user_model.dart';
import 'package:get_storage/get_storage.dart';

class StartController extends GetxController with GetTickerProviderStateMixin {
  UserModel? userModel;
  final box = GetStorage();
  bool startScreen = false;
  late AnimationController animationController;
  bool isAnimationInitialized = false;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    try {
      animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 8),
      );
      animationController.value = 0.0;
      isAnimationInitialized = true;
      update();
    } catch (e) {
      print('Animation initialization error: $e');
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
