import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_nama_vaksin_controller.dart';

class DetailNamaVaksinView extends GetView<DetailNamaVaksinController> {
  const DetailNamaVaksinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Detail Nama Vaksin',
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
                  buildTextField("Id", controller.idNamaVaksinC, false, 1),

                  // Dropdown Jenis Vaksin
                  Obx(() {
                    return buildDropdownJenisVaksin();
                  }),

                  Obx(() {
                    return buildTextField("Nama Vaksin", controller.namaC,
                        controller.isEditing.value, 1);
                  }),
                  Obx(() {
                    return buildTextField("Deskripsi", controller.deskripsiC,
                        controller.isEditing.value, 5);
                  }),
                  Obx(() {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.isEditing.value
                              ? controller.editNamaVaksin()
                              : controller.deleteNamaVaksin();
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

  Widget buildDropdownJenisVaksin() {
    // Pastikan selectedIdJenisVaksin cocok dengan item yang ada di dropdown
    final selectedValue = controller.fetchData.selectedIdJenisVaksin.value;
    final isValid = controller.fetchData.jenisVaksinList
        .any((jenis) => jenis.idJenisVaksin == selectedValue);

    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: isValid
            ? selectedValue
            : null, // Hindari error dengan set null jika tidak valid
        items: controller.fetchData.jenisVaksinList.map((jenisVaksin) {
          return DropdownMenuItem<String>(
            value: jenisVaksin.idJenisVaksin,
            child: Text(
              jenisVaksin.jenis ?? '',
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
            ),
          );
        }).toList(),
        onChanged: controller.isEditing.value
            ? (String? newValue) {
                if (newValue != null) {
                  controller.fetchData.selectedIdJenisVaksin.value = newValue;
                }
              }
            : null,
        decoration: InputDecoration(
          labelText: "Jenis Vaksin",
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
            fontSize: 18, fontFamily: 'poppins', color: Colors.black),
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
