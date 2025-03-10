import 'package:crud_flutter_api/app/widgets/message/empty.dart';
import 'package:crud_flutter_api/app/widgets/message/no_data.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
          backgroundColor: Colors.white,
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
                        onTap: () {
                          Get.toNamed(
                            Routes.DETAILHEWAN,
                            arguments: {
                              "idHewan": postData.idHewan ?? 'Tidak tersedia',
                              "eartag_hewan_detail":
                                  postData.kodeEartagNasional ??
                                      'Tidak tersedia',
                              "kartu_hewan_detail":
                                  postData.noKartuTernak ?? 'Tidak tersedia',
                              "id_isikhnas_detail":
                                  postData.idIsikhnasTernak ?? 'Tidak tersedia',
                              "id_jenishewan_detail":
                                  postData.jenisHewan?.idJenisHewan ??
                                      'Tidak tersedia',
                              "id_rumpun_detail":
                                  postData.rumpunHewan?.idRumpunHewan ??
                                      'Tidak tersedia',
                              "id_tujuanpemeliharaan_detail": postData
                                      .tujuanPemeliharaan
                                      ?.idTujuanPemeliharaan ??
                                  'Tidak tersedia',
                              "id_peternak_hewan_detail":
                                  postData.idPeternak?.idPeternak ??
                                      'Tidak tersedia',
                              "id_kandang_hewan_detail":
                                  postData.idKandang?.idKandang ??
                                      'Tidak tersedia',
                              "kelamin_hewan_detail":
                                  postData.sex ?? 'Tidak tersedia',
                              "tempat_lahir_detail":
                                  postData.tempatLahir ?? 'Tidak tersedia',
                              "tanggal_lahir_detail":
                                  postData.tanggalLahir ?? 'Tidak tersedia',
                              "umur_hewan_detail":
                                  postData.umur?.toString() ?? 'Tidak tersedia',
                              "identifikasi_hewan_detail":
                                  postData.identifikasiHewan ??
                                      'Tidak tersedia',
                              "petugas_terdaftar_hewan_detail":
                                  postData.petugasPendaftar?.petugasId ??
                                      'Tidak tersedia',
                              "tanggal_terdaftar_hewan_detail":
                                  postData.tanggalTerdaftar ?? 'Tidak tersedia',
                              "foto_hewan_detail":
                                  postData.fotoHewan ?? 'Tidak tersedia',
                            },
                          );
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
                                        : "Id Hewan: ${postData.idHewan}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Kode Eartag Nasional: ${postData.kodeEartagNasional}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    (postData.status == null)
                                        ? "-"
                                        : "Nama peternak: ${postData.idPeternak?.namaPeternak}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 2,
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
