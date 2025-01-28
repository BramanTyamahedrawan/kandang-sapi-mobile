import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Diperlukan jika menggunakan Google Fonts.

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primary,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/data_kosong.png',
            height: 180,
            width: 180,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Data Kosong",
            style: GoogleFonts.tajawal(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xffffca54)),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              "Klik Tombol plus (+) dibawah untuk tambah data",
              style: GoogleFonts.cairo(
                fontSize: 16,
                color: const Color(0xff777777),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
