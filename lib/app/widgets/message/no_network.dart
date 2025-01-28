import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Diperlukan jika menggunakan Google Fonts.

class NoNetwork extends StatelessWidget {
  final Function? onInit;
  const NoNetwork({super.key, @required this.onInit});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/no-internet.png',
            height: 180,
            width: 180,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Terputus",
            style: GoogleFonts.archivo(
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
              "Maaf, koneksi internet tidak tersedia, periksa koneksi internet Anda dan coba lagi",
              style: GoogleFonts.cairo(
                color: const Color(0xff777777),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 52,
            width: 160,
            child: ElevatedButton(
              onPressed: () async {
                if (onInit != null) {
                  await onInit!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffca54),
              ),
              child: Text(
                "Muat Ulang",
                style: GoogleFonts.cairo(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
