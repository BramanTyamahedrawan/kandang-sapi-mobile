import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_vaksin_controller.dart';

class DetailVaksinView extends GetView<DetailVaksinController> {
  const DetailVaksinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        title: const Text(
          'Detail Vaksin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Visibility(
            visible: controller.role != 'ROLE_PETERNAK',
            child: IconButton(
              onPressed: () {
                if (controller.isEditing.value) {
                  controller.tutupEdit();
                } else {
                  controller.tombolEdit();
                }
              },
              icon: Obx(
                () {
                  return Icon(
                    controller.isEditing.value ? Icons.close : Icons.edit,
                    color: AppColor.warning,
                  );
                },
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xff132137),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // Id vaksin
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.grey[200]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: false,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  controller: controller.idVaksinC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      "Id vaksin",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Id vaksin",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),

          Obx(
            () => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          "Id Peternak",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.fetchData.selectedPeternakId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchData.selectedPeternakId.value,
                                items: controller.fetchData.peternakList
                                    .map((PeternakModel peternak) {
                                  return DropdownMenuItem<String>(
                                    value: peternak.idPeternak ?? '',
                                    child: Text(peternak.idPeternak ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  // Update selectedPeternakId
                                  controller.fetchData.selectedPeternakId
                                      .value = selectedId ?? '';

                                  // Update nikPeternakC and namaPeternakC based on selectedPeternakId
                                  PeternakModel selectedPeternak = controller
                                      .fetchData.peternakList
                                      .firstWhere(
                                    (peternak) =>
                                        peternak.idPeternak == selectedId,
                                    orElse: () =>
                                        PeternakModel(), // Default value if not found
                                  );
                                  controller.namaPeternakC.text =
                                      selectedPeternak.namaPeternak ?? '';
                                },
                                hint: const Text('Pilih Peternak'),
                              )
                            : TextField(
                                controller: controller.idPeternakC,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  // labelText: 'ID Peternak',
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                      ),
                    ])),
          ),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.grey[200]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  readOnly: true,
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  controller: controller.namaPeternakC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      "Nama Peternak",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Nama Peternak",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          // No Eartag Nasional
          Obx(
            () => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Text(
                          "No eartag Nasional",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.fetchData.selectedHewanEartag.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchData.selectedHewanEartag.value,
                                items: controller.fetchData.filteredHewanList
                                    .map((HewanModel hewan) {
                                  return DropdownMenuItem<String>(
                                    value: hewan.kodeEartagNasional ?? '',
                                    child: Text(
                                        "${hewan.kodeEartagNasional ?? ''}"
                                        "\n"
                                        "${hewan.idPeternak?.namaPeternak ?? ''}"),
                                  );
                                }).toList(),
                                onChanged: (String? selectedEartag) {
                                  // Update selectedPeternakId
                                  controller.fetchData.selectedHewanEartag
                                      .value = selectedEartag ?? '';

                                  // // Update nikPeternakC and namaPeternakC based on selectedPeternakId
                                  // HewanModel selectedHewan =
                                  //     controller.hewanList.firstWhere(
                                  //   (hewansssss) =>
                                  //       hewansssss.kodeEartagNasional ==
                                  //       selectedEartag,
                                  //   orElse: () =>
                                  //       HewanModel(), // Default value if not found
                                  // );
                                  // controller.eartagC.text =
                                  //     selectedHewan.kodeEartagNasional ?? '';
                                },
                                hint: const Text('Pilih Kode Eartag Nasional'),
                              )
                            : TextField(
                                controller: controller.eartagC,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  // labelText: 'ID Peternak',
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                      ),
                    ])),
          ),
          // Id Pembuatan
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  controller: controller.namaVaksinC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      "Nama Vaksin",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Nama Vaksin",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          // Id Pejantan
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  controller: controller.jenisVaksinC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      "Jensi Vaksin",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Jensi Vaksin",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          // Bangsa Pejantan
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.bangsaPejantanC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Bangsa Pejantan",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Bangsa Pejantan",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // // IB 1
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.ib1C,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "IB 1",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "IB 1",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // // IB 2
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.ib2C,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "IB 2",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "IB 2",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // // IB 3

          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.ib3C,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "IB 3",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "IB 3",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.ibLainC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "IB Lain",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "IB Lain",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.produsenC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Produsen",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Produsen",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),

          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 15, right: 15, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //           fontSize: 18,
          //           fontFamily: 'poppins',
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         controller: controller.lokasiC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Lokasi",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Lokasi",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          Obx(
            () => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Nama Petugas ",
                                style: TextStyle(
                                  color: Colors.black, // Warna teks utama
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "(klik edit untuk mengganti nama petugas)",
                                style: TextStyle(
                                  color: Colors.red, // Warna teks miring
                                  fontStyle:
                                      FontStyle.italic, // Membuat teks miring
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.fetchData.selectedPetugasId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchData.selectedPetugasId.value,
                                items: controller.fetchData.petugasList
                                    .map((PetugasModel petugass) {
                                  print(controller
                                      .fetchData.selectedPetugasId.value);
                                  return DropdownMenuItem<String>(
                                    value: petugass.nikPetugas ?? '',
                                    child: Text(petugass.namaPetugas ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  controller.fetchData.selectedPetugasId.value =
                                      selectedId ?? '';
                                },
                                hint: const Text('Pilih Petugas'),
                              )
                            : TextField(
                                controller: controller.inseminatorC,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  // labelText: 'ID Peternak',
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                      ),
                    ])),
          ),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  controller: controller.tglVaksinC,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.calendar_today),
                    labelText: "Tanggal Vaksin",
                  ),
                  readOnly: true,
                  onTap: () => controller.Kalender(context),
                ),
              )),
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.isEditing.value)
                    ElevatedButton(
                      onPressed: () {
                        controller.editVaksin();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 55),
                        backgroundColor: const Color(0xff132137),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Edit post',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (!controller.isEditing.value &&
                      controller.role != 'ROLE_PETERNAK')
                    ElevatedButton(
                      onPressed: () {
                        controller.deleteVaksin();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 55),
                        backgroundColor: const Color(0xff132137),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Delete post',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          color: AppColor.warning,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}


// import 'package:crud_flutter_api/app/utils/app_color.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../controllers/detail_vaksin_controller.dart';

// class DetailVaksinView extends GetView<DetailVaksinController> {
//   const DetailVaksinView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Detail Data',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back), // Ikon panah kembali
//           onPressed: () {
//             Navigator.of(context).pop(); // Aksi saat tombol diklik
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               if (controller.isEditing.value) {
//                 controller.tutupEdit();
//               } else {
//                 controller.tombolEdit();
//               }
//             },
//             icon: Obx(() {
//               return Icon(
//                 controller.isEditing.value ? Icons.close : Icons.edit,
//               );
//             }),
//           ),
//         ],
//         backgroundColor: Color(0xff132137),
//         elevation: 0,
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(1),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: 1,
//             color: AppColor.secondaryExtraSoft,
//           ),
//         ),
//       ),
//       body: ListView(
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         padding: EdgeInsets.all(20),
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idVaksinC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id vaksin",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id vaksin",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.eartagC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "No Eartag Nasional",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "No Eartag Nasional",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idHewanC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Hewan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Hewan",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idPembuatanC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Pembuatan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Pembuatan",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idPejantanC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Pejantan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Pejantan",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.bangsaPejantanC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Bangsa Pejantan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Bangsa Pejantan",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.ib1C,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "IB 1",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "IB 1",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 15, right: 15, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 15, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.ib2C,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "IB 2",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 15,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "IB 2",
//                 hintStyle: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           ),