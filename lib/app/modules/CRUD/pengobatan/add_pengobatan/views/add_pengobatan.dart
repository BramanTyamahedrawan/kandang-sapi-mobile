import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_pengobatan_controller.dart';

class AddPengobatanView extends GetView<AddPengobatanController> {
  const AddPengobatanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Tambah Data Pengobatan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                  _buildTextField(
                      controller.idKasusC, "Id Kasus", Icons.assignment),
                  _buildDatePicker(controller.tanggalKasusC, "Tanggal Kasus",
                      context, controller.tanggalKasus),
                  _buildDatePicker(
                      controller.tanggalPengobatanC,
                      "Tanggal Pengobatan",
                      context,
                      controller.tanggalPengobatan),
                  _buildTextField(controller.namaInfrastrukturC,
                      "Nama Infrastruktur", Icons.business),
                  _buildTextField(
                      controller.dosisC, "Dosis", Icons.local_pharmacy,
                      maxLines: 3),
                  _buildTextField(
                      controller.sindromC, "Sindrom", Icons.health_and_safety),
                  _buildTextField(controller.dignosaBandingC,
                      "Diagnosa Banding", Icons.medical_services),
                  _buildTextField(
                      controller.lokasiC, "Lokasi", Icons.location_on),
                  _buildDropdownPetugas(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.isFalse
                      ? () => controller.addPengobatan(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    backgroundColor: const Color(0xff7B1FA2),
                  ),
                  child: Text(
                    controller.isLoading.isFalse ? 'Tambah Data' : 'Loading...',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
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

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[200],
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
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.fetchdata.selectedPetugasId.value.isEmpty
                  ? null // Jika tidak ada yang dipilih, tetap null
                  : controller.fetchdata.selectedPetugasId.value,
              items:
                  controller.fetchdata.petugasList.map((PetugasModel petugas) {
                return DropdownMenuItem<String>(
                  value: petugas.petugasId,
                  child: Text(petugas.namaPetugas ?? '',
                      style:
                          const TextStyle(fontSize: 14, fontFamily: 'poppins')),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.fetchdata.selectedPetugasId.value = newValue;
                }
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
