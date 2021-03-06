import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

menuWidget(Size ukuranLayar, BuildContext context, bool cekLogin) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Informasi Pelanggan',
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/tagihan'),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/tagihan.png',
                            height: (ukuranLayar.height * 1 / 3) / 6,
                          ),
                          Text(
                            'Tagihan',
                            style: GoogleFonts.poppins(
                                fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (cekLogin)
                        Navigator.pushNamed(context, '/pengaduan');
                      else
                        Fluttertoast.showToast(
                          msg: 'Silhkan Login untuk Mengakses Fitur ini!',
                          backgroundColor: Colors.orange,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: whiteColor,
                        );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/pengaduan.png',
                            height: (ukuranLayar.height * 1 / 3) / 6,
                          ),
                          Text(
                            'Pengaduan',
                            style: GoogleFonts.poppins(
                                fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, '/profile-perusahaan'),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/profile.png',
                            height: (ukuranLayar.height * 1 / 3) / 6,
                          ),
                          Text(
                            'Profil',
                            style: GoogleFonts.poppins(
                                fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (cekLogin)
                        Navigator.pushNamed(context, '/bacamandiri');
                      else
                        Fluttertoast.showToast(
                          msg: 'Silhkan Login untuk Mengakses Fitur ini!',
                          backgroundColor: Colors.orange,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: whiteColor,
                        );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/bacameter.png',
                            height: (ukuranLayar.height * 1 / 3) / 6,
                          ),
                          Text(
                            'Baca Mandiri',
                            style: GoogleFonts.poppins(
                                fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: InkWell(
                    // onTap: () => Navigator.pushNamed(context, '/pembayaran'),
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: 'Dalam tahap pengembangan!',
                        backgroundColor: Colors.green,
                        toastLength: Toast.LENGTH_LONG,
                        textColor: whiteColor,
                      );
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/pembayaran.png',
                            height: (ukuranLayar.height * 1 / 3) / 6,
                          ),
                          Text(
                            'Pembayaran Online',
                            style: GoogleFonts.poppins(
                                fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}
