import 'package:crud_flutter_api/app/modules/menu/pengobatan/controllers/pengobatan_controller.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:crud_flutter_api/app/widgets/message/empty.dart';
import 'package:crud_flutter_api/app/widgets/message/no_data.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PengobatanView extends GetView<PengobatanController> {
  const PengobatanView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengobatanController>(
      builder: (controller) => RefreshIndicator(
        onRefresh: () async {
          await controller.loadPengobatan();
        },
        child: Scaffold(
          backgroundColor: AppColor.primary,
          appBar: EasySearchBar(
              searchBackgroundColor: AppColor.secondary,
              elevation: 0,
              searchCursorColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.white),
              searchClearIconTheme: const IconThemeData(color: Colors.white),
              searchBackIconTheme: const IconThemeData(color: Colors.white),
              systemOverlayStyle: SystemUiOverlayStyle.light,
              searchHintText: 'Cari ID Kasus',
              searchTextStyle: const TextStyle(color: Colors.white),
              title: const Text(
                'Data Pengobatan',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColor.secondary,
              onSearch: (value) => controller.searchPengobatan(value)),
          body: Obx(
            () {
              if (controller.posts.value.status == 200) {
                if (controller.posts.value.content!.isEmpty) {
                  return const EmptyView();
                } else {
                  return ListView.separated(
                    itemCount: controller.filteredPosts.value.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      var postData = controller.filteredPosts.value[index];
                      return InkWell(
                        onTap: () => {
                          Get.toNamed(
                            Routes.DETAILPENGOBATAN,
                            arguments: {
                              "idKasus": "${postData.idKasus}",
                              "tanggalPengobatan":
                                  "${postData.tanggalPengobatan}",
                              "tanggalKasus": "${postData.tanggalKasus}",
                              "namaPetugas":
                                  "${postData.namaPetugas?.namaPetugas}",
                              "namaInfrastruktur":
                                  "${postData.namaInfrastruktur}",
                              "lokasi": "${postData.lokasi}",
                              "dosis": "${postData.dosis}",
                              "sindrom": "${postData.sindrom}",
                              "diagnosaBanding": "${postData.diagnosaBanding}",
                            },
                          ),
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 5),
                                color: const Color.fromARGB(255, 0, 47, 255)
                                    .withOpacity(.2),
                                spreadRadius: 2,
                                blurRadius: 10, // changes position of shadow
                              ),
                            ],
                            color: AppColor.primaryExtraSoft,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1, color: AppColor.primaryExtraSoft),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, right: 29, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "ID Kasus: ${postData.idKasus}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Nama Petugas: ${postData.namaPetugas?.namaPetugas}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Sindrom: "
                                            "${postData.sindrom}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                return const NoData();
              }
            },
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.ADDPENGOBATAN);
              },
              backgroundColor: const Color(0xff132137),
              child: const Icon(
                Icons.add,
                color: Colors.amber,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

// class PengobatanView extends GetView<PengobatanController> {
//   const PengobatanView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PengobatanController>(
//       builder: (controller) => RefreshIndicator(
//         onRefresh: () => controller.refreshPengobatan(),
//         child: AutoLoad(
//           onInit: () async {
//             await controller.loadPengobatan();
//           },
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Semua Data',
//                 style: TextStyle(
//                   color: AppColor.secondaryExtraSoft,
//                 ),
//               ),
//               backgroundColor: Color(0xff132137),
//               elevation: 0,
//               centerTitle: true,
//               bottom: PreferredSize(
//                 preferredSize: Size.fromHeight(1),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 1,
//                   color: AppColor.secondaryExtraSoft,
//                 ),
//               ),
//             ),
//             body: _buildPengobatanListView(controller),
//             floatingActionButton: Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: FloatingActionButton(
//                 onPressed: () {
//                   Get.toNamed(Routes.ADDPENGOBATAN);
//                 },
//                 child: Icon(Icons.add),
//                 backgroundColor: Color(0xff132137),
//               ),
//             ),
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerFloat,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPengobatanListView(PengobatanController controller) {
//     if (controller.posts == null) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     } else if (controller.posts!.status == 200) {
//       if (controller.posts!.content!.isEmpty) {
//         return EmptyView();
//       } else {
//         return ListView.separated(
//           itemCount: controller.posts!.content!.length,
//           // shrinkWrap: true,
//           physics: BouncingScrollPhysics(),
//           separatorBuilder: (context, index) => SizedBox(height: 16),
//           itemBuilder: (context, index) {
//             var postData = controller.posts!.content![index];
//             return InkWell(
//               onTap: () => {
//                 Get.toNamed(
//                   Routes.DETAILPENGOBATAN,
//                   arguments: {
//                     "idKasus": "${postData.idKasus}",
//                     "tanggalPengobatan": "${postData.tanggalPengobatan}",
//                     "tanggalKasus": "${postData.tanggalKasus}",
//                     "namaPetugas": "${postData.namaPetugas}",
//                     "namaInfrastruktur": "${postData.namaInfrastruktur}",
//                     "lokasi": "${postData.lokasi}",
//                     "dosis": "${postData.dosis}",
//                     "sindrom": "${postData.sindrom}",
//                     "diagnosaBanding": "${postData.diagnosaBanding}",
//                   },
//                 ),
//               },
//               borderRadius: BorderRadius.circular(8),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     width: 1,
//                     color: AppColor.primaryExtraSoft,
//                   ),
//                 ),
//                 padding:
//                     EdgeInsets.only(left: 24, top: 20, right: 29, bottom: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           (postData.status == null)
//                               ? "-"
//                               : "Id Kasus : ${postData.idKasus} ${postData.tanggalKasus}",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text((postData.status == null)
//                             ? "-"
//                             : "${postData.diagnosaBanding}"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }
//     } else {
//       return NoData();
//     }
//   }
// }
