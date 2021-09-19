import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding tagihanWidget(Size ukuranLayar) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No Pelanggan Anda',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              '2018082061',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: ukuranLayar.height * 1 / 7,
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
                'Tagihan Air Anda bulan Maret',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Rp',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '50.000',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: (ukuranLayar.height * 1 / 7) / 4,
                    ),
                  ),
                ],
              ),
              Text(
                'Bayar Tagihan Anda sebelum Tanggal 25',
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
