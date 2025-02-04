import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  final MainMenuController mainMenuController = Get.put(MainMenuController());
  MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Main Menu',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff132137), // Warna latar belakang AppBar
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 20), // Add padding to the bottom
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menerapkan kondisi berdasarkan peran pengguna
                if (controller.isAdmin.value)
                  buildAdminMenu()
                else if (controller.isPetugas.value)
                  buildLecturerMenu()
                else if (controller.isUser.value)
                  buildStudentMenu(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAdminMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        TyperAnimatedTextKit(
          text: const ["Semua data Peternakan Lumajang"],
          speed: const Duration(milliseconds: 100),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff132137),
          ),
        ),
        const SizedBox(height: 30),
        buildButtonRow([
          buildButton(Routes.PETUGAS, 'Petugas',
              FaIcon(FontAwesomeIcons.addressCard, color: Colors.white)),
          buildButton(Routes.PEMILIK, 'Peternak',
              FaIcon(FontAwesomeIcons.users, color: Colors.white)),
              buildButton(Routes.KANDANG, 'Kandang',
              FaIcon(FontAwesomeIcons.house, color: Colors.white)),
         
        ]),
        const SizedBox(height: 30),
        buildButtonRow([
           buildButton(Routes.JENISHEWAN, 'Jenis Hewan',
              FaIcon(FontAwesomeIcons.qrcode, color: Colors.white)),
          buildButton(Routes.RUMPUNHEWAN, 'Rumpun Hewan',
              FaIcon(FontAwesomeIcons.networkWired, color: Colors.white)),
          buildButton(Routes.TUJUANPEMELIHARAAN, 'Tujuan Ternak',
              FaIcon(FontAwesomeIcons.wrench, color: Colors.white))
        ]),
        const SizedBox(height: 30),
        buildButtonRow([
          buildButton(Routes.HEWAN, 'Daftar Hewan',
              FaIcon(FontAwesomeIcons.cow, color: Colors.white)),
          buildButton(Routes.JENISVAKSIN, 'Jenis Vaksin',
              FaIcon(FontAwesomeIcons.cow, color: Colors.white)),
          buildButton(Routes.NAMAVAKSIN, 'Nama Vaksin',
              FaIcon(FontAwesomeIcons.cow, color: Colors.white)),
        ]),
        const SizedBox(height: 30),
        buildButtonRow([
          buildButton(Routes.VAKSIN, 'Vaksin',
              FaIcon(FontAwesomeIcons.syringe, color: Colors.white)),
          buildButton(Routes.INSEMINASI, 'Inseminasi',
              FaIcon(FontAwesomeIcons.dna, color: Colors.white)),
          buildButton(Routes.KELAHIRAN, 'Kelahiran',
              FaIcon(FontAwesomeIcons.baby, color: Colors.white)),
        ]),
        const SizedBox(height: 30),
        buildButtonRow([
          buildButton(Routes.PENGOBATAN, 'Pengobatan',
              FaIcon(FontAwesomeIcons.stethoscope, color: Colors.white)),
          buildButton(Routes.PKB, 'PKB',
              FaIcon(FontAwesomeIcons.building, color: Colors.white)),
        ]),
      ],
    );
  }

  Widget buildLecturerMenu() {
    return Column(
      children: [
        const SizedBox(height: 30),
        TyperAnimatedTextKit(
          text: const ["Semua data Peternakan Lumajang"],
          speed: const Duration(milliseconds: 100),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff132137),
          ),
        ),
        const SizedBox(height: 30),
        buildButtonRow([
          buildButton(Routes.HEWAN, 'Hewan',
              FaIcon(FontAwesomeIcons.cat, color: Colors.white)),
          buildButton(Routes.VAKSIN, 'Vaksin',
              FaIcon(FontAwesomeIcons.syringe, color: Colors.white)),
        ]),
        buildButtonRow([
          buildButton(Routes.PENGOBATAN, 'Pengobatan',
              FaIcon(FontAwesomeIcons.stethoscope, color: Colors.white)),
          buildButton(Routes.INSEMINASI, 'Inseminasi',
              FaIcon(FontAwesomeIcons.dna, color: Colors.white)),
        ]),
        buildButtonRow([
          buildButton(Routes.KELAHIRAN, 'Kelahiran',
              FaIcon(FontAwesomeIcons.baby, color: Colors.white)),
          buildButton(Routes.PKB, 'PKB',
              FaIcon(FontAwesomeIcons.building, color: Colors.white)),
        ]),
        buildButtonRow([
          buildButton(Routes.KANDANG, 'Kandang',
              FaIcon(FontAwesomeIcons.home, color: Colors.white)),
        ]),
      ],
    );
  }

  Widget buildStudentMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        TyperAnimatedTextKit(
          text: const ["Semua Data Ternak Saya"],
          speed: const Duration(milliseconds: 100),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff132137),
          ),
        ),
        const SizedBox(height: 20),
        buildButtonRow([
          buildButton(Routes.HEWAN, 'Ternak Saya',
              FaIcon(FontAwesomeIcons.cat, color: Colors.white)),
          buildButton(Routes.KANDANG, 'Kandang Saya',
              FaIcon(FontAwesomeIcons.home, color: Colors.white)),
        ]),
        const SizedBox(height: 20),
        buildButtonRow([
          buildButton(Routes.INSEMINASI, 'Inseminasi',
              FaIcon(FontAwesomeIcons.dna, color: Colors.white)),
          buildButton(Routes.VAKSIN, 'Vaksinasi',
              FaIcon(FontAwesomeIcons.syringe, color: Colors.white)),
        ]),
        const SizedBox(height: 20),
        buildButtonRow([
          buildButton(Routes.KELAHIRAN, 'Kelahiran',
              FaIcon(FontAwesomeIcons.baby, color: Colors.white)),
          buildButton(Routes.PKB, 'PKB',
              FaIcon(FontAwesomeIcons.building, color: Colors.white)),
        ]),
      ],
    );
  }

  // Membuat fungsi untuk merender button row untuk lebih efisien
  Widget buildButtonRow(List<Widget> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons.map((button) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10), // Jarak antar tombol
          child: button,
        );
      }).toList(),
    );
  }

  Widget buildButton(String route, String text, Widget icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment
          .center, // Menjaga agar tombol dan teks tetap di tengah
      crossAxisAlignment:
          CrossAxisAlignment.center, // Menjaga posisi secara horizontal
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 70, // Ukuran tombol yang konsisten
            height: 70, // Ukuran tombol yang konsisten
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(route); // Navigasi ke route
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor:
                    const Color(0xff132137), // Warna latar belakang tombol
              ),
              child: Center(
                child: icon, // Ikon dari Font Awesome atau Icon lain
              ),
            ),
          ),
        ),
        const SizedBox(height: 10), // Spasi antara tombol dan teks
        Container(
          width: 80, // Atur lebar agar teks lebih leluasa
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Color(0xff132137)),
            textAlign: TextAlign.center, // Teks berada di tengah
            softWrap: true, // Membungkus teks jika panjang
          ),
        ),
      ],
    );
  }
}
