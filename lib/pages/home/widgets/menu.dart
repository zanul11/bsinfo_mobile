import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

menuWidget(Size ukuranLayar) {
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
                padding: EdgeInsets.all(7),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/bookmark.png',
                      height: (ukuranLayar.height * 1 / 4.5) / 6,
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
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                padding: EdgeInsets.all(7),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/bookmark.png',
                      height: (ukuranLayar.height * 1 / 4.5) / 6,
                    ),
                    Text(
                      'Keluhan',
                      style: GoogleFonts.poppins(
                          fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                    )
                  ],
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
                padding: EdgeInsets.all(7),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/bookmark.png',
                      height: (ukuranLayar.height * 1 / 4.5) / 6,
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                height: (ukuranLayar.height * 1 / 4.5) / 2,
                margin: EdgeInsets.only(top: 10, bottom: 5),
                padding: EdgeInsets.all(7),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/bookmark.png',
                      height: (ukuranLayar.height * 1 / 4.5) / 6,
                    ),
                    Text(
                      'Baca Meter Mandiri',
                      style: GoogleFonts.poppins(
                          fontSize: (ukuranLayar.height * 1 / 4.5) / 14),
                      textAlign: TextAlign.center,
                    )
                  ],
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
                padding: EdgeInsets.all(7),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/bookmark.png',
                      height: (ukuranLayar.height * 1 / 4.5) / 6,
                    ),
                    Text(
                      'Pembayaran Online',
                      style: GoogleFonts.poppins(
                        fontSize: (ukuranLayar.height * 1 / 4.5) / 14,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
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
