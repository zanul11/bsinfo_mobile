import 'dart:ui';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/koneksi.dart';
import 'package:bsainfo_mobile/models/pengaduan_model.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaduanPage extends StatefulWidget {
  @override
  _PengaduanPageState createState() => _PengaduanPageState();
}

class _PengaduanPageState extends State<PengaduanPage> {
  final api = Api();
  List<Result> listPelanggan = List.empty();
  List<ResultPengaduan> listPengaduan = List.empty();
  String selectedNo = '';
  bool loadWidget = false;
  getUser() async {
    loadWidget = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    api.getuserPelanggan().then((value) {
      if (value.message == 'tidak ditemukan') {
        setState(() {
          // countPelanggan = 0;
          loadWidget = true;
          listPelanggan = List.empty();
        });
      } else {
        setState(() {
          listPelanggan = value.result;
          if (!prefs.containsKey('selectedNoPel')) {
            prefs.setString('selectedNoPel', listPelanggan[0].noPelanggan);
            selectedNo = listPelanggan[0].noPelanggan;
          } else {
            selectedNo = prefs.getString('selectedNoPel')!;
          }
          api.getPengaduan(nopel: selectedNo).then((value) {
            setState(() {
              listPengaduan = value.resultPengaduan;
              loadWidget = true;
            });
          }).catchError((onError) {
            setState(() {
              loadWidget = true;
              listPengaduan = List.empty();
            });
          });
        });
      }
    });
  }

  final TextEditingController noPel = TextEditingController();
  @override
  void initState() {
    KoneksiInternet().koneksi().then((value) {
      if (value) {
        getUser();
      } else {}
    });

    super.initState();
  }

  @override
  void dispose() {
    noPel.dispose();
    super.dispose();
  }

  bottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...List.generate(
                listPelanggan.length,
                (index) => ListTile(
                  leading: Icon(
                    (selectedNo == listPelanggan[index].noPelanggan)
                        ? Icons.check_box
                        : Icons.person,
                    color: (selectedNo == listPelanggan[index].noPelanggan)
                        ? Colors.green
                        : Colors.blue,
                  ),
                  title: Text(listPelanggan[index].noPelanggan),
                  subtitle: Text(listPelanggan[index].pelangganDetail.nama),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      selectedNo = listPelanggan[index].noPelanggan;

                      prefs.setString(
                          'selectedNoPel', listPelanggan[index].noPelanggan);
                      getUser();
                    });
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Pengaduan Pelanggan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: (!loadWidget)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => (listPelanggan.length == 0)
                                ? Fluttertoast.showToast(
                                    msg:
                                        'Tambah nomer pelanggan pada menu profile!',
                                    backgroundColor: Colors.orange,
                                    textColor: whiteColor,
                                  )
                                : bottomSheet(),
                            child: Container(
                              margin: EdgeInsets.all(7),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nomor Pelanggan',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        (listPelanggan.length == 0)
                                            ? Text(
                                                'Tambahkan nomor pelanggan',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              )
                                            : Text(
                                                '$selectedNo',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => (listPelanggan.length == 0)
                                        ? Fluttertoast.showToast(
                                            msg:
                                                'Tambah nomer pelanggan pada menu profile!',
                                            backgroundColor: Colors.orange,
                                            textColor: whiteColor,
                                          )
                                        : bottomSheet(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey.shade500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Daftar Pengaduan',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                        child: (listPelanggan.length == 0)
                            ? Center(
                                child: Text('Tambahkan nomer pelanggan'),
                              )
                            : (listPengaduan.length == 0)
                                ? Center(
                                    child: Text('Data pengaduan tidak ada'),
                                  )
                                : ListView(
                                    children: [
                                      ...List.generate(
                                          listPengaduan.length,
                                          (index) => Container(
                                                width: double.infinity,
                                                height: 100,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: Offset(
                                                          0.0, 1.0), //(x,y)
                                                      blurRadius: 1.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Stack(
                                                  children: [
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: Container(
                                                        height: 40,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (listPengaduan[
                                                                          index]
                                                                      .isComplete ==
                                                                  0)
                                                              ? ((listPengaduan[
                                                                              index]
                                                                          .isProcessed ==
                                                                      0)
                                                                  ? Colors
                                                                      .orange
                                                                  : Colors.blue)
                                                              : Colors.green,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              offset: Offset(
                                                                  0.0,
                                                                  1.0), //(x,y)
                                                              blurRadius: 2.0,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          (listPengaduan[index]
                                                                      .isComplete ==
                                                                  0)
                                                              ? ((listPengaduan[
                                                                              index]
                                                                          .isProcessed ==
                                                                      0)
                                                                  ? 'Menunggu'
                                                                  : 'Proses')
                                                              : 'Selesai',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              listPengaduan[
                                                                      index]
                                                                  .jenis[0]
                                                                  .nama,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "${listPengaduan[index].createdAt.day}-${listPengaduan[index].createdAt.month}-${listPengaduan[index].createdAt.year}",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                listPengaduan[
                                                                        index]
                                                                    .keterangan,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                ),
                                                                maxLines: 10,
                                                                softWrap: false,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                    ],
                                  ))
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 75,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: colorTagihan,
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/pengaduan-form'),
                      child: Text(
                        'Tambah Pengaduan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
