import 'package:crud_flutter_api/app/modules/start/controllers/start_controller.dart';
import 'package:get/get.dart';
import './components/care_view.dart';
import './components/center_next_button.dart';
import './components/mood_diary_vew.dart';
import './components/relax_view.dart';
import './components/splash_view.dart';
import './components/top_back_skip_view.dart';
import './components/welcome_view.dart';
import 'package:flutter/material.dart';

class StartView extends GetView<StartController> {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartController>(
      init: StartController(),
      builder: (controller) {
        if (!controller.isAnimationInitialized) {
          return const Scaffold(
            backgroundColor: Color(0xffF7EBE1),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xffF7EBE1),
          body: SafeArea(
            child: ClipRect(
              child: Stack(
                children: [
                  SplashView(
                    animationController: controller.animationController,
                  ),
                  RelaxView(
                    animationController: controller.animationController,
                  ),
                  CareView(
                    animationController: controller.animationController,
                  ),
                  MoodDiaryVew(
                    animationController: controller.animationController,
                  ),
                  WelcomeView(
                    animationController: controller.animationController,
                  ),
                  TopBackSkipView(
                    onBackClick: () => _onBackClick(controller),
                    onSkipClick: () => _onSkipClick(controller),
                    animationController: controller.animationController,
                  ),
                  CenterNextButton(
                    animationController: controller.animationController,
                    onNextClick: () => _onNextClick(controller),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSkipClick(StartController controller) {
    try {
      controller.animationController?.animateTo(
        0.8,
        duration: const Duration(milliseconds: 1200),
      );
    } catch (e) {
      print('Skip animation error: $e');
    }
  }

  void _onBackClick(StartController controller) {
    try {
      final value = controller.animationController?.value ?? 0.0;

      if (value >= 0 && value <= 0.2) {
        controller.animationController?.animateTo(0.0);
      } else if (value > 0.2 && value <= 0.4) {
        controller.animationController?.animateTo(0.2);
      } else if (value > 0.4 && value <= 0.6) {
        controller.animationController?.animateTo(0.4);
      } else if (value > 0.6 && value <= 0.8) {
        controller.animationController?.animateTo(0.6);
      } else if (value > 0.8 && value <= 1.0) {
        controller.animationController?.animateTo(0.8);
      }
    } catch (e) {
      print('Back animation error: $e');
    }
  }

  void _onNextClick(StartController controller) {
    try {
      final value = controller.animationController?.value ?? 0.0;

      if (value >= 0 && value <= 0.2) {
        controller.animationController?.animateTo(0.4);
      } else if (value > 0.2 && value <= 0.4) {
        controller.animationController?.animateTo(0.6);
      } else if (value > 0.4 && value <= 0.6) {
        controller.animationController?.animateTo(0.8);
      } else if (value > 0.6 && value <= 0.8) {
        // Handle last screen if needed
      }
    } catch (e) {
      print('Next animation error: $e');
    }
  }
}
