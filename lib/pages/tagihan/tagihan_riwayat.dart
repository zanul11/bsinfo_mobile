import 'package:bsainfo_mobile/models/cekTagihan_model.dart';
import 'package:bsainfo_mobile/pages/tagihan/tagihan_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanRiwayat extends StatefulWidget {
  final List<ResultTagihan> listTagihan;
  TagihanRiwayat({required this.listTagihan});
  @override
  _TagihanRiwayatState createState() => _TagihanRiwayatState();
}

class _TagihanRiwayatState extends State<TagihanRiwayat> {
  String moneyFormat(String price) {
    var value = price;
    if (price.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    }
    return value;
  }

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
        children: List.generate(
          widget.listTagihan.length,
          (index) => buildCardTagihan(
            periode: widget.listTagihan[index].tagihan.periode,
            statusBayar: widget.listTagihan[index].tagihan.isPaid.toString(),
            jumlah: (widget.listTagihan[index].tagihan.hargaAir +
                widget.listTagihan[index].tagihan.byPemeliharaan +
                widget.listTagihan[index].tagihan.byRetribusi +
                widget.listTagihan[index].tagihan.byAdministrasi +
                widget.listTagihan[index].tagihan.byLingkungan +
                widget.listTagihan[index].tagihan.byMaterai +
                widget.listTagihan[index].tagihan.byLainnya +
                widget.listTagihan[index].denda),
            tagihan: widget.listTagihan[index],
          ),
        ),
      ),
    );
  }

  Widget buildCardTagihan(
          {required String periode,
          required String statusBayar,
          required int jumlah,
          required ResultTagihan tagihan}) =>
      Container(
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
                    '${namaBulan[int.parse(periode.toString().substring(4, 6))]} ${periode.toString().substring(0, 4)}',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  (statusBayar == '0') ? 'Belum Bayar' : 'Sudah Bayar',
                  style: GoogleFonts.nunito(
                    color: (statusBayar == '0') ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  (statusBayar == '0') ? Icons.close : Icons.check_box,
                  color: (statusBayar == '0') ? Colors.red : Colors.green,
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
                  'Rp. ${moneyFormat('$jumlah')}',
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
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return TagihanDetail(tagihan: tagihan);
                      }));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Detail rekening',
                          style: GoogleFonts.nunito(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
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
