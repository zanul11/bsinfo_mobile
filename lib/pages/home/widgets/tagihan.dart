import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

Padding tagihanWidget(Size ukuranLayar) {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
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

Padding tagihanShimmerWidget(Size ukuranLayar) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ukuranLayar.width,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  color: Colors.grey,
                  height: 17,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    color: Colors.grey,
                    height: (ukuranLayar.height * 1 / 7) / 4,
                  )),
              SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    color: Colors.grey,
                    height: 10,
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}
