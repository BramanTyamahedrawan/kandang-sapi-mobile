import 'dart:io';

import 'package:crud_flutter_api/app/data/RumpunHewan_model.dart';
import 'package:crud_flutter_api/app/data/TujuanPemeliharaan_model.dart';
import 'package:crud_flutter_api/app/data/jenishewan_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
//import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';

import '../controllers/add_hewan_controller.dart';

class AddHewanView extends GetView<AddHewanController> {
  const AddHewanView({super.key});

  // const AddHewanView({Key? key}) : super(key: key);
  // String selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
          Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField("Kode Eartag Hewan",
                          controller.kodeEartagNasionalC, TextInputType.name),
                      SizedBox(height: 20),
                      buildTextField("No Kartu Ternak",
                          controller.noKartuTernakC, TextInputType.name),
                      SizedBox(height: 20),
                      buildTextField("Id Isikhnas Ternak",
                          controller.idIsikhnasTernakC, TextInputType.number),
                      SizedBox(height: 20),
                      buildDropdown<JenisHewanModel>(
                        items: controller.fetchdata.filteredJenisHewanList,
                        itemAsString: (JenisHewanModel jenis) =>
                            "${jenis.jenis}",
                        selectedItem:
                            controller.fetchdata.jenisHewanList.firstWhere(
                          (jenisHewans) =>
                              jenisHewans.idJenisHewan ==
                              controller.fetchdata.selectedIdJenisHewan.value,
                          orElse: () => JenisHewanModel(
                              idJenisHewan: "", jenis: "Pilih Jenis Hewan"),
                        ),
                        onChanged: (JenisHewanModel? newValue) {
                          if (newValue != null) {
                            controller.fetchdata.selectedIdJenisHewan.value =
                                newValue.idJenisHewan ?? '';
                          }
                        },
                        labelText: "Jenis Hewan",
                        defaultItemText: "Pilih Jenis Hewan",
                      ),
                      SizedBox(height: 20),
                      buildDropdown<RumpunHewanModel>(
                        items: controller.fetchdata.filteredRumpunHewanList,
                        itemAsString: (RumpunHewanModel rumpun) =>
                            "${rumpun.rumpun}",
                        selectedItem:
                            controller.fetchdata.rumpunHewanList.firstWhere(
                          (rumpunHewans) =>
                              rumpunHewans.idRumpunHewan ==
                              controller.fetchdata.selectedIdRumpunHewan.value,
                          orElse: () => RumpunHewanModel(
                              idRumpunHewan: "", rumpun: "Pilih Rumpun Hewan"),
                        ),
                        onChanged: (RumpunHewanModel? newValue) {
                          if (newValue != null) {
                            controller.fetchdata.selectedIdRumpunHewan.value =
                                newValue.idRumpunHewan ?? '';
                          }
                        },
                        labelText: "Rumpun Hewan",
                        defaultItemText: "Pilih Rumpun Hewan",
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: buildDropdownGender<String>(
                          items: controller.genders,
                          selectedItem: controller.selectedGender.value,
                          onChanged: (String? value) {
                            if (value != null) {
                              controller.selectedGender.value = value;
                            }
                          },
                          labelText: "Pilih Jenis Kelamin",
                        ),
                      ),
                      SizedBox(height: 20),
                      buildTextField("Tempat Lahir", controller.tempatLahirC,
                          TextInputType.name),
                      SizedBox(height: 20),
                      TextField(
                        style: const TextStyle(
                            fontSize: 14, fontFamily: 'poppins'),
                        maxLines: 1,
                        controller: controller.tanggalLahirC,
                        keyboardType: TextInputType.name,
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () => controller.tanggalLahir(context),
                        decoration: InputDecoration(
                          labelText: "Tanggal Lahir",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 183, 190, 196),
                                width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 183, 190, 196),
                                width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 218, 13, 6),
                                width: 1),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildDropdown<PeternakModel>(
                        items: controller.fetchdata.peternakList,
                        itemAsString: (PeternakModel peternak) =>
                            "${peternak.namaPeternak} ${peternak.nikPeternak?.isNotEmpty == true ? '(${peternak.nikPeternak})' : ''}",
                        selectedItem:
                            controller.fetchdata.peternakList.firstWhere(
                          (peternaks) =>
                              peternaks.idPeternak ==
                              controller.fetchdata.selectedPeternakId.value,
                          orElse: () => PeternakModel(
                              idPeternak: "",
                              namaPeternak: "Pilih Nama Peternak",
                              nikPeternak: "nik"),
                        ),
                        onChanged: (PeternakModel? newValue) {
                          if (newValue != null) {
                            controller.fetchdata.selectedPeternakId.value =
                                newValue.idPeternak ?? '';
                          }
                        },
                        labelText: "Peternak",
                        defaultItemText: "Pilih Nama Peternak (nik)",
                      ),
                      SizedBox(height: 20),
                      buildDropdown<KandangModel>(
                        items: controller.fetchdata.filteredKandangList,
                        itemAsString: (KandangModel kandang) =>
                            "${kandang.namaKandang} ${kandang.idPeternak?.namaPeternak?.isNotEmpty == true ? '(${kandang.idPeternak!.namaPeternak})' : ''}",
                        selectedItem:
                            controller.fetchdata.filteredKandangList.firstWhere(
                          (kandangs) =>
                              kandangs.idKandang ==
                              controller.fetchdata.selectedKandangId.value,
                          orElse: () => KandangModel(
                              idKandang: "",
                              namaKandang: "Pilih Nama Kandang",
                              idPeternak: PeternakModel(namaPeternak: "")),
                        ),
                        onChanged: (KandangModel? newValue) {
                          if (newValue != null) {
                            controller.fetchdata.selectedKandangId.value =
                                newValue.idKandang ?? '';
                          }
                        },
                        labelText: "Kandang",
                        defaultItemText: "Pilih Nama Kandang ",
                      ),
                      SizedBox(height: 20),
                      buildDropdown<PetugasModel>(
                        items: controller.fetchdata.petugasList,
                        itemAsString: (PetugasModel petugas) =>
                            "${petugas.namaPetugas} (${petugas.nikPetugas})",
                        selectedItem:
                            controller.fetchdata.petugasList.firstWhere(
                          (petugas) =>
                              petugas.petugasId ==
                              controller.fetchdata.selectedPetugasId.value,
                          orElse: () => PetugasModel(
                              petugasId: "",
                              namaPetugas: "Pilih Petugas Pendaftar",
                              nikPetugas: "nik"),
                        ),
                        onChanged: (PetugasModel? newValue) {
                          if (newValue != null) {
                            controller.fetchdata.selectedPetugasId.value =
                                newValue.petugasId ?? '';
                          }
                        },
                        labelText: "Petugas Pendaftar",
                        defaultItemText: "Pilih Petugas Pendaftar (nik)",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildDropdown<TujuanPemeliharaanModel>(
                        items:
                            controller.fetchdata.filteredTujuanPemeliharaanList,
                        itemAsString: (TujuanPemeliharaanModel tujuan) =>
                            "${tujuan.tujuanPemeliharaan}",
                        selectedItem: controller
                            .fetchdata.tujuanPemeliharaanList
                            .firstWhere(
                          (tujuanPemeliharaans) =>
                              tujuanPemeliharaans.idTujuanPemeliharaan ==
                              controller
                                  .fetchdata.selectedIdTujuanPemeliharaan.value,
                          orElse: () => TujuanPemeliharaanModel(
                              idTujuanPemeliharaan: "",
                              tujuanPemeliharaan: "Pilih Tujuan Pemeliharaan"),
                        ),
                        onChanged: (TujuanPemeliharaanModel? newValue) {
                          if (newValue != null) {
                            controller.fetchdata.selectedIdTujuanPemeliharaan
                                .value = newValue.idTujuanPemeliharaan ?? '';
                          }
                        },
                        labelText: "Tujuan Pemeliharaan",
                        defaultItemText: "Pilih Tujuan Pemeliharaan",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildTextField("Identifikasi Hewan",
                          controller.identifikasiHewanC, TextInputType.name),
                      SizedBox(
                        height: 20,
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
                                        leading:
                                            const Icon(Icons.photo_library),
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
                      const SizedBox(height: 32),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              if (controller.isLoading.isFalse) {
                                controller.addHewan(context);
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
                      ),
                    ]),
              ))
        ],
      ),
    );
  }

  // Fungsi untuk membuat TextField
  Widget buildTextField(String labelText, TextEditingController controller,
      TextInputType keyboardType) {
    return TextField(
      style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
      maxLines: 1,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 183, 190, 196),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 183, 190, 196),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 218, 13, 6),
            width: 1,
          ),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: Colors.grey, // Ganti dengan AppColor.secondarySoft jika ada
        ),
      ),
    );
  }
}

