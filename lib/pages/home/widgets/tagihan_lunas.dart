import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/pages/tagihan/tagihan_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

final namaBulan = [
  "",
  "Januari",
  "Februar1",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
];

Padding tagihanLunas(Size ukuranLayar, String nopel, BuildContext context) {
  final DateTime now = DateTime.now();
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
                'Tagihan Air Anda bulan ini',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check_box,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Sudah Terbayarkan',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: (ukuranLayar.height * 1 / 7) / 6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tagihan bulan ${namaBulan[DateTime(now.year, now.month + 1, 1).month]} akan muncul pada 01-${DateTime(now.year, now.month + 1, 1).month}-2021',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Material(
                    elevation: 0,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Api().getListTagihan(nopel: nopel).then((value) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return TagihanRiwayat(
                              nopel: nopel,
                              listTagihan: value.resultTagihan,
                            );
                          }));
                        }).catchError((onError) {
                          Fluttertoast.showToast(
                            msg: 'Server Error!',
                            backgroundColor: Colors.red,
                            textColor: whiteColor,
                          );
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'Lihat rekening',
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
