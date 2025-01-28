//import 'package:crud_flutter_api/app/data/Provinsi.dart';
import 'dart:io';

import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:crud_flutter_api/app/modules/CRUD/kandang/add_kandang/controllers/add_kandang_controller.dart';

class AddKandangView extends GetView<AddKandangController> {
  const AddKandangView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Kandang',
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
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: const EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.idKandangC,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Id Kandang",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Id Kandang",
          //       hintStyle: TextStyle(
          //         fontSize: 14,
          //         fontFamily: 'poppins',
          //         fontWeight: FontWeight.w500,
          //         color: AppColor.secondarySoft,
          //       ),
          //     ),
          //   ),
          // ),
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
                    "Nama Peternak",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fetchdata.selectedPeternakId.value,
                    items: controller.fetchdata.peternakList
                        .map((PeternakModel peternak) {
                      return DropdownMenuItem<String>(
                        value: peternak.idPeternak ?? '',
                        child: Text(peternak.namaPeternak ?? ''),
                      );
                    }).toList(),
                    onChanged: (String? selectedId) {
                      controller.fetchdata.selectedPeternakId.value =
                          selectedId ?? '';
                    },
                    hint: const Text('Pilih Peternak'),
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
              controller: controller.luasC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: Text(
                    "Luas",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 14,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  hintText: "Luas",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                    color: AppColor.secondarySoft,
                  ),
                  suffixText: 'm²',
                  suffixStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
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
              controller: controller.kapasitasC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "Kapasitas",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Kapasitas",
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
              controller: controller.nilaiBangunanC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  label: Text(
                    "Nilai Bangunan",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 14,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: InputBorder.none,
                  hintText: "Nilai Bangunan",
                  hintStyle: TextStyle(
                    fontSize: 14,
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
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
          //   margin: const EdgeInsets.only(bottom: 16),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(8),
          //     border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 0),
          //         child: Text(
          //           "Jenis Hewan",
          //           style: TextStyle(
          //             color: AppColor.secondarySoft,
          //             fontSize: 12,
          //           ),
          //         ),
          //       ),
          //       Obx(() {
          //         List<String> spesies = [
          //           "Banteng",
          //           "Domba",
          //           "Kambing",
          //           "Sapi",
          //           "Sapi Brahman",
          //           "Sapi Brangus",
          //           "Sapi Limosin",
          //           "Sapi fh",
          //           "Sapi Perah",
          //           "Sapi PO",
          //           "Sapi Simental"
          //         ];
          //         return DropdownButton<String>(
          //           value: controller.selectSpecies.value.isEmpty
          //               ? null
          //               : controller.selectSpecies.value,
          //           items:
          //               spesies.map<DropdownMenuItem<String>>((String value) {
          //             // Panggil map di sini
          //             return DropdownMenuItem<String>(
          //               value: value,
          //               child: Text(value),
          //             );
          //           }).toList(),
          //           onChanged: (String? selectedId) {
          //             // controller.fetchdata.selectedPeternakId.value =
          //             //     selectedId ?? '';
          //             controller.selectSpecies.value = selectedId!;
          //           },
          //           hint: const Text('Pilih species'),
          //         );
          //       }),
          //     ],
          //   ),
          // ),
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
              controller: controller.jenisHewanC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Jenis Hewan",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Jenis Hewan",
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
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Gambar Kandang', // Label teks untuk container
                  style: TextStyle(
                    fontFamily: 'poppins',
                    color: AppColor.secondarySoft,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (controller.fotoKandang.value != null)
                                Column(
                                  children: [
                                    Image.file(
                                      controller.fotoKandang.value ??
                                          File('null'),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 8),
                                    IconButton(
                                      onPressed: () {
                                        controller.removeImage();
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        // Tampilkan dialog atau pilihan untuk memilih sumber gambar
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Pilih Sumber Gambar"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text("Kamera"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        controller.pickImage(true);
                                      },
                                    ),
                                    const SizedBox(height: 8),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text("Galeri"),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        controller.pickImage(false);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text('Pilih Gambar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Titik Kordinat",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  Column(
                    children: [
                      // Tombol Tagging Lokasi
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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

                            // Memperbarui nilai strLatLong dengan koordinat yang didapatkan
                            controller.strLatLong.value =
                                '${position.latitude}, ${position.longitude}';

                            // Mendapatkan alamat dari koordinat
                            await controller.getAddressFromLongLat(position);
                          } catch (e) {
                            // Handle error jika terjadi kesalahan
                            print('Error in onPressed: $e');
                          } finally {
                            // Mengubah status loading menjadi false setelah mendapatkan posisi atau jika terjadi kesalahan
                            controller.loading.value = false;
                          }
                        },
                        child: controller.loading.value
                            ? const Center(child: CircularProgressIndicator())
                            : const Text('Tagging Lokasi'),
                      ),

                      const SizedBox(height: 32),

                      // Tombol Tambah Post
                      ElevatedButton(
                        onPressed: () async {
                          if (!controller.loading.value) {
                            try {
                              // Menampilkan animasi loading
                              controller.loading.value = true;

                              // Memanggil updateAlamatInfo
                              await controller.updateAlamatInfo();

                              // Memanggil addHewan
                              await controller.addKandang(context);
                            } finally {
                              // Menyembunyikan animasi loading setelah selesai
                              controller.loading.value = true;
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff132137),
                          padding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: MediaQuery.of(context).size.width * 0.3,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          (controller.loading.value)
                              ? 'Loading...'
                              : 'Tambah post',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
