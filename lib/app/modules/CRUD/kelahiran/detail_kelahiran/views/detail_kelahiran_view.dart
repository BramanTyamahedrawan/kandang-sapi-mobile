import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_kelahiran_controller.dart';

class DetailKelahiranView extends GetView<DetailKelahiranController> {
  const DetailKelahiranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        title: const Text(
          'Detail Kelahiran',
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
            Obx(() {
              return Container(
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
                  controller: controller.idKejadianC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "ID Kejadian",
                    labelStyle: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 15,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "ID Kejadian",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              );
            }),
            Obx(() => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: controller.isEditing.value
                        ? Colors.white
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    enabled: controller.isEditing.value,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        color: Colors.black),
                    maxLines: 1,
                    controller: controller.tanggalLahirC,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today),
                      labelText: "Tanggal Lahir",
                    ),
                    readOnly: true,
                    onTap: () => controller.tanggalLahir(context),
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextField(
                    enabled: controller.isEditing.value,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        color: Colors.black),
                    maxLines: 1,
                    controller: controller.tanggalLaporanC,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today),
                      labelText: "Tanggal Laporan",
                    ),
                    readOnly: true,
                    onTap: () => controller.tanggalLaporan(context),
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
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
                            print(
                                controller.fetchData.selectedPeternakId.value);
                          },
                          child: controller.isEditing.value
                              ? DropdownButton<String>(
                                  value: controller
                                      .fetchData.selectedPeternakId.value,
                                  items: controller.fetchData.peternakList
                                      .map((PeternakModel peternak) {
                                    return DropdownMenuItem<String>(
                                      value: peternak.idPeternak ?? '',
                                      child: Text('${peternak.idPeternak ?? ''}'
                                          "\n"
                                          '${peternak.namaPeternak}'),
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
                                    // controller.namaPeternakC.text =
                                    //     selectedPeternak.namaPeternak ?? '';
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
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
                            print(
                                controller.fetchData.selectedHewanEartag.value);
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
                                          '${hewan.kodeEartagNasional ?? ''}'
                                          '\n'
                                          '${hewan.idPeternak?.namaPeternak}'),
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
                                  hint:
                                      const Text('Pilih Kode Eartag Nasional'),
                                )
                              : TextField(
                                  controller: controller.kodeEartagNasionalC,
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            "ID Kandang",
                            style: TextStyle(
                              color: AppColor.secondarySoft,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print(controller.fetchData.selectedKandangId.value);
                          },
                          child: controller.isEditing.value
                              ? DropdownButton<String>(
                                  value: controller
                                      .fetchData.selectedKandangId.value,
                                  items: controller
                                      .fetchData.filteredKandangList
                                      .map((KandangModel kandang) {
                                    return DropdownMenuItem<String>(
                                      value: kandang.idKandang ?? '',
                                      child: Text('${kandang.idKandang ?? ''}'
                                          '\n'
                                          '${kandang.idPeternak?.namaPeternak}'),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedIdkandang) {
                                    // Update selectedPeternakId
                                    controller.fetchData.selectedKandangId
                                        .value = selectedIdkandang ?? '';

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
                                  hint: const Text('Pilih ID Kandang'),
                                )
                              : TextField(
                                  controller: controller.idKandangC,
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
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
                                  text: "ID Inseminasi ",
                                  style: TextStyle(
                                    color: Colors.black, // Warna teks utama
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: "",
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
                            print(controller
                                .fetchData.selectedInseminasiId.value);
                          },
                          child: controller.isEditing.value
                              ? DropdownButton<String>(
                                  value: controller
                                      .fetchData.selectedInseminasiId.value,
                                  items: controller
                                      .fetchData.filteredInseminasiList
                                      .map((InseminasiModel inseminasi) {
                                    return DropdownMenuItem<String>(
                                      value: inseminasi.idInseminasi ?? '',
                                      child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          '${inseminasi.tanggalIB ?? ''}  \n'
                                          '${inseminasi.idPeternak?.namaPeternak ?? ' '}    '),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedId) {
                                    controller.fetchData.selectedInseminasiId
                                        .value = selectedId ?? '';
                                  },
                                  hint: const Text('Pilih Inseminasi'),
                                )
                              : TextField(
                                  controller: controller.idInseminasiC,
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            "Nama Petugas",
                            style: TextStyle(
                              color: AppColor.secondarySoft,
                              fontSize: 12,
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
                                    return DropdownMenuItem<String>(
                                      value: petugass.nikPetugas ?? '',
                                      child: Text(
                                        '${petugass.nikPetugas ?? ''}'
                                        "\n"
                                        '${petugass.namaPetugas ?? ''}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? selectedId) {
                                    controller.fetchData.selectedPetugasId
                                        .value = selectedId ?? '';
                                  },
                                  hint: const Text('Pilih Petugas'),
                                )
                              : TextField(
                                  controller: controller.petugasPelaporC,
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: TextFormField(
                    enabled: controller.isEditing.value,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'poppins',
                        color: Colors.black),
                    maxLines: 1,
                    autofocus: true,
                    controller: controller.eartagAnakC,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text(
                        "Eartag Anak",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 15,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "Eartag Anak",
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            "Spesies Anak",
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
                                  items:
                                      controller.spesies.map((String? valll) {
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
                                  hint: const Text('Pilih Spesies Anak'),
                                )
                              : TextField(
                                  controller: controller.spesiesAnakC,
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
                    border: Border.all(
                        width: 1, color: AppColor.secondaryExtraSoft),
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
                                  items:
                                      controller.genders.map((String? valll) {
                                    print(valll);
                                    return DropdownMenuItem<String>(
                                      value: valll ?? '',
                                      child: Text(valll! ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    controller.selectedGender.value =
                                        value ?? '';
                                  },
                                  hint: const Text('Pilih Jenis Kelamin anak'),
                                )
                              : TextField(
                                  controller: controller.jenisKelaminAnakC,
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
            Obx(
              () {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.isEditing.value)
                      ElevatedButton(
                        onPressed: () {
                          controller.editKelahiran();
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
                          controller.deleteKelahiran();
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
          ]),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.primary,
//       appBar: AppBar(
//         title: Text(
//           'Detail Kelahiran',
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
//        actions: [
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
          
//           Obx(() => Container(
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//                 margin: EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: controller.isEditing.value
//                       ? Colors.grey[200]
//                       : Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                   border:
//                       Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//                 ),
//                 child: TextFormField(
//                   enabled: false,
//                   style: TextStyle(
//                       fontSize: 18, fontFamily: 'poppins', color: Colors.black),
//                   maxLines: 1,
//                   autofocus: true,
//                   controller: controller.idKejadianC,
//                   keyboardType: TextInputType.name,
//                   decoration: InputDecoration(
//                     label: Text(
//                       "ID Kejadian",
//                       style: TextStyle(
//                         color: AppColor.secondarySoft,
//                         fontSize: 15,
//                       ),
//                     ),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     border: InputBorder.none,
//                     hintText: "ID Kejadian",
//                     hintStyle: TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'poppins',
//                       fontWeight: FontWeight.w500,
//                       color: AppColor.secondarySoft,
//                     ),
//                   ),
//                 ),
//               )),
//            Obx(() => Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.eartagIndukC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "No Eartag Induk",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "No Eartag Induk",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() => Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.eartagAnakC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "No Eartag Anak",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "No Eartag Anak",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idHewanIndukC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Hewan Induk",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Hewan Induk",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idHewanAnakC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Hewan Anak",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Hewan Anak",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idBatchStrawC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Batch",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Batch",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idPejantanStrawC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id Pejantan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id Pejantan",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.jenisKelaminAnakC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Jenis Kelamin Anak",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Jenis Kelamin Anak",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.jumlahC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Jumlah",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Jumlah",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.urutanIbC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Urutan IB",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Urutan IB",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.kartuTernakAnakC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Kartu Ternak Anak",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Kartu Ternak Anak",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.kartuTernakIndukC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "kartu Ternak Induk",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "kartu Ternak Induk",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.kategoriC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Kategori",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Kategori",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.lokasiC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Lokasi",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Lokasi",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.idPeternakC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Id peternak",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Id peternak",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.namaPeternakC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Nama Peternak",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Nama Peternak",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.petugasPelaporC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Petugas Pelapor",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Petugas Pelapor",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.produsenStrawC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Produsen",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Produsen",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.spesiesIndukC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Spesies Induk",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Spesies Induk",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.spesiesPejantanC,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Spesies Pejantan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Spesies Pejantan",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.tanggalLahirC,
//               keyboardType: TextInputType.datetime,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Tanggal Lahir",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Tanggal Lahir",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Obx(() =>Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//             ),
//             child: TextField(
//               style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
//               maxLines: 1,
//               controller: controller.tanggalLaporanC,
//               keyboardType: TextInputType.datetime,
//               decoration: InputDecoration(
//                 label: Text(
//                   "Tanggal Laporan",
//                   style: TextStyle(
//                     color: AppColor.secondarySoft,
//                     fontSize: 14,
//                   ),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//                 border: InputBorder.none,
//                 hintText: "Tanggal Laporan",
//                 hintStyle: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'poppins',
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.secondarySoft,
//                 ),
//               ),
//             ),
//           )),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Get.offAllNamed(Routes.EDITKELAHIRAN);
//                 },
//                 child: Text(
//                   'Edit post',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'poppins',
//                     color: Colors.white,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: Size(120, 55),
//                   backgroundColor: Color(0xff132137),
//                   padding: EdgeInsets.symmetric(vertical: 18),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 25,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   controller.deleteKelahiran();
//                 },
//                 child: Text(
//                   'Delete post',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'poppins',
//                     color: Colors.white,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: Size(120, 55),
//                   backgroundColor: Color(0xff132137),
//                   padding: EdgeInsets.symmetric(vertical: 18),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }