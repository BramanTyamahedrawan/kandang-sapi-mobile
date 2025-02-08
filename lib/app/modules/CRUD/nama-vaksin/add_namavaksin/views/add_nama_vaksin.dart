import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_nama_vaksin_controller.dart';

class AddNamaVaksinView extends GetView<AddNamaVaksinController> {
  const AddNamaVaksinView({super.key});
  @override
  Widget build(BuildContext context) {
    print("Data jenisVaksinList: ${controller.fetchdata.jenisVaksinList}");
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text(
            'Tambah Data Nama Vaksin',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white, // Ikon panah kembali
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
                    Obx(() => DropdownButtonFormField<String>(
                          value: controller
                                  .fetchdata.selectedIdJenisVaksin.value.isEmpty
                              ? null // Jika tidak ada yang dipilih, tetap null
                              : controller
                                  .fetchdata.selectedIdJenisVaksin.value,
                          items: controller.fetchdata.jenisVaksinList
                              .map((JenisVaksinModel jenisVaksins) {
                            return DropdownMenuItem<String>(
                              value: jenisVaksins.idJenisVaksin,
                              child: Text(jenisVaksins.jenis ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: 'poppins')),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.fetchdata.selectedIdJenisVaksin.value =
                                  newValue;
                            }
                          },
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
                            // Placeholder tetap muncul sampai user memilih
                            "Pilih Jenis Vaksin",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'poppins',
                                color: Colors.grey),
                          ),
                        )),
                    const SizedBox(height: 16),
                    TextField(
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                      maxLines: 1,
                      controller: controller.namaC,
                      keyboardType: TextInputType.name,
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
                    const SizedBox(height: 16),
                    TextField(
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                      maxLines: 5,
                      controller: controller.deskripsiC,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Deskripsi",
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
                              controller.addNamaVaksin(context);
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
              ),
            ),
          ],
        ));
  }
}
