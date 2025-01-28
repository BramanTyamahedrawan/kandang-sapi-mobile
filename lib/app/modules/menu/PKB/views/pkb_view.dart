import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:crud_flutter_api/app/widgets/message/empty.dart';
import 'package:crud_flutter_api/app/widgets/message/no_data.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/pkb_controller.dart';

class PKBView extends GetView<PKBController> {
  const PKBView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PKBController>(
      builder: (controller) => RefreshIndicator(
        onRefresh: () async {
          await controller.loadPKB();
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
              searchHintText: 'Cari ID Kejadian',
              searchTextStyle: const TextStyle(color: Colors.white),
              title: const Text(
                'Data PKB',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColor.secondary,
              onSearch: (value) => controller.searchPKB(value)),
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
                            Routes.DETAILPKB,
                            arguments: {
                              "id_kejadian": "${postData.idKejadian}",
                              "kodeEartagNasional":
                                  "${postData.kodeEartagNasional?.kodeEartagNasional}",
                              //"id_hewan": "${postData.idHewan}",
                              "id_peternak":
                                  "${postData.idPeternak?.idPeternak}",
                              "nik": "${postData.idPeternak?.nikPeternak}",
                              "nama": "${postData.idPeternak?.namaPeternak}",
                              "jumlah": "${postData.jumlah}",
                              "kategori": "${postData.kategori}",
                              "lokasi": "${postData.lokasi}",
                              "spesies": "${postData.spesies}",
                              "umur": "${postData.umurKebuntingan}",
                              "pemeriksa":
                                  "${postData.pemeriksaKebuntingan?.namaPetugas}",
                              "tanggal": "${postData.tanggalPkb}"
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
                                        : "ID Kejadian: ${postData.idKejadian}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Nama Peternak: ${postData.idPeternak?.namaPeternak}",
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
                                        : "Tanggal PKB: "
                                            "${postData.tanggalPkb}",
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
                      Get.toNamed(Routes.ADDPKB);
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
