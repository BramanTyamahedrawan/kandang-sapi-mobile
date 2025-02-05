import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
// Import CupertinoAlertDialog

import 'package:get/get.dart';

import '../controllers/add_rumpunhewan_controller.dart';

class AddRumpunhewan extends GetView<AddRumpunHewanController> {
  const AddRumpunhewan({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AddRumpunHewanController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Rumpun Hewan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
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
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5, // Memberikan efek bayangan pada Card
            margin: EdgeInsets.only(bottom: 16), // Margin bawah Card
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding di dalam Card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 1,
                    controller: controller.rumpunC,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Rumpun Hewan", // Label untuk TextField
                      // hintText: "Jenis Hewan", // Placeholder atau hint text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 183, 190, 196),
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 183, 190, 196),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 218, 13, 6),
                            width: 1),
                      ),
                      // hintStyle: TextStyle(
                      //   fontSize: 14,
                      //   fontFamily: 'poppins',
                      //   fontWeight: FontWeight.w500,
                      //   color: AppColor.secondarySoft,
                      // ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: AppColor.secondarySoft, // Warna label
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
                    maxLines: 5,
                    controller: controller.deskripsiC,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
                      // Placeholder atau hint text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 183, 190, 196),
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 183, 190, 196),
                            width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 218, 13, 6),
                            width: 1),
                      ),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
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
                            controller.AddRumpunHewan(context);
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
      ),
    );
  }
}
