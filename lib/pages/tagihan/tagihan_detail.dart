import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanDetail extends StatefulWidget {
  @override
  _TagihanDetailState createState() => _TagihanDetailState();
}

class _TagihanDetailState extends State<TagihanDetail> {
  final double coverHeight = 150;
  final double profileHeight = 72;

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Detail Tagihan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          headerTagihan(bottom: bottom, top: top),
          detailTagihan(),
          detailFoto(),
        ],
      ),
    );
  }

  Widget headerTagihan({required double top, required double bottom}) =>
      Container(
          padding: EdgeInsets.only(
            top: 30,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          margin: EdgeInsets.only(
              left: 15, right: 15, top: profileHeight, bottom: 15),
          height: coverHeight,
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
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: top,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey.shade300,
                          spreadRadius: 5)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: profileHeight / 2,
                    backgroundColor: Colors.green,
                    // backgroundImage: AssetImage('assets/logos.png', ),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(profileHeight / 2),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: profileHeight / 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: top - 30,
                child: Text(
                  'Sudah Terbayar',
                  style: GoogleFonts.nunito(
                    fontSize: 17,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: top - top,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stand Ini',
                            style: GoogleFonts.nunito(),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '2000',
                            style: GoogleFonts.nunito(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stan Lalu',
                            style: GoogleFonts.nunito(),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '1900',
                            style: GoogleFonts.nunito(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pakai',
                            style: GoogleFonts.nunito(),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '10',
                            style: GoogleFonts.nunito(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal Bayar',
                            style: GoogleFonts.nunito(),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '03 Oktober 2021',
                            style: GoogleFonts.nunito(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));

  Widget detailFoto() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 250,
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
          image: DecorationImage(
            image: NetworkImage(
                'https://images.tokopedia.net/img/cache/500-square/product-1/2017/11/12/0/0_51312531-d99b-4231-9a06-cf6e3c24a6de_700_933.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          'Foto Water Meter',
          style: GoogleFonts.nunito(
            color: Colors.white,
          ),
        ),
      );
  Widget detailTagihan() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 15),
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
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Detail Pembayaran',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Biaya Pemakaian',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Air Limbah',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Administrasi',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Retribusi',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pemeliharaan',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pelayanan',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Materai',
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
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'PPN',
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
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  'RP. 300.000',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
