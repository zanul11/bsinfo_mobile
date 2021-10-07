import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding tagihanBelumDaftar(Size ukuranLayar, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ukuranLayar.width,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: colorTagihan,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Silahkan tambah no pelanggan ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login", (route) => false);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text('Tambah No Langganan'),
                        ],
                      ))
                ],
              ),
              Text(
                'Untuk mendapatkan informasi tagihan otomatis tiap bulannya, atau melalui fitur Tagihan untuk mendapat informasi tagihan secara langsung.',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
