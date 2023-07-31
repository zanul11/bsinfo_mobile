import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/models/cekTagihan_model.dart';
import 'package:bsainfo_mobile/pages/tagihan/tagihan_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanRiwayat extends StatefulWidget {
  final List<ResultTagihan> listTagihan;
  final String nopel;
  TagihanRiwayat({required this.listTagihan, required this.nopel});
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

  String nopel = '';
  String nama = '';
  String alamat = '';
  String gol = '';
  String status = '1';
  dynamic totalBayar = 0;

  getDataPel() {
    Api().detailPelanggan(nopel: widget.nopel).then((value) {
      nama = value.resultDetailPelanggan[0].nama;
      alamat = value.resultDetailPelanggan[0].alamat;
      gol = value.resultDetailPelanggan[0].kodeGolongan;
      status = value.resultDetailPelanggan[0].status.toString();
      widget.listTagihan.forEach((element) {
        if (element.tagihan.isPaid == 0) {
          var tmp = (element.tagihan.hargaAir +
              element.tagihan.byPemeliharaan +
              element.tagihan.byRetribusi +
              element.tagihan.byAdministrasi +
              element.tagihan.byLingkungan +
              element.tagihan.byMaterai +
              element.tagihan.byLainnya +
              element.tagihan.byAngsuran +
              element.denda);
          totalBayar += tmp;
        }
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    getDataPel();
    super.initState();
  }

  final namaBulan = [
    "",
    "Januari",
    "Februari",
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
      body: Column(
        children: [
          buildDetailPel(),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.white,
            width: double.infinity,
            child: Center(
              child: Text(
                'Riwayat Tagihan',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                widget.listTagihan.length,
                (index) => buildCardTagihan(
                  periode: widget.listTagihan[index].tagihan.periode,
                  statusBayar:
                      widget.listTagihan[index].tagihan.isPaid.toString(),
                  jumlah: (widget.listTagihan[index].tagihan.hargaAir +
                      widget.listTagihan[index].tagihan.byPemeliharaan +
                      widget.listTagihan[index].tagihan.byRetribusi +
                      widget.listTagihan[index].tagihan.byAdministrasi +
                      widget.listTagihan[index].tagihan.byLingkungan +
                      widget.listTagihan[index].tagihan.byMaterai +
                      widget.listTagihan[index].tagihan.byLainnya +
                      widget.listTagihan[index].tagihan.byAngsuran +
                      widget.listTagihan[index].denda),
                  tagihan: widget.listTagihan[index],
                ),
              ),
            ),
          ),
          (widget.listTagihan
                      .where((element) => element.tagihan.isPaid == 0)
                      .length ==
                  0)
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
                            Icons.confirmation_number_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Jumlah Rekening Belum Terbayar',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            widget.listTagihan
                                .where((element) => element.tagihan.isPaid == 0)
                                .length
                                .toString(),
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.request_page_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Total',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Rp. ${moneyFormat('$totalBayar')}',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Total pembayaran belum termasuk biaya admin untuk pembayaran melalui PPOB atau online',
                        style: GoogleFonts.nunito(
                          fontSize: MediaQuery.of(context).size.height / 80,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget buildDetailPel() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  Icons.format_list_numbered_rounded,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'No Pel',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    widget.nopel,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Nama',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    nama,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Alamat',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    alamat,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.album_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Gol',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    gol,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_box_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Status',
                    style: GoogleFonts.nunito(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    (status == '1') ? 'Aktif' : 'Tidak Aktif',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      );

  Widget buildCardTagihan(
          {required String periode,
          required String statusBayar,
          required int jumlah,
          required ResultTagihan tagihan}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
              height: 7,
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
                  '${moneyFormat('$jumlah')}',
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
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
