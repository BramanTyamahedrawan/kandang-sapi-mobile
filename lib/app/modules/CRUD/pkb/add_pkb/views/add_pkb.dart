import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_pkb_controller.dart';

class AddPkbView extends GetView<AddPkbController> {
  const AddPkbView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Pkb',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali
          onPressed: () {
            Navigator.of(context).pop(); // Aksi saat tombol diklik
          },
        ),
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              maxLines: 1,
              controller: controller.idKejadianC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Id Kejadian",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Id Kejadian",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: const EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.idHewanC,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Id Hewan",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Id Hewan",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.idPeternakC,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Id Peternak",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Id Peternak",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.nikPeternakC,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "NIK Peternak",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "NIK Peternak",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Nama Peternak",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fecthaddData.selectedPeternakId.value,
                    items: controller.fecthaddData.peternakList
                        .map((PeternakModel peternak) {
                      return DropdownMenuItem<String>(
                        value: peternak.idPeternak ?? '',
                        child: Text(peternak.namaPeternak ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? selectedId) {
                      controller.fecthaddData.selectedPeternakId.value =
                          selectedId ?? '';
                    },
                    hint: const Text('Pilih Peternak'),
                  );
                }),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                        "Kode Eartag Nasional",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Obx(() {
                      return DropdownButton<String>(
                        value:
                            controller.fecthaddData.selectedHewanEartag.value,
                        items: controller.fecthaddData.filteredHewanList
                            .map((HewanModel hewan) {
                          return DropdownMenuItem<String>(
                            value: hewan.kodeEartagNasional ?? '',
                            child: Text('${hewan.kodeEartagNasional ?? ''}'
                                '    ${hewan.idPeternak!.namaPeternak ?? ''}'),
                          );
                        }).toList(),
                        onChanged: (String? selectedEartag) {
                          controller.fecthaddData.selectedHewanEartag.value =
                              selectedEartag ?? '';
                        },
                        hint: const Text('Pilih Kode Eartag Nasional'),
                        isExpanded: true,
                      );
                    })
                  ])),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: const EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.jumlahC,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Jumlah",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Jumlah",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: const EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.kategoriC,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Kategori",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Kategori",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: const EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.lokasiC,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Lokasi",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Lokasi",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Obx(
                () => DropdownMenu<String>(
                  inputDecorationTheme: const InputDecorationTheme(
                      filled: false, iconColor: Colors.amber),
                  initialSelection: controller.selectedSpesies.value,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    controller.selectedSpesies.value = value!;
                  },
                  dropdownMenuEntries: controller.spesies
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
            ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              maxLines: 1,
              controller: controller.umurKebuntinganC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Umur Kebuntingan",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Umur Kebuntingan",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Pemeriksa Kebuntingan",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fecthaddData.selectedPetugasId.value,
                    items: controller.fecthaddData.petugasList
                        .map((PetugasModel petugas) {
                      print(controller.fecthaddData.selectedPetugasId.value);
                      return DropdownMenuItem<String>(
                        value: petugas.nikPetugas ?? '',
                        child: Text(petugas.namaPetugas ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? selectedNik) {
                      controller.fecthaddData.selectedPetugasId.value =
                          selectedNik ?? '';
                    },
                    hint: const Text('Pemeriksa Kebuntingan'),
                  );
                }),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              maxLines: 1,
              controller:
                  controller.tanggalPkbC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Pkb" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalPkb(context),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addPKB(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff132137),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  (controller.isLoading.isFalse) ? 'Tambah post' : 'Loading...',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
