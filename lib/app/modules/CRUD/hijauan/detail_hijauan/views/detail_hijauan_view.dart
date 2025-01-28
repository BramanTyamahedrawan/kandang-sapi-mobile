import 'dart:io';

import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';

import '../controllers/detail_hijauan_controller.dart';

class DetailHewanView extends GetView<DetailHijauanController> {
  const DetailHewanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        title: const Text(
          'Detail Hewan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Obx(() {
            if (controller.role == 'ROLE_PETERNAK') {
              return Container();
            } else {
              return IconButton(
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
              );
            }
          })
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
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  controller: controller.kodeEartagNasionalC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      "Kode Eartag Nasional",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Kode Eartag Nasional",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),

          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.noKartuTernakC,
          //         keyboardType: TextInputType.number,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "No Kartu Ternak",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "No Kartu Ternak",
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
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.kabupatenC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Kabupaten",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Kabupaten",
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
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.kecamatanC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Kecamatan",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Kecamatan",
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
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.desaC,
          //         keyboardType: TextInputType.text,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Desa",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Desa",
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
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: controller.isEditing.value
          //         ? Colors.white
          //         : Colors.grey[200],
          //     borderRadius: BorderRadius.circular(8),
          //     border:
          //         Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextFormField(
          //     enabled: controller.isEditing.value,
          //     style: TextStyle(
          //         fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //     maxLines: 1,
          //     controller: TextEditingController(text: controller.alamat.value),
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Alamat",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 15,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Alamat",
          //       hintStyle: TextStyle(
          //         fontSize: 15,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // )),
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
                          print(controller.fetchdata.selectedPeternakId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchdata.selectedPeternakId.value,
                                items: controller.fetchdata.peternakList
                                    .map((PeternakModel peternak) {
                                  return DropdownMenuItem<String>(
                                    value: peternak.idPeternak ?? '',
                                    child: Text(peternak.idPeternak ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  // Update selectedPeternakId
                                  controller.fetchdata.selectedPeternakId
                                      .value = selectedId ?? '';

                                  // Update nikPeternakC and namaPeternakC based on selectedPeternakId
                                  PeternakModel selectedPeternak = controller
                                      .fetchdata.peternakList
                                      .firstWhere(
                                    (peternak) =>
                                        peternak.idPeternak == selectedId,
                                    orElse: () =>
                                        PeternakModel(), // Default value if not found
                                  );

                                  controller.nikPeternakC.text =
                                      selectedPeternak.nikPeternak ?? '';
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
                                text: "ID Kandang ",
                                style: TextStyle(
                                  color: Colors.black, // Warna teks utama
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "(klik edit untuk melihat kandang)",
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
                          print(controller.fetchdata.selectedKandangId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchdata.selectedKandangId.value,
                                items: controller.fetchdata.filteredKandangList
                                    .map((KandangModel kandangss) {
                                  return DropdownMenuItem<String>(
                                    value: kandangss.idKandang ?? '',
                                    child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        '${kandangss.desa ?? ''}  \n'
                                        '${kandangss.idPeternak?.namaPeternak ?? ' '}    '
                                        '${kandangss.luas ?? ''}'
                                        " m2"),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  controller.fetchdata.selectedKandangId.value =
                                      selectedId ?? '';
                                },
                                hint: const Text('Pilih Kandang'),
                              )
                            : TextField(
                                controller: controller.idKandagC,
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
                  controller: controller.nikPeternakC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                      "Nik Peternak",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Nik Peternak",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
                  controller: controller.namaPeternakC,
                  keyboardType: TextInputType.number,
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
                          "Spesies",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.selectedSpesies.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller.selectedSpesies.value ?? '',
                                items: controller.spesies.map((String? valll) {
                                  print(valll);
                                  return DropdownMenuItem<String>(
                                    value: valll ?? '',
                                    child: Text(valll! ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  controller.selectedSpesies.value =
                                      value ?? '';
                                },
                                hint: const Text('Pilih Spesies'),
                              )
                            : TextField(
                                controller: controller.spesiesC,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                      ),
                    ])),
          ),
          // Obx(
          //   () => Container(
          //     width: MediaQuery.of(context).size.width,
          //     padding: EdgeInsets.only(left: 14, right: 14, top: 4),
          //     margin: EdgeInsets.only(bottom: 16),
          //     decoration: BoxDecoration(
          //       color: controller.isEditing.value
          //           ? Colors.white
          //           : Colors.grey[200],
          //       borderRadius: BorderRadius.circular(8),
          //       border: Border.all(
          //         width: 1,
          //         color: AppColor.secondaryExtraSoft,
          //       ),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 0),
          //           child: Text(
          //             "Spesies",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 12,
          //             ),
          //           ),
          //         ),
          //         DropdownMenu<String>(
          //           inputDecorationTheme: InputDecorationTheme(
          //             filled: false,
          //             iconColor: Colors.amber,
          //           ),
          //           initialSelection: controller.selectedSpesies.value,
          //           onSelected: (String? value) {
          //             controller.selectedSpesies.value = value!;
          //           },
          //           dropdownMenuEntries: controller.spesies
          //               .map<DropdownMenuEntry<String>>((String value) {
          //             return DropdownMenuEntry<String>(
          //                 value: value, label: value);
          //           }).toList(),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

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
                          "Sex",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.selectedGender.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller.selectedGender.value ?? '',
                                items: controller.genders.map((String? valll) {
                                  print(valll);
                                  return DropdownMenuItem<String>(
                                    value: valll ?? '',
                                    child: Text(valll! ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  controller.selectedGender.value = value ?? '';
                                },
                                hint: const Text('Pilih Jenis Kelamin'),
                              )
                            : TextField(
                                controller: controller.sexC,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  controller: controller.umurC,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.calendar_today),
                    labelText: "Umur",
                  ),
                  readOnly: !controller.isEditing
                      .value, // Memastikan bahwa TextField dapat diedit hanya jika isEditing bernilai true
                  onTap: () {
                    if (controller.isEditing.value) {
                      controller.tanggalLahir(context);
                    }
                  },
                ),
              )),
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
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  controller: controller.identifikasiHewanC,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: Text(
                      "Identifikasi Hewan",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Identifikasi Hewan",
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
                          print(controller.fetchdata.selectedPetugasId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchdata.selectedPetugasId.value,
                                items: controller.fetchdata.petugasList
                                    .map((PetugasModel petugass) {
                                  print(controller
                                      .fetchdata.selectedPetugasId.value);
                                  return DropdownMenuItem<String>(
                                    value: petugass.nikPetugas ?? '',
                                    child: Text(petugass.namaPetugas ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  controller.fetchdata.selectedPetugasId.value =
                                      selectedId ?? '';
                                },
                                hint: const Text('Pilih Petugas'),
                              )
                            : TextField(
                                controller: controller.petugasPendaftarC,
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  controller: controller.tanggalTerdaftarC,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.calendar_today),
                    labelText: "Tanggal Terdaftar",
                  ),
                  readOnly: !controller.isEditing
                      .value, // Memastikan bahwa TextField dapat diedit hanya jika isEditing bernilai true
                  onTap: () {
                    if (controller.isEditing.value) {
                      controller.tanggalTerdaftar(context);
                    }
                  },
                ),
              )),

          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
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
                  controller: controller.alamatC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                      "alamat",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "alamat",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
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
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.isEditing.value) {
                          controller
                              .pickImage(true); // Fungsi untuk memilih gambar
                        }
                      },
                      child: Obx(() {
                        // Gunakan nilai fotoKandang dari controller
                        File? selectedImage = controller.fotoHewan.value;
                        if (selectedImage != null) {
                          // Jika ada gambar yang dipilih, tampilkan menggunakan Image.file
                          return Image.file(
                            selectedImage,
                            fit: BoxFit.fill,
                          );
                        } else {
                          // Jika tidak ada gambar yang dipilih, tampilkan menggunakan Image.network
                          return Image.network(
                            '${controller.sharedApi.imageUrl + 'hewan/'}${controller.argsData["foto_hewan_detail"]}',
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Placeholder(
                                // Placeholder image or widget to show on error
                                fallbackHeight: 100,
                                fallbackWidth: 100,
                              );
                            },
                          );
                        }
                      }),
                    ),
                    if (controller.isEditing.value)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            controller.pickImage(
                                false); // Fungsi untuk memilih gambar
                          },
                        ),
                      ),
                  ],
                ),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => Visibility(
                visible: controller.isEditing.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Titik Kordinat",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Text(controller.strLatLong.value),
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: controller.strLatLong.value));
                        final snackBar = SnackBar(
                          content: const Text("LatLong berhasil disalin!"),
                          backgroundColor: Colors.green,
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: "tutup",
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "alamat",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: GestureDetector(
                        child: Text(controller.strAlamat.value),
                        onLongPress: () {
                          Clipboard.setData(
                              ClipboardData(text: controller.strAlamat.value));
                          final snackBar = SnackBar(
                            content: const Text("Alamat Berhasil Disalin!"),
                            backgroundColor: (Colors.green),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: "Tutup",
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.loading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                // Mengubah status loading menjadi true untuk menunjukkan bahwa proses sedang berlangsung
                                controller.loading.value = true;

                                // Mendapatkan posisi geolokasi
                                Position position =
                                    await controller.getGeoLocationPosition();

                                // Mengubah status loading menjadi false setelah mendapatkan posisi
                                controller.loading.value = false;

                                // Memperbarui nilai strLatLong dengan koordinat yang didapatkan
                                controller.strLatLong.value =
                                    '${position.latitude}, ${position.longitude}';

                                // Mendapatkan alamat dari koordinat
                                if (controller.isEditing.value) {
                                  await controller.updateAlamatInfo();
                                  controller.update();
                                }

                                // Mendapatkan alamat dari koordinat
                                await controller
                                    .getAddressFromLongLat(position);
                              } catch (e) {
                                // Handle error jika terjadi kesalahan
                                print('Error in onPressed: $e');
                                controller.loading.value =
                                    false; // Pastikan status loading diubah kembali jika terjadi kesalahan
                              }
                            },
                            child: controller.loading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const Text('Tagging Lokasi')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
//AND DELETE
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.isEditing.value)
                    ElevatedButton(
                      onPressed: () {
                        controller.editHewan();
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
                        controller.deleteHewan();
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
