import 'dart:io';
import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:url_launcher/url_launcher.dart';

import '../controllers/add_kandang_controller.dart';

class AddKandangView extends GetView<AddKandangController> {
  const AddKandangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tambah Data Kandang',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
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
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildFormCard(context),
          // const SizedBox(height: 20),
          // _buildImageSection(),
          // const SizedBox(height: 20),
          // _buildLocationSection(),
          // const SizedBox(height: 20),
          // _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: 200, // Lebar tombol, bisa disesuaikan
        child: ElevatedButton.icon(
          onPressed: controller.isLoading.value
              ? null
              : () async {
                  await controller.addKandang(Get.context!);
                },
          icon: controller.isLoading.value
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.add_circle_outline, color: Colors.white),
          label: Obx(() => Text(
                controller.isLoading.value ? "Memproses..." : "Tambah Kandang",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff132137), // Warna utama
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdownPeternak(),
            const SizedBox(height: 16),
            _buildTextField(
                controller.namaKandangC, "Nama Kandang", Icons.home),
            _buildDropdownJenisHewan(),
            const SizedBox(height: 16),
            _buildTextField(
                controller.jenisKandangC, "Jenis Kandang", Icons.home),
            _buildTextField(controller.luasC, "Luas Kandang", Icons.straighten,
                suffixText: "m²"),
            _buildTextField(controller.kapasitasC, "Kapasitas", Icons.people),
            _buildTextField(
                controller.nilaiBangunanC, "Nilai Bangunan", Icons.attach_money,
                prefixText: "Rp. "),
            _buildPickLocationButton(context),
            const SizedBox(height: 16),
            _buildLatitudeField(controller),
            _buildLongitudeField(controller),
            _buildAlamatField(controller),
            _buildProvinsiField(controller),
            _buildKabupatenField(controller),
            _buildKecamatanField(controller),
            _buildDesaField(controller),
            _buildImageSection(),
            const SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownPeternak() {
    return Obx(
      () => DropdownSearch<PeternakModel>(
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
        selectedItem: controller.fetchdata.peternakList.firstWhere(
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
      ),
    );
  }

  Widget _buildDropdownJenisHewan() {
    return Obx(
      () => DropdownSearch<JenisHewanModel>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: "Cari Jenis HEwan",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        selectedItem: controller.fetchdata.jenisHewanList.firstWhere(
          (jenisHewan) =>
              jenisHewan.idJenisHewan ==
              controller.fetchdata.selectedIdJenisHewan.value,
          orElse: () =>
              JenisHewanModel(idJenisHewan: "", jenis: "Pilih Jenis Hewan"),
        ),
        itemAsString: (JenisHewanModel jenisHewan) => "${jenisHewan.jenis}",
        items: controller.fetchdata.jenisHewanList,
        onChanged: (JenisHewanModel? newValue) {
          if (newValue != null) {
            controller.fetchdata.selectedIdJenisHewan.value =
                newValue.idJenisHewan ?? '';
          }
        },
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Jenis Hewan",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 183, 190, 196), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 218, 13, 6), width: 1),
            ),
            labelStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                color: AppColor.secondarySoft),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController textController, String label, IconData icon,
      {String? suffixText, String? prefixText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: textController,
        style: const TextStyle(
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffixText,
          prefixText: prefixText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 183, 190, 196), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: Color.fromARGB(255, 218, 13, 6), width: 1),
          ),
          labelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              color: AppColor.secondarySoft),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Gambar Kandang",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Obx(() {
              File? selectedImage = controller.fotoKandang.value;
              return selectedImage != null
                  ? Image.file(selectedImage,
                      height: 150, width: double.infinity, fit: BoxFit.cover)
                  : Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image,
                          size: 50, color: Colors.grey));
            }),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => controller.pickImage(false),
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Pilih Gambar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickLocationButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => controller.openMapDialog(context),
      icon: const Icon(Icons.map, color: Colors.white),
      label: const Text("Pilih Lokasi di Peta",
          style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Input untuk Latitude (bisa diedit manual)
  Widget _buildAlamatField(AddKandangController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller.alamatC,
        onChanged: (value) {
          controller.manualAlamatEdited.value =
              true; // Tandai bahwa alamat diedit manual
        },
        keyboardType: TextInputType.text,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          labelText: "Alamat",
          labelStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          prefixIcon: const Icon(Icons.location_on, color: Colors.green),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade700, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildLatitudeField(AddKandangController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller.latitudeC,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          controller.latitude.value = value; // Sinkronisasi manual
        },
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          labelText: "Latitude",
          labelStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          prefixIcon: const Icon(Icons.gps_fixed, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildLongitudeField(AddKandangController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller.longitudeC,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          controller.longitude.value = value; // Sinkronisasi manual
        },
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          labelText: "Longitude",
          labelStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
          prefixIcon: const Icon(Icons.gps_fixed, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 1.5),
          ),
        ),
      ),
    );
  }
}

Widget _buildProvinsiField(AddKandangController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: GetBuilder<AddKandangController>(builder: (controller) {
      return TextField(
        controller: controller.provinsiC,
        decoration: InputDecoration(
          labelText: "Provinsi",
          prefixIcon: const Icon(Icons.map, color: Colors.purple),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }),
  );
}

Widget _buildKabupatenField(AddKandangController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: GetBuilder<AddKandangController>(builder: (controller) {
      return TextField(
        controller: controller.kabupatenC,
        decoration: InputDecoration(
          labelText: "Kabupaten/Kota",
          prefixIcon: const Icon(Icons.location_city, color: Colors.orange),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }),
  );
}

Widget _buildKecamatanField(AddKandangController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: GetBuilder<AddKandangController>(builder: (controller) {
      return TextField(
        controller: controller.kecamatanC,
        decoration: InputDecoration(
          labelText: "Kecamatan",
          prefixIcon: const Icon(Icons.business, color: Colors.blue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }),
  );
}

Widget _buildDesaField(AddKandangController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: GetBuilder<AddKandangController>(builder: (controller) {
      return TextField(
        controller: controller.desaC,
        decoration: InputDecoration(
          labelText: "Desa",
          prefixIcon: const Icon(Icons.villa, color: Colors.green),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }),
  );
}
