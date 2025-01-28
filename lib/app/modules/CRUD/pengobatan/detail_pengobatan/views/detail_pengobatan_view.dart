import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/modules/CRUD/pengobatan/detail_pengobatan/controllers/detail_pengobatan_controller.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailPengobatanView extends GetView<DetailPengobatanController> {
  const DetailPengobatanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        title: const Text(
          'Detail Pengobatan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali
          onPressed: () {
            Navigator.of(context).pop(); // Aksi saat tombol diklik
          },
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
              );
            }),
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
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.grey[200]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: false,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  autofocus: true,
                  controller: controller.idKasusC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      "ID Kasus",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "ID Kasus",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  autofocus: true,
                  controller: controller.namaInfrastrukturC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      "Nama Infrastuktur",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Nama Infrastuktur",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  autofocus: true,
                  controller: controller.dosisC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      "Dosis",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Dosis",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  autofocus: true,
                  controller: controller.sindromC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      "Sindrom",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Sindrom",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  autofocus: true,
                  controller: controller.diagnosaBandingC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      "Diagnosa banding",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Diagnosa banding",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  autofocus: true,
                  controller: controller.lokasiC,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text(
                      "Lokasi",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Lokasi",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          Obx(
            () => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Nama Petugas ",
                                style: TextStyle(
                                  color: Colors.black, // Warna teks utama
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "(klik edit untuk mengganti nama petugas)",
                                style: TextStyle(
                                  color: Colors.red, // Warna teks miring
                                  fontStyle:
                                      FontStyle.italic, // Membuat teks miring
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.fetchData.selectedPetugasId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchData.selectedPetugasId.value,
                                items: controller.fetchData.petugasList
                                    .map((PetugasModel petugass) {
                                  print(controller
                                      .fetchData.selectedPetugasId.value);
                                  return DropdownMenuItem<String>(
                                    value: petugass.nikPetugas ?? '',
                                    child: Text(petugass.namaPetugas ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  controller.fetchData.selectedPetugasId.value =
                                      selectedId ?? '';
                                },
                                hint: const Text('Pilih Petugas'),
                              )
                            : TextField(
                                controller: controller.namaPetugasC,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'poppins',
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  // labelText: 'ID Peternak',
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                              ),
                      ),
                    ])),
          ),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  controller: controller.tanggalKasusC,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.calendar_today),
                    labelText: "Tanggal Kasus",
                  ),
                  readOnly: true,
                  onTap: () => controller.tanggalKasus(context),
                ),
              )),
          Obx(() => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: controller.isEditing.value
                      ? Colors.white
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextField(
                  enabled: controller.isEditing.value,
                  style: const TextStyle(
                      fontSize: 14, fontFamily: 'poppins', color: Colors.black),
                  maxLines: 1,
                  controller: controller.tanggalPengobatanC,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.calendar_today),
                    labelText: "Tanggal Pengobatan",
                  ),
                  readOnly: true,
                  onTap: () => controller.tanggalPengobatan(context),
                ),
              )),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.isEditing.value)
                  ElevatedButton(
                    onPressed: () {
                      controller.editPengobatan();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 55),
                      backgroundColor: const Color(0xff132137),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Edit post',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        color: Colors.white,
                      ),
                    ),
                    // ... Other button properties
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      controller.deletePengobatan();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 55),
                      backgroundColor: const Color(0xff132137),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Delete post',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        color: AppColor.primaryExtraSoft,
                      ),
                    ),
                  ),
              ],
            );
          })
        ],
      ),
    );
  }
}
