import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_vaksin_controller.dart';

class AddVaksinView extends GetView<AddVaksinController> {
  const AddVaksinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Vaksin',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
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
          Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => DropdownSearch<PeternakModel>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                labelText: "Cari Peternak",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          selectedItem:
                              controller.fetchdata.peternakList.firstWhere(
                            (peternak) =>
                                peternak.idPeternak ==
                                controller.fetchdata.selectedPeternakId.value,
                            orElse: () => PeternakModel(
                                idPeternak: "",
                                namaPeternak: "Pilih Peternak",
                                nikPeternak: "nik"),
                          ),
                          itemAsString: (PeternakModel peternak) =>
                              "${peternak.namaPeternak} (${peternak.nikPeternak})",
                          items: controller.fetchdata.peternakList,
                          onChanged: (PeternakModel? newValue) {
                            if (newValue != null) {
                              controller.fetchdata.selectedPeternakId.value =
                                  newValue.idPeternak ?? '';
                            }
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Peternak",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 218, 13, 6),
                                    width: 1),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w600,
                                color: AppColor.secondarySoft,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => DropdownSearch<HewanModel>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                labelText: "Cari Kode Eartag Hewan",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 183, 190, 196),
                                      width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 183, 190, 196),
                                      width: 0.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 36, 34, 33),
                                      width: 1),
                                ),
                              ),
                            ),
                          ),
                          selectedItem:
                              controller.fetchdata.hewanList.firstWhere(
                            (hewans) =>
                                hewans.idHewan ==
                                controller.fetchdata.selectedHewanEartag.value,
                            orElse: () => HewanModel(
                                idHewan: "",
                                kodeEartagNasional: "Pilih Kode Eartag Hewan",
                                idPeternak: PeternakModel(namaPeternak: "")),
                          ),
                          itemAsString: (HewanModel hewan) =>
                              "${hewan.kodeEartagNasional} ${hewan.idPeternak?.namaPeternak?.isNotEmpty == true ? '(${hewan.idPeternak!.namaPeternak})' : ''}",
                          items: controller.fetchdata.filteredHewanList,
                          onChanged: (HewanModel? newValue) {
                            if (newValue != null) {
                              controller.fetchdata.selectedHewanEartag.value =
                                  newValue.idHewan ?? '';
                            }
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Kode Eartag Hewan",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 218, 13, 6),
                                    width: 1),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w600,
                                color: AppColor.secondarySoft,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: Obx(() {
                        return DropdownButtonFormField<String>(
                          value: controller
                                  .fetchdata.selectedIdNamaVaksin.value.isEmpty
                              ? null
                              : controller.fetchdata.selectedIdNamaVaksin.value,
                          items: controller
                                  .fetchdata.filteredNamaVaksinList.isEmpty
                              ? []
                              : controller.fetchdata.filteredNamaVaksinList
                                  .map((NamaVaksinModel namaVaksins) {
                                  return DropdownMenuItem<String>(
                                    value: namaVaksins.idNamaVaksin,
                                    child: Text(namaVaksins.nama ?? '',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'poppins')),
                                  );
                                }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.fetchdata.selectedIdNamaVaksin.value =
                                  newValue;
                              var selectedNamaVaksin = controller
                                  .fetchdata.filteredNamaVaksinList
                                  .firstWhereOrNull(
                                      (v) => v.idNamaVaksin == newValue);

                              if (selectedNamaVaksin
                                      ?.idJenisVaksin?.idJenisVaksin !=
                                  null) {
                                print(
                                    "id jenis vaksin ada ${selectedNamaVaksin?.idJenisVaksin?.idJenisVaksin}");
                                controller
                                        .fetchdata.selectedIdJenisVaksin.value =
                                    selectedNamaVaksin!
                                        .idJenisVaksin!.idJenisVaksin
                                        .toString();
                              } else {
                                controller
                                    .fetchdata.selectedIdJenisVaksin.value = "";
                              }
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Nama Vaksin",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 183, 190, 196),
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 183, 190, 196),
                                  width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 218, 13, 6),
                                  width: 1),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              color: AppColor.secondarySoft,
                            ),
                          ),
                          hint: const Text(
                            "Pilih Nama Vaksin",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                color: Colors.grey),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: Obx(() => DropdownButtonFormField<String>(
                            value: controller.fetchdata.selectedIdJenisVaksin
                                    .value.isEmpty
                                ? null
                                : controller
                                    .fetchdata.selectedIdJenisVaksin.value,
                            items: controller
                                    .fetchdata.filteredJenisVaksinList.isEmpty
                                ? []
                                : controller.fetchdata.filteredJenisVaksinList
                                    .map((JenisVaksinModel jenisVaksins) {
                                    return DropdownMenuItem<String>(
                                      value: jenisVaksins.idJenisVaksin,
                                      child: Text(jenisVaksins.jenis ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'poppins')),
                                    );
                                  }).toList(),
                            onChanged:
                                null, // Nonaktifkan dropdown agar tidak bisa dipilih manual
                            decoration: InputDecoration(
                              labelText: "Jenis Vaksin",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 218, 13, 6),
                                    width: 1),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w600,
                                color: AppColor.secondarySoft,
                              ),
                            ),
                            hint: const Text(
                              "Jenis Vaksin Otomatis",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                      maxLines: 1,
                      controller: controller.batchVaksinC,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Batch Vaksin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 183, 190, 196),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 183, 190, 196),
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 218, 13, 6), width: 1),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondarySoft,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                      maxLines: 1,
                      controller: controller.vaksinKeC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Dosis Vaksin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 183, 190, 196),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 183, 190, 196),
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 218, 13, 6), width: 1),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondarySoft,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => DropdownSearch<PetugasModel>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                labelText: "Cari Inseminator",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          selectedItem:
                              controller.fetchdata.petugasList.firstWhere(
                            (petugas) =>
                                petugas.petugasId ==
                                controller.fetchdata.selectedPetugasId.value,
                            orElse: () => PetugasModel(
                                petugasId: "",
                                namaPetugas: "Pilih Inseminator",
                                nikPetugas: "nik"),
                          ),
                          itemAsString: (PetugasModel petugas) =>
                              "${petugas.namaPetugas} (${petugas.nikPetugas})",
                          items: controller.fetchdata.petugasList,
                          onChanged: (PetugasModel? newValue) {
                            if (newValue != null) {
                              controller.fetchdata.selectedPetugasId.value =
                                  newValue.petugasId ?? '';
                            }
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Inseminator",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 183, 190, 196),
                                    width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 218, 13, 6),
                                    width: 1),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w600,
                                color: AppColor.secondarySoft,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                      maxLines: 1,
                      controller: controller.tglVaksinC,
                      keyboardType: TextInputType.name,
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () => controller.tanggalIB(context),
                      decoration: InputDecoration(
                        labelText: "Tanggal Vaksin",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 183, 190, 196),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 183, 190, 196),
                              width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 218, 13, 6), width: 1),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondarySoft,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            if (controller.isLoading.isFalse) {
                              controller.addPost(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 45),
                            backgroundColor: const Color(0xff132137),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Text(
                            (controller.isLoading.isFalse)
                                ? 'Simpan'
                                : 'Loading...',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
