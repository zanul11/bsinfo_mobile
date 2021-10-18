import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanRiwayat extends StatefulWidget {
  @override
  _TagihanRiwayatState createState() => _TagihanRiwayatState();
}

class _TagihanRiwayatState extends State<TagihanRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Riwayat Tagihan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          buildCardTagihan(),
          buildCardTagihan(),
          buildCardTagihan(),
          buildCardTagihan(),
          buildCardTagihan(),
          buildCardTagihan(),
          buildCardTagihan(),
          buildCardTagihan(),
        ],
      ),
    );
  }

  Widget buildCardTagihan() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Oktober 2021',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Sudah Bayar',
                  style: GoogleFonts.nunito(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(
                  Icons.attach_money_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Tagihan Rekening',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'RP. 300.000',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
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
                      Navigator.pushNamed(context, '/tagihan-detail');
                    },
                    child: Row(
                      children: [
                        Text(
                          'Detail rekening',
                          style: GoogleFonts.nunito(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
}