Widget buildDropdown<T>({
  required String labelText,
  required List<T> items,
  required String Function(T) itemAsString,
  required T? selectedItem,
  required void Function(T?) onChanged,
  String defaultItemText = "Pilih Item",
}) {
  return DropdownSearch<T>(
    popupProps: PopupProps.menu(
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          labelText: "Cari $labelText",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 36, 34, 33), width: 1),
          ),
        ),
      ),
    ),
    selectedItem: selectedItem,
    itemAsString: itemAsString,
    items: items,
    onChanged: onChanged,

    // WARNA DEFAULT
    dropdownBuilder: (context, selectedItem) {
      String text =
          selectedItem != null ? itemAsString(selectedItem) : defaultItemText;
      Color textColor = text == defaultItemText ? Colors.grey : Colors.black;

      return Text(
        text,
        style: TextStyle(color: textColor),
      );
    },
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 183, 190, 196), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 218, 13, 6), width: 1),
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color:
              Color(0xFFB7BEC4), // Ganti dengan AppColor.secondarySoft jika ada
        ),
      ),
    ),
  );
}

Widget buildDropdownGender<T>({
  required List<T> items,
  required T? selectedItem,
  required void Function(T?) onChanged,
  required String labelText,
}) {
  return DropdownButtonFormField<T>(
    value: items.contains(selectedItem) ? selectedItem : null,
    onChanged: onChanged,
    items: items.map<DropdownMenuItem<T>>((T value) {
      return DropdownMenuItem<T>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList(),
    hint: const Text(
      // Placeholder tetap muncul sampai user memilih
      "Pilih Jenis Kelamin",
      style: TextStyle(
          fontSize: 14,
          fontFamily: 'poppins',
          color: Colors.grey,
          fontWeight: FontWeight.w400),
    ),
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 183, 190, 196), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 183, 190, 196), width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: Color.fromARGB(255, 218, 13, 6), width: 1),
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color:
            Color(0xFFB7BEC4), // Ganti dengan AppColor.secondarySoft jika ada
      ),
    ),
  );
}

class Gender {
  int? id;
  String? sex;

  Gender({this.id, this.sex});
}
