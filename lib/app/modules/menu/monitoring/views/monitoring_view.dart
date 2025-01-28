import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/monitoring_controller.dart';

class MonitoringView extends GetView<MonitoringController> {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MonitoringController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Live Motion Tracking'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Video Player
            Positioned.fill(
                child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Chewie(
                        controller: ChewieController(
                          videoPlayerController:
                              controller.videoControllerJOSSS,
                          aspectRatio: 9 / 16, // Potret
                          //
                          autoPlay: true,
                          looping: true,
                          // Dan opsi Chewie lainnya...
                        ),
                      ),
                    ))),

            // Data Display
            Positioned(
              top: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Ammonia Data
                  Obx(() => DataWidget(
                        label: 'Ammonia',
                        value: controller.ammonia.value,
                      )),

                  // Wind Speed Data
                  Obx(() => DataWidget(
                        label: 'Wind Speed',
                        value: controller.windSpeed.value,
                      )),

                  // Humidity Data
                  Obx(() => DataWidget(
                        label: 'Humidity',
                        value: controller.humidity.value,
                      )),

                  Obx(() => DataWidget(
                        label: 'weather',
                        value: controller.cuaca.value,
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

class DataWidget extends StatelessWidget {
  final String label;
  final String value;

  const DataWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/monitoring_controller.dart';

// class MonitoringView extends GetView<MonitoringController> {
//   const MonitoringView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Live Motion Tracking'),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // Video Player
//           Positioned.fill(
//             child: Container(
//               // Placeholder for video player
//               color: Colors.black,
//               child: Center(
//                 child: Text(
//                   'Live Video Here', // Ganti dengan VideoPlayer
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),

//           // Data Display
//           Positioned(
//             top: 20,
//             right: 20,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 // Ammonia Data
//                 DataWidget(label: 'Ammonia', value: controller.ammonia.value),

//                 // Wind Speed Data
//                 DataWidget(
//                     label: 'Wind Speed', value: controller.windSpeed.value),

//                 // Humidity Data
//                 DataWidget(label: 'Humidity', value: controller.humidity.value),

//                 DataWidget(label: 'Cuaca', value: controller.cuaca.value),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Widget untuk menampilkan data
// class DataWidget extends StatelessWidget {
//   final String label;
//   final String value;

//   const DataWidget({Key? key, required this.label, required this.value})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.black54,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             label,
//             style: TextStyle(color: Colors.white),
//           ),
//           Text(
//             value,
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
