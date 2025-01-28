import 'dart:io';

import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';

import '../controllers/detail_kandang_controller.dart';

class DetailKandangView extends GetView<DetailKandangController> {
  const DetailKandangView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Detail Data Kandang',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), // Ikon panah kembali
          onPressed: () {
            Navigator.of(context).pop(); // Aksi saat tombol diklik
          },
        ),
        actions: [
          Visibility(
            visible: controller.role != 'ROLE_PETERNAK',
            child: IconButton(
              onPressed: () {
                if (controller.isEditing.value) {
                  controller.tutupEdit();
                } else {
                  controller.tombolEdit();
                }
              },
              icon: Obx(
                () {
                  return Icon(
                    controller.isEditing.value ? Icons.close : Icons.edit,
                    color: Colors.white,
                  );
                },
              ),
            ),
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
                  controller: controller.idKandangC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(
                      "ID Kandang",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "ID Kandang",
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
                        child: Text(
                          "Id Peternak",
                          style: TextStyle(
                            color: AppColor.secondarySoft,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(controller.fetchdata.selectedPeternakId.value);
                        },
                        child: controller.isEditing.value
                            ? DropdownButton<String>(
                                value: controller
                                    .fetchdata.selectedPeternakId.value,
                                items: controller.fetchdata.peternakList
                                    .map((PeternakModel peternak) {
                                  return DropdownMenuItem<String>(
                                    value: peternak.idPeternak ?? '',
                                    child: Text(peternak.namaPeternak ?? ''),
                                  );
                                }).toList(),
                                onChanged: (String? selectedId) {
                                  // Update selectedPeternakId
                                  controller.fetchdata.selectedPeternakId
                                      .value = selectedId ?? '';

                                  // Update nikPeternakC and namaPeternakC based on selectedPeternakId
                                  PeternakModel selectedPeternak = controller
                                      .fetchdata.peternakList
                                      .firstWhere(
                                    (peternak) =>
                                        peternak.idPeternak == selectedId,
                                    orElse: () =>
                                        PeternakModel(), // Default value if not found
                                  );

                                  controller.idPeternakC.text =
                                      selectedPeternak.idPeternak ?? '';
                                },
                                hint: const Text('Pilih Peternak'),
                              )
                            : TextField(
                                controller: controller.namaPeternakC,
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
                      ? Colors.grey[200]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: false,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  controller: controller.idPeternakC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                      "ID Peternak",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "ID Peternak",
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
                      ? Colors.grey[200]
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(width: 1, color: AppColor.secondaryExtraSoft),
                ),
                child: TextFormField(
                  enabled: false,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'poppins',
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  controller: controller.jenisHewanC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                      "Jenis Hewan",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Jenis Hewan",
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
                  controller: controller.luasC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                      "Luas Kandang",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Luas Kandang",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                    suffixText: 'm²',
                    suffixStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                  controller: controller.kapasitasC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(
                      "Kapasitas",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Kapasitas",
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
                  controller: controller.nilaiBangunanC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      label: Text(
                        "Nilai Bangunan",
                        style: TextStyle(
                          color: AppColor.secondarySoft,
                          fontSize: 15,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: "Nilai Bangunan",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondarySoft,
                      ),
                      prefixText: "Rp. ",
                      prefixStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
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
                  controller: controller.alamatC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text(
                      "Alamat",
                      style: TextStyle(
                        color: AppColor.secondarySoft,
                        fontSize: 15,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: InputBorder.none,
                    hintText: "Alamat",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondarySoft,
                    ),
                  ),
                ),
              )),
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.desaC,
          //         keyboardType: TextInputType.emailAddress,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Desa",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Desa",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.kecamatanC,
          //         keyboardType: TextInputType.emailAddress,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Kecamatan",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Kecamatan",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.kabupatenC,
          //         keyboardType: TextInputType.emailAddress,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Kabupaten",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Kabupaten",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
          // Obx(() => Container(
          //       width: MediaQuery.of(context).size.width,
          //       padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //       margin: const EdgeInsets.only(bottom: 16),
          //       decoration: BoxDecoration(
          //         color: controller.isEditing.value
          //             ? Colors.white
          //             : Colors.grey[200],
          //         borderRadius: BorderRadius.circular(8),
          //         border:
          //             Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //       ),
          //       child: TextFormField(
          //         enabled: controller.isEditing.value,
          //         style: const TextStyle(
          //             fontSize: 18, fontFamily: 'poppins', color: Colors.black),
          //         maxLines: 1,
          //         controller: controller.provinsiC,
          //         keyboardType: TextInputType.emailAddress,
          //         decoration: InputDecoration(
          //           label: Text(
          //             "Provinsi",
          //             style: TextStyle(
          //               color: AppColor.secondarySoft,
          //               fontSize: 15,
          //             ),
          //           ),
          //           floatingLabelBehavior: FloatingLabelBehavior.always,
          //           border: InputBorder.none,
          //           hintText: "Provinsi",
          //           hintStyle: TextStyle(
          //             fontSize: 15,
          //             fontFamily: 'poppins',
          //             fontWeight: FontWeight.w500,
          //             color: AppColor.secondarySoft,
          //           ),
          //         ),
          //       ),
          //     )),
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
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.isEditing.value) {
                          controller
                              .pickImage(true); // Fungsi untuk memilih gambar
                        }
                      },
                      child: Obx(() {
                        // Gunakan nilai fotoKandang dari controller
                        File? selectedImage = controller.fotoKandang.value;
                        if (selectedImage != null) {
                          // Jika ada gambar yang dipilih, tampilkan menggunakan Image.file
                          return Image.file(
                            selectedImage,
                            fit: BoxFit.fill,
                          );
                        } else {
                          // Jika tidak ada gambar yang dipilih, tampilkan menggunakan Image.network
                          return Image.network(
                            '${controller.sharedApi.imageUrl + 'kandang/'}${controller.argsData["fotoKandang"]}',
                            fit: BoxFit.fill,
                          );
                        }
                      }),
                    ),
                    if (controller.isEditing.value)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            controller.pickImage(
                                false); // Fungsi untuk memilih gambar
                          },
                        ),
                      ),
                  ],
                ),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => Visibility(
                visible: controller.isEditing.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Titik Kordinat",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Text(controller.strLatLong.value),
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: controller.strLatLong.value));
                        final snackBar = SnackBar(
                          content: const Text("LatLong berhasil disalin!"),
                          backgroundColor: Colors.green,
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: "tutup",
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "alamat",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: GestureDetector(
                        child: Text(controller.strAlamat.value),
                        onLongPress: () {
                          Clipboard.setData(
                              ClipboardData(text: controller.strAlamat.value));
                          final snackBar = SnackBar(
                            content: const Text("Alamat Berhasil Disalin!"),
                            backgroundColor: (Colors.green),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: "Tutup",
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.loading.value
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                // Mengubah status loading menjadi true untuk menunjukkan bahwa proses sedang berlangsung
                                controller.loading.value = true;

                                // Mendapatkan posisi geolokasi
                                Position position =
                                    await controller.getGeoLocationPosition();

                                // Mengubah status loading menjadi false setelah mendapatkan posisi
                                controller.loading.value = false;

                                // Memperbarui nilai strLatLong dengan koordinat yang didapatkan
                                controller.strLatLong.value =
                                    '${position.latitude}, ${position.longitude}';

                                // Mendapatkan alamat dari koordinat
                                if (controller.isEditing.value) {
                                  await controller.updateAlamatInfo();
                                }

                                // Mendapatkan alamat dari koordinat
                                await controller
                                    .getAddressFromLongLat(position);
                              } catch (e) {
                                // Handle error jika terjadi kesalahan
                                print('Error in onPressed: $e');
                                controller.loading.value =
                                    false; // Pastikan status loading diubah kembali jika terjadi kesalahan
                              }
                            },
                            child: controller.loading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const Text('Tagging Lokasi')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
//AND DELETE
          Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.isEditing.value)
                    ElevatedButton(
                      onPressed: () {
                        controller.editKandang();
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
                    ),
                  if (!controller.isEditing.value &&
                      controller.role != 'ROLE_PETERNAK')
                    ElevatedButton(
                      onPressed: () {
                        controller.deleteKandang();
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
                          color: AppColor.warning,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}





//               Obx(() => Container(
//   width: MediaQuery.of(context).size.width,
//   padding: EdgeInsets.only(left: 14, right: 14, top: 4),
//   margin: EdgeInsets.only(bottom: 16),
//   decoration: BoxDecoration(
//     color: controller.isEditing.value ? Colors.white : Colors.grey[200],
//     borderRadius: BorderRadius.circular(8),
//     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
//   ),
//   child: Stack(
//     children: [
//       GestureDetector(
//         onTap: () {
//           if (controller.isEditing.value) {
//             controller.pickImage(); // Fungsi untuk memilih gambar
//           }
//         },
//         child: Image.network(
//           '${controller.sharedApi.imageUrl}${controller.argsData["fotoKandang"]}',
//           fit: BoxFit.fill,
//         ),
//       ),
//       if (controller.isEditing.value)
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               controller.pickImage(); // Fungsi untuk memilih gambar
//             },
//           ),
//         ),
//     ],
//   ),
// )),

// Fungsi untuk memilih gambar dari galeri atau kamera
// Future<void> _pickImage() async {
//   final pickedFile = await ImagePicker().getImage(
//     source: ImageSource.gallery, // Ganti dengan ImageSource.camera jika ingin dari kamera
//   );

//   if (pickedFile != null) {
//     // Lakukan sesuatu dengan gambar yang dipilih
//     // Misalnya, simpan path gambar di state controller
//     controller.fotoKandang.value = File(pickedFile.path);
//   }
// },
          // Obx(() => Container(
          //     width: MediaQuery.of(context).size.width,
          //     padding: EdgeInsets.only(left: 14, right: 14, top: 4),
          //     margin: EdgeInsets.only(bottom: 16),
          //     decoration: BoxDecoration(
          //       color: controller.isEditing.value
          //           ? Colors.white
          //           : Colors.grey[200],
          //       borderRadius: BorderRadius.circular(8),
          //       border:
          //           Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //     ),
          //     child: Image.network(
          //       '${controller.sharedApi.imageUrl}${controller.argsData["fotoKandang"]}',
          //       fit: BoxFit.fill,
          //     ))),