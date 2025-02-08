import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/namavaksin_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_vaksin_controller.dart';

class DetailVaksinView extends GetView<DetailVaksinController> {
  const DetailVaksinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Detail Vaksin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
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
          Card(
            color: Colors.white,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 65,
                    child: buildTextField("Id", controller.idVaksinC, false, 1),
                  ),
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
                        enabled: controller.isEditing.value,
                        selectedItem:
                            controller.fetchData.peternakList.firstWhere(
                          (peternak) =>
                              peternak.idPeternak ==
                              controller.fetchData.selectedPeternakId.value,
                          orElse: () => PeternakModel(
                              idPeternak: "",
                              namaPeternak: "Pilih Peternak",
                              nikPeternak: "nik"),
                        ),
                        itemAsString: (PeternakModel peternak) =>
                            "${peternak.namaPeternak} (${peternak.nikPeternak})",
                        items: controller.fetchData.peternakList,
                        onChanged: (PeternakModel? newValue) {
                          if (newValue != null) {
                            controller.fetchData.selectedPeternakId.value =
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
                    height: 17,
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
                        enabled: controller.isEditing.value,
                        selectedItem: controller.fetchData.hewanList.firstWhere(
                          (hewans) =>
                              hewans.idHewan ==
                              controller.fetchData.selectedHewanEartag.value,
                          orElse: () => HewanModel(
                              idHewan: "",
                              kodeEartagNasional: "Pilih Kode Eartag Hewan"),
                        ),
                        itemAsString: (HewanModel hewan) =>
                            "${hewan.kodeEartagNasional}",
                        items: controller.fetchData.hewanList,
                        onChanged: (HewanModel? newValue) {
                          if (newValue != null) {
                            controller.fetchData.selectedHewanEartag.value =
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
                    height: 65,
                    child: Obx(() {
                      return buildDropdown(
                        label: "Nama Vaksin",
                        items: controller.fetchData.filteredNamaVaksinList,
                        selectedValue:
                            controller.fetchData.selectedIdNamaVaksin.value,
                        getItemValue: (namaVaksin) =>
                            namaVaksin.idNamaVaksin ?? '',
                        getItemLabel: (namaVaksin) => namaVaksin.nama ?? '',
                        onChanged: (newValue) {
                          if (newValue != null) {
                            controller.fetchData.selectedIdNamaVaksin.value =
                                newValue;
                            // Otomatis update jenis vaksin berdasarkan nama vaksin yang dipilih
                            var selectedVaksin = controller
                                .fetchData.filteredNamaVaksinList
                                .firstWhere((v) => v.idNamaVaksin == newValue,
                                    orElse: () => NamaVaksinModel(
                                        idNamaVaksin: "", idJenisVaksin: null));
                            if (selectedVaksin.idJenisVaksin != null) {
                              controller.fetchData.selectedIdJenisVaksin.value =
                                  selectedVaksin.idJenisVaksin!.idJenisVaksin
                                      .toString();
                            }
                          }
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    height: 65,
                    child: Obx(() {
                      return buildDropdown(
                        label: "Jenis Vaksin",
                        items: controller.fetchData.jenisVaksinList,
                        selectedValue:
                            controller.fetchData.selectedIdJenisVaksin.value,
                        getItemValue: (jenisVaksin) =>
                            jenisVaksin.idJenisVaksin ?? '',
                        getItemLabel: (jenisVaksin) => jenisVaksin.jenis ?? '',
                        onChanged: null,
                      );
                    }),
                  ),
                  SizedBox(
                    height: 65,
                    child: Obx(() {
                      return buildTextField(
                          "Batch Vaksin",
                          controller.batchVaksinC,
                          controller.isEditing.value,
                          1);
                    }),
                  ),
                  SizedBox(
                    height: 65,
                    child: Obx(() {
                      return buildTextField("Dosis Vaksin",
                          controller.vaksinKeC, controller.isEditing.value, 1);
                    }),
                  ),
                  SizedBox(
                    height: 65,
                    child: Obx(() {
                      return buildTextField("Tanggal Vaksin",
                          controller.tglVaksinC, controller.isEditing.value, 1);
                    }),
                  ),
                  SizedBox(
                    height: 65,
                    child: Obx(() {
                      return buildDropdown(
                        label: "Inseminator",
                        items: controller.fetchData.petugasList,
                        selectedValue:
                            controller.fetchData.selectedPetugasId.value,
                        getItemValue: (petugas) => petugas.petugasId ?? '',
                        getItemLabel: (petugas) => petugas.namaPetugas ?? '',
                        onChanged: (newValue) {
                          if (newValue != null) {
                            controller.fetchData.selectedPetugasId.value =
                                newValue;
                          }
                        },
                      );
                    }),
                  ),
                  Obx(() {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.isEditing.value
                              ? controller.editVaksin()
                              : controller.deleteVaksin();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 45),
                          backgroundColor: const Color(0xff132137),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          controller.isEditing.value ? 'Simpan' : 'Delete Data',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'poppins',
                              color: AppColor.primaryExtraSoft),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown<T>({
    required String label,
    required List<T> items,
    required String? selectedValue,
    required String Function(T) getItemValue, // Ambil value dari objek
    required String Function(T) getItemLabel, // Ambil label dari objek
    required void Function(String?)? onChanged, // Event handler
  }) {
    final isValid = items.any((item) => getItemValue(item) == selectedValue);

    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: isValid
            ? selectedValue
            : null, // Hindari error jika value tidak ada di list
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: getItemValue(item),
            child: Text(
              getItemLabel(item),
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
            ),
          );
        }).toList(),
        onChanged: controller.isEditing.value ? onChanged : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
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
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      bool isEditable, int maxLine) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        maxLines: maxLine,
        enabled: isEditable,
        style: const TextStyle(
            fontSize: 14, fontFamily: 'poppins', color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
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
    );
  }
}
