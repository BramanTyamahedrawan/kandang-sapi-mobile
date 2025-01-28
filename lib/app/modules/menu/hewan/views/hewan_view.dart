import 'package:crud_flutter_api/app/widgets/message/empty.dart';
import 'package:crud_flutter_api/app/widgets/message/no_data.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/hewan_controller.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';

class HewanView extends GetView<HewanController> {
  //final HewanController hewanController = Get.find();
  const HewanView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HewanController>(
      builder: (controller) => RefreshIndicator(
        onRefresh: () async {
          await controller.loadHewan();
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
              searchHintText: 'Cari Kode EARTAG Nasional',
              searchTextStyle: const TextStyle(color: Colors.white),
              title: const Text(
                'Data Hewan',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColor.secondary,
              onSearch: (value) => controller.searchHewan(value)),
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
                            Routes.DETAILHEWAN,
                            arguments: {
                              "eartag_hewan_detail":
                                  "${postData.kodeEartagNasional}",
                              "kartu_hewan_detail": "${postData.noKartuTernak}",
                              "provinsi_hewan_detail": "${postData.provinsi}",
                              "kabupaten_hewan_detail": "${postData.kabupaten}",
                              "kecamatan_hewan_detail": "${postData.kecamatan}",
                              "desa_hewan_detail": "${postData.desa}",
                              "alamat_hewan_detail": "${postData.alamat}",
                              "nama_peternak_hewan_detail":
                                  "${postData.idPeternak?.namaPeternak}",
                              "id_peternak_hewan_detail":
                                  "${postData.idPeternak?.idPeternak}",
                              "id_kandang_hewan_detail":
                                  "${postData.idKandang?.idKandang}",
                              "nik_hewan_detail":
                                  "${postData.idPeternak?.nikPeternak}",
                              "spesies_hewan_detail": "${postData.spesies}",
                              "kelamin_hewan_detail": "${postData.sex}",
                              "umur_hewan_detail": "${postData.umur}",
                              "identifikasi_hewan_detail":
                                  "${postData.identifikasiHewan}",
                              "petugas_terdaftar_hewan_detail":
                                  "${postData.petugasPendaftar?.nikPetugas}",
                              "tanggal_terdaftar_hewan_detail":
                                  "${postData.tanggalTerdaftar}",
                              "foto_hewan_detail": "${postData.fotoHewan}",
                              "latitude_hewan_detail": "${postData.latitude}",
                              "longitude_hewan_detail": "${postData.longitude}",
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
                          child: Wrap(
                            // Gunakan Wrap di sini
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Kode Eartag Nasional: ${postData.kodeEartagNasional}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Nama peternak: ${postData.idPeternak?.namaPeternak}",
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
                                        : "Nik Peternak: "
                                            "${postData.idPeternak?.nikPeternak}",
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
          floatingActionButton: (controller.role == 'ROLE_PETERNAK')
              ? null
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Get.toNamed(Routes.ADDHEWAN);
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


// class HewanView extends GetView<HewanController> {
//   const HewanView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HewanController>(
//       builder: (controller) => AutoLoad(
//         onInit: () async {
//           await controller.loadHewan();
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Semua Data',
//               style: TextStyle(
//                 color: AppColor.secondaryExtraSoft,
//               ),
//             ),
//             backgroundColor: Color(0xff132137),
//             elevation: 0,
//             centerTitle: true,
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(1),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 1,
//                 color: AppColor.secondaryExtraSoft,
//               ),
//             ),
//           ),
//           //body: Container(),
//           body: GetBuilder<HewanController>(
//             builder: (controller) => controller.posts?.status == 200
//                 ? controller.posts!.content!.isEmpty
//                     ? EmptyView()
//                     : ListView.separated(
//                         itemCount: controller.posts!.content!.length,
//                         shrinkWrap: true,
//                         physics: BouncingScrollPhysics(),
//                         separatorBuilder: (context, index) =>
//                             SizedBox(height: 16),
//                         itemBuilder: (context, index) {
//                           var postData = controller.posts!.content![index];
//                           return InkWell(
//                             onTap: () => {
//                               Get.toNamed(
//                                 Routes.DETAILHEWAN,
//                                 arguments: {
//                                   "eartag_hewan_detail": "${postData.kodeEartagNasional}",
//                                   "kartu_hewan_detail": "${postData.noKartuTernak}",
//                                   "provinsi_hewan_detail": "${postData.provinsi}",
//                                   "kabupaten_hewan_detail": "${postData.kabupaten}",
//                                   "kecamatan_hewan_detail": "${postData.kecamatan}",
//                                   "desa_hewan_detail": "${postData.desa}",
//                                   "nama_peternak_hewan_detail": "${postData.namaPeternak}",
//                                   "id_peternak_hewan_detail": "${postData.idPeternak}",
//                                   "nik_hewan_detail": "${postData.nikPeternak}",
//                                   "spesies_hewan_detail": "${postData.spesies}",
//                                   "kelamin_hewan_detail": "${postData.sex}",
//                                   "umur_hewan_detail": "${postData.umur}",
//                                   "identifikasi_hewan_detail": "${postData.identifikasiHewan}",
//                                   "petugas_terdaftar_hewan_detail": "${postData.petugasPendaftar}",
//                                   "tanggal_terdaftar_hewan_detail": "${postData.tanggalTerdaftar}",
                                  
//                                 },
//                               ),
//                             },
//                             borderRadius: BorderRadius.circular(8),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   width: 1,
//                                   color: AppColor.primaryExtraSoft,
//                                 ),
//                               ),
//                               padding: EdgeInsets.only(
//                                   left: 24, top: 20, right: 29, bottom: 20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         (postData.status == null)
//                                             ? "-"
//                                             : "No Kartu Ternak : ${postData.kodeEartagNasional} ${postData.noKartuTernak}",
//                                         style: TextStyle(fontSize: 18),
//                                       ),
//                                       Text((postData.status == null)
//                                           ? "-"
//                                           : "${postData.spesies}"),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                 : NoData(),
//           ),
//           floatingActionButton: Padding(
//             padding: const EdgeInsets.only(bottom: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 Get.toNamed(Routes.ADDHEWAN);
//               },
//               child: Icon(Icons.add),
//               backgroundColor: Color(0xff132137),
//             ),
//           ),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerFloat,
//         ),
//       ),
//     );
//   }
// }