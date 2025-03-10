import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/CRUD/pengobatan/detail_pengobatan/controllers/detail_pengobatan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPengobatanView extends GetView<DetailPengobatanController> {
  const DetailPengobatanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Detail Pengobatan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (controller.isEditing.value) {
                controller.tutupEdit();
              } else {
                controller.tombolEdit();
              }
            },
            icon: Obx(() {
              return Icon(
                controller.isEditing.value ? Icons.close : Icons.edit,
                color: Colors.white,
              );
            }),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff7B1FA2), Color(0xff512DA8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              child: Column(
                children: [
                  _buildTextField(controller, controller.idKasusC, "ID Kasus",
                      Icons.assignment,
                      isEnabled: false),
                  _buildTextField(controller, controller.namaInfrastrukturC,
                      "Nama Infrastruktur", Icons.business),
                  _buildTextField(controller, controller.dosisC, "Dosis",
                      Icons.local_pharmacy,
                      maxLines: 3),
                  _buildTextField(controller, controller.sindromC, "Sindrom",
                      Icons.health_and_safety),
                  _buildTextField(controller, controller.diagnosaBandingC,
                      "Diagnosa Banding", Icons.medical_services),
                  _buildTextField(controller, controller.lokasiC, "Lokasi",
                      Icons.location_on),
                  _buildDropdownPetugas(),
                  _buildDatePicker(controller.tanggalKasusC, "Tanggal Kasus",
                      context, controller.tanggalKasus),
                  _buildDatePicker(
                      controller.tanggalPengobatanC,
                      "Tanggal Pengobatan",
                      context,
                      controller.tanggalPengobatan),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: controller.isEditing.value
                        ? () => controller.editPengobatan()
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: controller.isEditing.value
                          ? const Color(0xff7B1FA2)
                          : Colors.grey,
                    ),
                    child: const Text(
                      'Simpan Perubahan',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => controller.deletePengobatan(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Hapus Data',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      color: Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  Widget _buildTextField(DetailPengobatanController controller,
      TextEditingController textController, String label, IconData icon,
      {int maxLines = 1, bool isEnabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: textController,
        maxLines: maxLines,
        enabled: controller.isEditing.value && isEnabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: isEnabled ? Colors.grey[200] : Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buildDatePicker(TextEditingController controller, String label,
      BuildContext context, Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: true,
        enabled: this.controller.isEditing.value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.purple),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onTap: () => onTap(context),
      ),
    );
  }

  Widget _buildDropdownPetugas() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nama Petugas",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Obx(() {
            // Pastikan nilai terpilih ada di dalam daftar petugasList
            bool isValid = controller.fetchData.petugasList.any((p) =>
                p.nikPetugas == controller.fetchData.selectedPetugasId.value);

            return DropdownButtonFormField<String>(
              value: isValid
                  ? controller.fetchData.selectedPetugasId.value
                  : null, // Set null jika tidak ada yang cocok
              items:
                  controller.fetchData.petugasList.map((PetugasModel petugas) {
                return DropdownMenuItem<String>(
                  value: petugas.nikPetugas,
                  child: Text(petugas.namaPetugas ?? '',
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins')),
                );
              }).toList(),
              onChanged: controller.isEditing.value
                  ? (String? newValue) {
                      if (newValue != null) {
                        controller.fetchData.selectedPetugasId.value = newValue;
                      }
                    }
                  : null,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            );
          }),
        ],
      ),
    );
  }
}
