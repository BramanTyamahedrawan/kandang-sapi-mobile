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
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Pengobatan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali
          onPressed: () {
            Navigator.of(context).pop(); //F Aksi saat tombol diklik
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
              controller: controller.idKasusC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Id Kasus",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Id Kasus",
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
              controller: controller.namaInfrastrukturC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Nama infrastuktur",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Nama infrastuktur",
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
              controller: controller.dosisC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Dosis",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Dosis",
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
              controller: controller.sindromC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Sindrom",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Sindrom",
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
              controller: controller.dignosaBandingC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Diagnosa Banding",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Diagnosa Banding",
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
              controller: controller.lokasiC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Lokasi",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Lokasi",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Nama Petugas",
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
                    onChanged: (String? selectedNik) {
                      controller.fetchdata.selectedPetugasId.value =
                          selectedNik ?? '';
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
                  .tanggalKasusC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Kasus" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalKasus(context),
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
                  .tanggalPengobatanC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Pengobatan" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalPengobatan(context),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.addPengobatan(context);
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
