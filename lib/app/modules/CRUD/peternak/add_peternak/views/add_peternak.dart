import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/CRUD/peternak/add_peternak/map/map_picker_page.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/add_peternak_controller.dart';

class AddPeternakView extends GetView<AddPeternakController> {
  const AddPeternakView({super.key});
  @override
  Widget build(BuildContext context) {
    final AddPeternakController controller = Get.find<AddPeternakController>();
    controller.fetchProvinces();
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Peternak',
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
        backgroundColor: const Color(0xFF132137),
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
              controller: controller.idISIKHNASC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Id ISHIKNAS",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Id ISHIKNAS",
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
              controller: controller.namaPeternakC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Nama Peternak",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Nama Peternak",
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
              controller: controller.nikPeternakC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "NIK Peternak",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "NIK Peternak",
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
              controller: controller.noTelpC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "No. Telp",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "No. Telp Peternak",
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
              controller: controller.emailPeternakC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text(
                  "Email Peternak",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Email Peternak",
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
            child: Obx(() => DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Jenis Kelamin",
                    labelStyle: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                  ),
                  dropdownColor: const Color.fromARGB(255, 239, 245, 255),
                  icon: Icon(Icons.arrow_drop_down, color: AppColor.secondary),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  value: controller.selectedGender.value.isNotEmpty
                      ? controller.selectedGender.value
                      : null,
                  items: ["Laki - Laki", "Perempuan"].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child:
                          Text(gender, style: TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedGender.value = newValue;
                    }
                  },
                )),
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
              controller: controller.tanggalLahirC,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Lahir",
                suffixIcon: const Icon(Icons.calendar_today),
                border: InputBorder.none,
              ),
              onTap: () => controller.pilihTanggalLahir(context),
            ),
          ),
          // Untuk Provinsi
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 1,
                  color: (controller.dropdownError.value != null &&
                          controller.dropdownError.value.isNotEmpty)
                      ? Colors.red
                      : AppColor.secondaryExtraSoft),
            ),
            child: Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: InputDecoration(
                    labelText: "Pilih Provinsi",
                    labelStyle: TextStyle(
                      color: controller.dropdownError.value.isEmpty
                          ? AppColor.secondarySoft
                          : Colors.red,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    errorText: controller.dropdownError.value.isEmpty
                        ? null
                        : controller.dropdownError.value,
                  ),
                  value: controller.selectedProvince.value,
                  items: controller.provinces.map((province) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: province,
                      child: Text(
                        province['name'] ?? 'Unnamed Province',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                  onChanged: controller.isDropdownEnabled.value
                      ? (value) {
                          if (value != null) {
                            controller.selectedProvince.value = value;
                            controller.selectedCity.value = null;
                            controller.selectedDistrict.value = null;
                            controller.selectedVillage.value = null;
                            controller.cities.clear(); // Kosongkan list kota
                            controller.districts
                                .clear(); // Kosongkan list kecamatan
                            controller.villages.clear(); // Kosongkan list desa
                            controller.fetchCities(value[
                                'id']); // Ambil data kota berdasarkan provinsi

                            print(
                                "Provinsi terpilih: ${controller.selectedProvince.value?['name']}");
                          }
                        }
                      : null,
                )),
          ),
          // Dropdown Kabupaten
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
                if (controller.isLoadingCities.value) {
                  return const SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
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
                    controller.selectedVillage.value = null;
                    controller.districts.clear();
                    controller.villages.clear();
                    controller.fetchDistricts(
                        value['id']); // Ambil kecamatan berdasarkan kabupaten
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
              () {
                if (controller.isLoadingDistricts.value) {
                  return const SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
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
                    controller.selectedDistrict.value = value!;
                    controller.selectedVillage.value = null;
                    controller.villages.clear();
                    controller.fetchVillages(value['id']);
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
              () {
                if (controller.isLoadingVillages.value) {
                  return const SizedBox(
                    height: 50,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }

                return DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: InputDecoration(
                    labelText: "Pilih Desa",
                    labelStyle:
                        TextStyle(color: AppColor.secondarySoft, fontSize: 14),
                    border: InputBorder.none,
                  ),
                  value: controller.selectedVillage.value,
                  items: controller.villages.map((village) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: village,
                      child: Text(village['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedVillage.value = value;
                    controller.updateAlamat();
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
                    TextEditingController(text: controller.alamat.value),
                decoration: InputDecoration(
                  label: Text(
                    "Alamat",
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
            child: TextField(
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              maxLines: 1,
              controller: controller.dusunC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Dusun",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              LatLng? selectedLocation =
                  await Get.to<LatLng>(() => MapPickerPage());
              if (selectedLocation != null) {
                controller.lokasiC.text =
                    "${selectedLocation.latitude},${selectedLocation.longitude}";
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 16, bottom: 16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(width: 1, color: AppColor.secondaryExtraSoft),
              ),
              child: Text(
                controller.lokasiC.text.isEmpty
                    ? "Pilih Lokasi"
                    : controller.lokasiC.text,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  color: controller.lokasiC.text.isEmpty
                      ? AppColor.secondarySoft
                      : Colors.black,
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
                    "Petugas Pendaftar",
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
                    onChanged: (String? selectedNama) {
                      controller.fetchdata.selectedPetugasId.value =
                          selectedNama ?? '';
                    },
                    hint: const Text('Pilih Petugas'),
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
              controller: controller
                  .tanggalPendaftaranC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Pendaftaran" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalPendaftaran(context),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    if (controller.selectedProvince.value == null) {
                      Get.snackbar(
                          "Error", "Silahkan pilih provinsi terlebih dahulu!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                      return;
                    }
                    controller.addUser(context);
                    controller.addPeternak(context);
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
