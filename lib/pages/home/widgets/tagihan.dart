import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/pages/tagihan/tagihan_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

String moneyFormat(String price) {
  var value = price;
  if (price.length > 2) {
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
  }
  return value;
}

Padding tagihanWidget(
    Size ukuranLayar, String bayar, String nopel, BuildContext context) {
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
                'Tagihan Air Anda bulan ini',
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
                    '${moneyFormat(bayar)}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: (ukuranLayar.height * 1 / 7) / 4,
                    ),
                  ),
                ],
              ),
              Text(
                'Bayar Tagihan Anda sebelum Tanggal 20',
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
                                nopel: nopel, listTagihan: value.resultTagihan);
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
