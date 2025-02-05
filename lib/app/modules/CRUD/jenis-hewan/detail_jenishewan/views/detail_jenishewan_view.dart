import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_jenishewan_controller.dart';

class DetailJenisHewanView extends GetView<DetailJenisHewanController> {
  const DetailJenisHewanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Detail Jenis Hewan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
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
          Card(
            color: Colors.white,
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Hanya membungkus bagian yang berubah dengan Obx
                  buildTextField("Id", controller.idJenisHewanC, false, 1),
                  Obx(() {
                    return buildTextField("Jenis Hewan", controller.jenisC,
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
                              ? controller.editJenisHewan()
                              : controller.deletePost();
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 4, 29, 50), width: 1),
          ),
          labelText: label,
          labelStyle: TextStyle(color: AppColor.secondarySoft, fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: label,
          hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColor.secondarySoft),
        ),
      ),
    );
  }
}
