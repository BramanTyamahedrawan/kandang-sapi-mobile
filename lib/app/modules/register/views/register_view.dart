// import 'package:flutter/material.dart';
// import 'package:crud_flutter_api/app/utils/app_color.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../controllers/register_controller.dart';

// class RegisterView extends GetView<RegisterController> {
//   const RegisterView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.primary,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         elevation: 0.0,
//         titleSpacing: 10.0,
//         centerTitle: true,
//         title: const Text("Pendaftaran"),
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             'assets/icons/arrow-left.svg',
//             color: Colors.white,
//           ),
//           onPressed: () => Get.back(),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true,
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 25 / 100,
//             width: MediaQuery.of(context).size.width,
//             padding: const EdgeInsets.only(left: 32),
//             decoration: BoxDecoration(
//               gradient: AppColor.primaryGradient,
//               image: const DecorationImage(
//                 image: AssetImage('assets/images/background.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: const Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "POSTS App",
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontFamily: 'poppins',
//                     height: 150 / 100,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "by Hummasoft",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 70 / 100,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.white,
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 84),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 24),
//                   child: const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Daftar',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'poppins',
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
//                   margin: const EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                         width: 1, color: AppColor.secondaryExtraSoft),
//                   ),
//                   child: TextField(
//                     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
//                     maxLines: 1,
//                     controller: controller.nameC,
//                     decoration: InputDecoration(
//                       label: Text(
//                         "Nama Lengkap",
//                         style: TextStyle(
//                           color: AppColor.secondarySoft,
//                           fontSize: 14,
//                         ),
//                       ),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       border: InputBorder.none,
//                       hintText: "nama lengkap anda",
//                       hintStyle: TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'poppins',
//                         fontWeight: FontWeight.w500,
//                         color: AppColor.secondarySoft,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
//                   margin: const EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(
//                         width: 1, color: AppColor.secondaryExtraSoft),
//                   ),
//                   child: TextField(
//                     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
//                     maxLines: 1,
//                     controller: controller.emailC,
//                     decoration: InputDecoration(
//                       label: Text(
//                         "Email",
//                         style: TextStyle(
//                           color: AppColor.secondarySoft,
//                           fontSize: 14,
//                         ),
//                       ),
//                       floatingLabelBehavior: FloatingLabelBehavior.always,
//                       border: InputBorder.none,
//                       hintText: "email anda",
//                       hintStyle: TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'poppins',
//                         fontWeight: FontWeight.w500,
//                         color: AppColor.secondarySoft,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Material(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                                 width: 1, color: AppColor.secondaryExtraSoft),
//                           ),
//                           child: Obx(
//                             () => TextField(
//                               style: const TextStyle(
//                                   fontSize: 14, fontFamily: 'poppins'),
//                               maxLines: 1,
//                               controller: controller.passC,
//                               obscureText: controller.obsecureText.value,
//                               decoration: InputDecoration(
//                                 label: Text(
//                                   "Kata Sandi",
//                                   style: TextStyle(
//                                     color: AppColor.secondarySoft,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 floatingLabelBehavior:
//                                     FloatingLabelBehavior.always,
//                                 border: InputBorder.none,
//                                 hintText: "*************",
//                                 suffixIcon: IconButton(
//                                   icon: (controller.obsecureText != true)
//                                       ? SvgPicture.asset(
//                                           'assets/icons/show.svg')
//                                       : SvgPicture.asset(
//                                           'assets/icons/hide.svg'),
//                                   onPressed: () {
//                                     controller.obsecureText.value =
//                                         !(controller.obsecureText.value);
//                                   },
//                                 ),
//                                 hintStyle: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'poppins',
//                                   fontWeight: FontWeight.w500,
//                                   color: AppColor.secondarySoft,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "Kata sandi minimal 6 karakter",
//                         style: TextStyle(
//                           color: AppColor.secondarySoft,
//                           height: 150 / 100,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Obx(
//                   () => SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         if (controller.isLoading.isFalse) {
//                           await controller.registration();
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 18), backgroundColor: AppColor.primary,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         (controller.isLoading.isFalse)
//                             ? 'Daftar'
//                             : 'Loading...',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontFamily: 'poppins',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
