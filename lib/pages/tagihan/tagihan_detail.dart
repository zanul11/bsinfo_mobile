import 'package:bsainfo_mobile/models/cekTagihan_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanDetail extends StatefulWidget {
  final ResultTagihan tagihan;
  TagihanDetail({required this.tagihan});
  @override
  _TagihanDetailState createState() => _TagihanDetailState();
}

class _TagihanDetailState extends State<TagihanDetail> {
  final double coverHeight = 150;
  final double profileHeight = 72;

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

  String moneyFormat(String price) {
    var value = price;
    if (price.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    }
    return value;
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
                    color: (widget.tagihan.tagihan.isPaid == 1)
                        ? Colors.green
                        : Colors.red,
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
                    backgroundColor: (widget.tagihan.tagihan.isPaid == 1)
                        ? Colors.green
                        : Colors.red,
                    // backgroundImage: AssetImage('assets/logos.png', ),
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(profileHeight / 2),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          (widget.tagihan.tagihan.isPaid == 1)
                              ? Icons.check
                              : Icons.close,
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
                  (widget.tagihan.tagihan.isPaid == 1)
                      ? 'Sudah Terbayar'
                      : 'Belum Bayar',
                  style: GoogleFonts.nunito(
                    fontSize: 17,
                    color: (widget.tagihan.tagihan.isPaid == 1)
                        ? Colors.green
                        : Colors.red,
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
                            '${widget.tagihan.tagihan.stanIni}',
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
                            '${widget.tagihan.tagihan.stanLalu}',
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
                            '${widget.tagihan.tagihan.pemakaian}',
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
                            (widget.tagihan.tagihan.isPaid == 0)
                                ? '-'
                                : '${widget.tagihan.tagihan.tglBayar}',
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

  Widget detailFoto() => InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return FotoDetail(gambar: widget.tagihan.tagihan.bacameter.foto1);
          }));
        },
        child: Container(
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
              image: NetworkImage('${widget.tagihan.tagihan.bacameter.foto1}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            'Foto Water Meter',
            style: GoogleFonts.nunito(
              color: Colors.white,
            ),
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
                    '${namaBulan[int.parse(widget.tagihan.tagihan.periode.toString().substring(4, 6))]} ${widget.tagihan.tagihan.periode.toString().substring(0, 4)}',
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
                  '${moneyFormat(widget.tagihan.tagihan.hargaAir.toString())}',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Text(
            //         'Air Limbah',
            //         style: GoogleFonts.nunito(
            //           color: Colors.grey,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //     Text(
            //       '0',
            //       style: GoogleFonts.nunito(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Denda',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${moneyFormat(widget.tagihan.denda.toString())}',
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
                  '${moneyFormat(widget.tagihan.tagihan.byAdministrasi.toString())}',
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
                  '${moneyFormat(widget.tagihan.tagihan.byRetribusi.toString())}',
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
                  '${moneyFormat(widget.tagihan.tagihan.byPemeliharaan.toString())}',
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
                    'Lingkungan',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${moneyFormat(widget.tagihan.tagihan.byLingkungan.toString())}',
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
                  '${moneyFormat(widget.tagihan.tagihan.byMaterai.toString())}',
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
                    'Lainnya',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${moneyFormat(widget.tagihan.tagihan.byLainnya.toString())}',
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
                  '${moneyFormat((widget.tagihan.tagihan.hargaAir + widget.tagihan.tagihan.byPemeliharaan + widget.tagihan.tagihan.byRetribusi + widget.tagihan.tagihan.byAdministrasi + widget.tagihan.tagihan.byLingkungan + widget.tagihan.tagihan.byMaterai + widget.tagihan.tagihan.byLainnya + widget.tagihan.denda).toString())}',
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

class FotoDetail extends StatelessWidget {
  final String gambar;
  FotoDetail({required this.gambar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InteractiveViewer(
      child: GestureDetector(
        child: Container(
          child: Center(
            child: Hero(
              tag: 'imageHero',
              child: CachedNetworkImage(
                imageUrl: gambar,
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ));
  }
}
