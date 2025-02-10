import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
// Import CupertinoAlertDialog

import 'package:get/get.dart';

import '../controllers/add_petugas_controller.dart';

class AddPetugasView extends GetView<AddPetugasController> {
  const AddPetugasView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPetugasController controller = Get.find<AddPetugasController>();

    // Panggil fetchProvinces saat halaman dimuat
    controller.fetchProvinces();

    return Scaffold(
      resizeToAvoidBottomInset: true,  // Menyelesaikan masalah layout dengan keyboard
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Petugas',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
              controller: controller.nikC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "NIK Petugas",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "NIK KTP",
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
              maxLines: 1,
              controller: controller.namaC,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                label: Text(
                  "Nama Petugas",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Nama Lengkap",
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
              maxLines: 1,
              controller: controller.notlpC,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                label: Text(
                  "No Telepon",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "No Telepon",
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
              maxLines: 1,
              controller: controller.emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text(
                  "Email",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Email",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ),
          // Dropdown untuk Provinsi
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: InputDecoration(
                    labelText: "Pilih Provinsi",
                    labelStyle:
                        TextStyle(color: AppColor.secondarySoft, fontSize: 14),
                    border: InputBorder.none,
                  ),
                  value: controller.selectedProvince.value,
                  items: controller.provinces.map((province) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: province,
                      child:
                          Text(province['name']), // Menampilkan nama provinsi
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedProvince.value = value!;
                    controller.selectedCity.value = null; // Reset city
                    controller.selectedDistrict.value = null; // Reset district
                    controller.fetchCities(
                        value['id']); // Ambil kota berdasarkan provinsi
                  },
                );
              },
            ),
          ),
          // Dropdown untuk Kabupaten
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: InputDecoration(
                    labelText: "Pilih Kabupaten",
                    labelStyle:
                        TextStyle(color: AppColor.secondarySoft, fontSize: 14),
                    border: InputBorder.none,
                  ),
                  value: controller.selectedCity.value,
                  items: controller.cities.map((city) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: city,
                      child: Text(city['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedCity.value = value!;
                    controller.selectedDistrict.value = null; // Reset district
                    controller.fetchDistricts(
                        value['id']); // Ambil kecamatan berdasarkan kabupaten
                  },
                );
              },
            ),
          ),
          // Dropdown untuk Kabupaten
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: InputDecoration(
                    labelText: "Pilih Kecamatan",
                    labelStyle:
                        TextStyle(color: AppColor.secondarySoft, fontSize: 14),
                    border: InputBorder.none,
                  ),
                  value: controller.selectedDistrict.value,
                  items: controller.districts.map((district) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: district,
                      child: Text(district['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedDistrict.value = value;
                    controller.updateWilayah(); // Update wilayah
                  },
                );
              },
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
            child: Obx(
              () => TextField(
                style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                maxLines: 1,
                readOnly:
                    true, // Field hanya bisa dibaca, tidak bisa diketik manual
                controller:
                    TextEditingController(text: controller.wilayah.value),
                decoration: InputDecoration(
                  label: Text(
                    "Wilayah",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 14,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  // hintText: "Pilih Provinsi, Kabupaten, dan Kecamatan",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondarySoft,
                  ),
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
            child: Obx(
              () => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Pilih Pekerjaan",
                  labelStyle:
                      TextStyle(color: AppColor.secondarySoft, fontSize: 14),
                  border: InputBorder.none,
                ),
                value: controller.selectedJob.value,
                items: controller.jobOptions.map((job) {
                  return DropdownMenuItem<String>(
                    value: job,
                    child: Text(job),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedJob.value = value;
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addUser(context);
                    controller.addPetugas(context);
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

//   // Fungsi untuk membuat TextField lebih modular
//   Widget _buildTextField(TextEditingController controller, String label,
//       String hint, TextInputType keyboardType) {
//     return Container(
//       width: MediaQuery.of(Get.context!).size.width,
//       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//       ),
//       child: TextField(
//         style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
//         maxLines: 1,
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           label: Text(
//             label,
//             style: TextStyle(
//               color: AppColor.secondarySoft,
//               fontSize: 14,
//             ),
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           border: InputBorder.none,
//           hintText: hint,
//           hintStyle: TextStyle(
//             fontSize: 14,
//             fontFamily: 'poppins',
//             fontWeight: FontWeight.w500,
//             color: AppColor.secondarySoft,
//           ),
//         ),
//       ),
//     );
//   }
}
