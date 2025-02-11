import 'dart:io';
import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../controllers/detail_kandang_controller.dart';

class DetailKandangView extends GetView<DetailKandangController> {
  const DetailKandangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Detail Kandang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Visibility(
            visible: controller.role != 'ROLE_PETERNAK',
            child: IconButton(
              onPressed: () {
                controller.isEditing.value
                    ? controller.tutupEdit()
                    : controller.tombolEdit();
              },
              icon: Obx(
                () => Icon(
                  controller.isEditing.value ? Icons.close : Icons.edit,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xff132137),
        elevation: 4,
        shadowColor: Colors.black26,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCard(
              child: Column(
                children: [
                  _buildTextField("ID Kandang", controller.idKandangC, false),
                  Obx(() => _buildDropdownPeternak()),
                  _buildTextField("Nama Kandang", controller.namaKandangC,
                      controller.isEditing.value),
                  _buildTextField("jenisKandang", controller.jenisKandangC,
                      controller.isEditing.value),
                  Obx(() => _buildDropdownJenisHewan()),
                  _buildTextField("Luas Kandang", controller.luasC,
                      controller.isEditing.value,
                      suffixText: "m²"),
                  _buildTextField("Kapasitas", controller.kapasitasC,
                      controller.isEditing.value),
                  _buildTextField("Nilai Bangunan", controller.nilaiBangunanC,
                      controller.isEditing.value,
                      prefixText: "Rp. "),
                  _buildTextField(
                      "Alamat", controller.alamatC, controller.isEditing.value),
                  _buildTextField("Latitude", controller.latitudeC,
                      controller.isEditing.value),
                  _buildTextField("Longitude", controller.longitudeC, false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildImageSection(),
            const SizedBox(height: 20),
            _buildLocationSection(context),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildDropdownPeternak() {
    return DropdownSearch<PeternakModel>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
      ),
      enabled: controller.isEditing.value,
      selectedItem: controller.fetchdata.peternakList.firstWhere(
        (peternak) =>
            peternak.idPeternak ==
            controller.fetchdata.selectedPeternakId.value,
        orElse: () =>
            PeternakModel(idPeternak: "", namaPeternak: "Pilih Peternak"),
      ),
      itemAsString: (PeternakModel peternak) => peternak.namaPeternak ?? '',
      items: controller.fetchdata.peternakList,
      onChanged: (PeternakModel? newValue) {
        if (newValue != null) {
          controller.fetchdata.selectedPeternakId.value =
              newValue.idPeternak ?? '';
        }
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Nama Peternak",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDropdownJenisHewan() {
    return DropdownSearch<JenisHewanModel>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
      ),
      enabled: controller.isEditing.value,
      selectedItem: controller.fetchdata.jenisHewanList.firstWhere(
        (jenisHewan) =>
            jenisHewan.idJenisHewan ==
            controller.fetchdata.selectedIdJenisHewan.value,
        orElse: () =>
            JenisHewanModel(idJenisHewan: "", jenis: "Pilih Jenis Hewan"),
      ),
      itemAsString: (JenisHewanModel jenisHewan) => jenisHewan.jenis ?? '',
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isEditable,
      {String? suffixText, String? prefixText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        enabled: isEditable,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefixText,
          suffixText: suffixText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return _buildCard(
      child: Column(
        children: [
          const Text("Gambar Kandang",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Obx(() {
            File? selectedImage = controller.fotoKandang.value;
            return selectedImage != null
                ? Image.file(selectedImage,
                    height: 150, width: double.infinity, fit: BoxFit.cover)
                : Image.network(
                    '${controller.sharedApi.imageUrl}kandang/${controller.argsData["fotoKandang"]}',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover);
          }),
          if (controller.isEditing.value)
            ElevatedButton.icon(
              onPressed: () => controller.pickImage(false),
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Ubah Gambar'),
            ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Lokasi",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Obx(() => Text(controller.strLatLong.value,
              style: const TextStyle(fontSize: 14))),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              controller.loading.value = true;
              Position position = await controller.getGeoLocationPosition();
              controller.strLatLong.value =
                  '${position.latitude}, ${position.longitude}';
              await controller.getAddressFromLongLat(position);
              controller.loading.value = false;
            },
            child: Obx(() => controller.loading.value
                ? const Center(child: CircularProgressIndicator())
                : const Text("Perbarui Lokasi")),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.isEditing.value)
            ElevatedButton(
              onPressed: () {
                controller.editKandang();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff132137),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child:
                  const Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          if (!controller.isEditing.value && controller.role != 'ROLE_PETERNAK')
            ElevatedButton(
              onPressed: () {
                controller.deleteKandang();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Hapus', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}
