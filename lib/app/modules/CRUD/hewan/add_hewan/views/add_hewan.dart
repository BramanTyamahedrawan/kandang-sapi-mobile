import 'dart:io';

import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

import '../controllers/add_hewan_controller.dart';

class AddHewanView extends GetView<AddHewanController> {
  const AddHewanView({super.key});

  // const AddHewanView({Key? key}) : super(key: key);
  // String selected;

  @override
  Widget build(BuildContext context) {
    var selectedGender;
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'Tambah Data Hewan',
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
              controller: controller.kodeEartagNasionalC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Kode Eartag Nasional",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Kode Eartag Nasional",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
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
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
          //     maxLines: 1,
          //     controller: controller.noKartuTernakC,
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       label: Text(
          //         "Nomor Kartu Ternak",
          //         style: TextStyle(
          //           color: AppColor.secondarySoft,
          //           fontSize: 14,
          //         ),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.always,
          //       border: InputBorder.none,
          //       hintText: "Nomor Kartu Ternak",
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
                    value:
                        controller.fetchdata.selectedPeternakId.value.isNotEmpty
                            ? controller.fetchdata.selectedPeternakId.value
                            : null,
                    items: controller.fetchdata.peternakList
                        .map((PeternakModel peternak) {
                      return DropdownMenuItem<String>(
                        value: peternak.idPeternak ?? '',
                        child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${peternak.namaPeternak ?? ''}  '
                            ' ${peternak.nikPeternak ?? ''}'),
                      );
                    }).toList(),
                    onChanged: (String? selectedId) {
                      controller.fetchdata.selectedPeternakId.value =
                          selectedId ?? '';
                      if (controller
                          .fetchdata.selectedPeternakId.value.isEmpty) {
                        // Tampilkan pesan kesalahan
                        print('Peternak belum dipilih');
                      }
                    },
                    hint: const Text('Pilih Peternak'),
                    isExpanded: true,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Nama Kandang",
                    style: TextStyle(
                      color: AppColor.secondarySoft,
                      fontSize: 12,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    value: controller.fetchdata.selectedKandangId.value,
                    items: controller.fetchdata.filteredKandangList
                        .map((KandangModel kandang) {
                      return DropdownMenuItem<String>(
                        value: kandang.idKandang ?? '',
                        child: Text('${kandang.idPeternak!.namaPeternak ?? ''} '
                            '${kandang.desa ?? ''}'
                            ' ${kandang.luas ?? ''}'),
                      );
                    }).toList(),
                    onChanged: (String? selectedNik) {
                      controller.fetchdata.selectedKandangId.value =
                          selectedNik ?? '';
                    },
                    hint: const Text('Pilih Kandang'),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  "Spesies",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 12,
                  ),
                ),
              ),
              Obx(
                () => DropdownMenu<String>(
                  inputDecorationTheme: const InputDecorationTheme(
                      filled: false, iconColor: Colors.amber),
                  initialSelection: controller.selectedSpesies.value,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    controller.selectedSpesies.value = value!;
                  },
                  dropdownMenuEntries: controller.spesies
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ),
            ]),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 12,
                  ),
                ),
              ),
              DropdownMenu<String>(
                inputDecorationTheme: const InputDecorationTheme(
                    filled: false, iconColor: Colors.amber),
                initialSelection: controller.genders.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  controller.selectedGender.value = value!;
                },
                dropdownMenuEntries: controller.genders
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ]),
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
              controller:
                  controller.umurC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Umur" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalLahir(context),
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
              controller: controller.identifikasiHewanC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text(
                  "Identifikasi Hewan",
                  style: TextStyle(
                    color: AppColor.secondarySoft,
                    fontSize: 14,
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: "Identifikasi Hewan",
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
                      print(controller.fetchdata.selectedPetugasId.value);
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
                  .tanggalTerdaftarC, //editing controller of this TextField
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Tanggal Terdaftar" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () => controller.tanggalTerdaftar(context),
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
                  'Gambar Hewan', // Label teks untuk container
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
                                if (controller.fotoHewan.value != null)
                                  Column(
                                    children: [
                                      Image.file(
                                        controller.fotoHewan.value ??
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
                              ]),
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
                              await controller.getAddressFromLongLat(position);
                            } catch (e) {
                              // Handle error jika terjadi kesalahan
                              print('Error in onPressed: $e');
                              controller.loading.value =
                                  false; // Pastikan status loading diubah kembali jika terjadi kesalahan
                            }
                          },
                          child: controller.loading.value
                              ? const Center(child: CircularProgressIndicator())
                              : const Text('Tagging Lokasi')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (!controller.isLoading.isTrue) {
                    await controller
                        .updateAlamatInfo(); // Memanggil updateAlamatInfo
                    await controller.addHewan(context); // Memanggil addHewan
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
                    color: Colors.amber,
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

class Gender {
  int? id;
  String? sex;

  Gender({this.id, this.sex});
}
