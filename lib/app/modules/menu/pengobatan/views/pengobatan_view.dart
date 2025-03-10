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
          backgroundColor: Colors.white,
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
                              "idPengobatan": "${postData.idPengobatan}",
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
                              "provinsiPengobatan":
                                  "${postData.provinsiPengobatan}",
                              "kabupatenPengobatan":
                                  "${postData.kabupatenPengobatan}",
                              "kecamatanPengobatan":
                                  "${postData.kecamatanPengobatan}",
                              "desaPengobatan": "${postData.desaPengobatan}",
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
                                blurRadius: 10,
                              ),
                            ],
                            color: AppColor.primaryExtraSoft,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1, color: AppColor.primaryExtraSoft),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ID Pengobatan: ${postData.idPengobatan ?? '-'}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "ID Kasus: ${postData.idKasus ?? '-'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Nama Petugas: ${postData.namaPetugas?.namaPetugas ?? '-'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Sindrom: ${postData.sindrom ?? '-'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Infrastruktur: ${postData.namaInfrastruktur ?? '-'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
