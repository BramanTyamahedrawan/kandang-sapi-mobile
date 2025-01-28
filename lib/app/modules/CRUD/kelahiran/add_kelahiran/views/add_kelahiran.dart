import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_kelahiran_controller.dart';

class AddKelahiranView extends GetView<AddkelahiranController> {
  const AddKelahiranView({super.key});
  @override
  Widget build(BuildContext context) {
    var selectedGender;
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Kelahiran',
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
              controller: controller
                  .tanggalLahirC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Lahir" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalLahir(context),
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
              controller: controller
                  .tanggalLaporanC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Laporan" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalLaporan(context),
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
                    "Nama Peternak",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fetchdata.selectedPeternakId.value,
                    items: controller.fetchdata.peternakList
                        .map((PeternakModel peternak) {
                      return DropdownMenuItem<String>(
                        value: peternak.idPeternak ?? '',
                        child: Text(peternak.namaPeternak ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? selectedId) {
                      controller.fetchdata.selectedPeternakId.value =
                          selectedId ?? '';
                    },
                    hint: const Text('Pilih Peternak'),
                  );
                }),
              ],
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
          //     controller: controller.eartagIndukC,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "No Eartag Induk",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "No Eartag Induk",
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
                        value: controller.fetchdata.selectedHewanEartag.value,
                        items: controller.fetchdata.filteredHewanList
                            .map((HewanModel hewan) {
                          return DropdownMenuItem<String>(
                            value: hewan.kodeEartagNasional ?? '',
                            child: Text('${hewan.kodeEartagNasional ?? ''}'
                                '    ${hewan.idPeternak!.namaPeternak ?? ''}'),
                          );
                        }).toList(),
                        onChanged: (String? selectedEartag) {
                          controller.fetchdata.selectedHewanEartag.value =
                              selectedEartag ?? '';
                        },
                        hint: const Text('Pilih Kode Eartag Nasional'),
                        isExpanded: true,
                      );
                    })
                  ])),
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
                    "Nama Kandang",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fetchdata.selectedKandangId.value,
                    items: controller.fetchdata.filteredKandangList
                        .map((KandangModel kandang) {
                      return DropdownMenuItem<String>(
                        value: kandang.idKandang ?? '',
                        child: Text('${kandang.idKandang ?? ''} '
                            '${kandang.desa ?? ''}'
                            ' ${kandang.luas ?? ''}'),
                      );
                    }).toList(),
                    onChanged: (String? selectedNik) {
                      controller.fetchdata.selectedKandangId.value =
                          selectedNik ?? '';
                    },
                    hint: const Text('Pilih Kandang'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Inseminasi",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fetchdata.selectedInseminasiId.value,
                    items: controller.fetchdata.filteredInseminasiList
                        .map((InseminasiModel inseminasi) {
                      return DropdownMenuItem<String>(
                        value: inseminasi.idInseminasi ?? '',
                        child: Text('${inseminasi.tanggalIB ?? ''}'
                            " "
                            '${inseminasi.idInseminasi ?? ''}'),
                      );
                    }).toList(),
                    onChanged: (String? selectedNik) {
                      controller.fetchdata.selectedInseminasiId.value =
                          selectedNik ?? '';
                    },
                    hint: const Text('Pilih Inseminasi'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Petugas Pelapor",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fetchdata.selectedPetugasId.value,
                    items: controller.fetchdata.petugasList
                        .map((PetugasModel petugas) {
                      return DropdownMenuItem<String>(
                        value: petugas.nikPetugas ?? '',
                        child: Text(petugas.namaPetugas ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? selectedNik) {
                      controller.fetchdata.selectedPetugasId.value =
                          selectedNik ?? '';
                    },
                    hint: const Text('Pilih Petugas'),
                  );
                }),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: TextField(
              style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
              maxLines: 1,
              controller: controller.eartagAnakC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "No Eartag Anak",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "No Eartag Anak",
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
            child: DropdownMenu<String>(
              inputDecorationTheme: const InputDecorationTheme(
                  filled: false, iconColor: Colors.amber),
              initialSelection: controller.genders.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                controller.selectedGender.value = value!;
                //Text("${controller.selectedGender ?? ''}");
              },
              dropdownMenuEntries: controller.genders
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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

          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addHewan(context);
                    controller.addKelahiran(context);
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

class Gender {
  int? id;
  String? jenisKelaminAnak;

  Gender({this.id, this.jenisKelaminAnak});
}
