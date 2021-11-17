import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class PembayaranVAPage extends StatefulWidget {
  final String noVa, batas;
  final int total;
  PembayaranVAPage({
    required this.noVa,
    required this.batas,
    required this.total,
  });
  @override
  _PembayaranVAPageState createState() => _PembayaranVAPageState();
}

class _PembayaranVAPageState extends State<PembayaranVAPage> {
  final formatCurrency = intl.NumberFormat("#,###", "en_US");
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: Text(
          'Pembayaran VA Bank JATIM',
          style: GoogleFonts.nunito(color: Colors.white),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.yellow.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Silahkan segera selesaikan pembayaran anda',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Pembayaran akan dicek otomatis oleh sistem jika anda telah melakukan proses pembayaran',
                    style: GoogleFonts.nunito(),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Batas Akhir Pembayaran',
                    style: GoogleFonts.nunito(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.batas}',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 10,
              color: Colors.grey.shade300,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bank Jatim Virtual Account',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    'assets/bank.png',
                    height: 35,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 2,
              color: Colors.grey.shade300,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nomor Virtual Account',
                        style: GoogleFonts.nunito(color: Colors.grey),
                      ),
                      Text(
                        '${widget.noVa}',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      FlutterClipboard.copy('${widget.noVa}').then((value) {
                        Fluttertoast.showToast(
                          msg: 'Salin Nomor VA',
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Salin',
                          style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.copy,
                          color: Colors.green,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: GoogleFonts.nunito(color: Colors.grey),
                      ),
                      Text(
                        'Rp. ${formatCurrency.format(widget.total)}',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 10,
              color: Colors.grey.shade300,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cara Pembayaran',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  ExpansionTile(
                      initiallyExpanded: false,
                      title: Text(
                        'ATM Bank Jatim',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, bottom: 10),
                          child: Text('''1. Pilih Menu Pembayaran
2. Pilih Lainnya
3. Pilih Virtual Account 
4. Masukan Nomor Bank Jatim Virtual Account
5. Pilih Jenis Rekening Anda
6. Jika data sudah benar, lakukan konfirmasi pembayaran anda
7. Transaksi selesai'''),
                        )
                      ]),
                  // ExpansionTile(
                  //     initiallyExpanded: false,
                  //     title: Text(
                  //       '${widget.bank} Mobile ',
                  //       style: GoogleFonts.nunito(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     children: [
                  //       Padding(
                  //         padding:
                  //             const EdgeInsets.only(left: 15.0, bottom: 10),
                  //         child: Text(widget.mobile),
                  //       )
                  //     ])
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: size.height / 10,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
                child: Text(
                  'Kembali ke Home',
                  style: GoogleFonts.nunito(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
