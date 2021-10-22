import 'dart:io';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/models/detail_pelanggan_model.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final api = Api();
  List<Result> listPelanggan = List.empty();
  List<ResultDetailPelanggan> detailPelanggan = [];
  // int countPelanggan = 0;
  String nama = '', nohp = '', selectedNo = '';
  bool loadWidget = false;
  getUser() async {
    loadWidget = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama')!;
      nohp = prefs.getString('nohp')!;
    });
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
        });
        api.detailPelanggan(nopel: selectedNo).then((value) {
          setState(() {
            detailPelanggan = value.resultDetailPelanggan;
            loadWidget = true;
          });
        }).catchError((onError) {
          setState(() {
            loadWidget = true;
            detailPelanggan = List.empty();
          });
        });
      }
    });
  }

  final TextEditingController noPel = TextEditingController();
  @override
  void initState() {
    getUser();

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
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      api
                          .hapusPelanggan(
                              id: listPelanggan[index].id.toString())
                          .then((value) async {
                        if (value['status']) {
                          if (listPelanggan[index].noPelanggan == selectedNo) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('selectedNoPel');
                            getUser();
                          } else {
                            getUser();
                          }
                          Fluttertoast.showToast(
                            msg: 'Berhasil Hapus!',
                            backgroundColor: Colors.green,
                            textColor: whiteColor,
                          );
                          Navigator.pop(context);
                        }
                      }).catchError((onError) {
                        Fluttertoast.showToast(
                          msg: 'Server Error!',
                          backgroundColor: Colors.red,
                          textColor: whiteColor,
                        );
                      });
                    },
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      selectedNo = listPelanggan[index].noPelanggan;

                      prefs.setString(
                          'selectedNoPel', listPelanggan[index].noPelanggan);
                    });
                    getUser();
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  bool _loading = false;

  bottomSheetAddNoPel() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Tambahkan Nomor Pelanggan',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Masukkan nomor Pelanggan Anda pada kolom dibawah ini ;',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: noPel,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Nomor pelanggan ',
                      hintStyle: GoogleFonts.openSans(
                        color: Colors.grey,
                      ),
                      labelStyle: GoogleFonts.openSans(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: colorTagihan,
                    ),
                    onPressed: () async {
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          setState(() {
                            _loading = true;
                          });
                          api
                              .addPelanggan(nopel: noPel.text)
                              .then((value) async {
                            if (value['status']) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (!prefs.containsKey('selectedNoPel')) {
                                setState(() {
                                  prefs.setString('selectedNoPel', noPel.text);
                                });
                              }
                              getUser();
                              Fluttertoast.showToast(
                                msg: "Berhasil tambah no pelanggan",
                                backgroundColor: Colors.green,
                                textColor: whiteColor,
                              );
                              setState(() {
                                _loading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                msg: "${value['message']}",
                                backgroundColor: Colors.red,
                                textColor: whiteColor,
                              );
                              setState(() {
                                _loading = false;
                              });
                            }
                          }).catchError((onError) {
                            Fluttertoast.showToast(
                              msg: 'Server Error!',
                              backgroundColor: Colors.red,
                              textColor: whiteColor,
                            );
                            setState(() {
                              _loading = false;
                            });
                          });
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Tidak ada koneksi internet!',
                            backgroundColor: Colors.red,
                            textColor: whiteColor,
                          );
                          setState(() {
                            _loading = false;
                          });
                        }
                      } on SocketException catch (_) {
                        Fluttertoast.showToast(
                          msg: 'Tidak ada koneksi internet!',
                          backgroundColor: Colors.red,
                          textColor: whiteColor,
                        );
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (_loading)
                            ? CircularProgressIndicator()
                            : Text(
                                'Tambahkan',
                                style: TextStyle(color: Colors.white),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTagihan,
        title: Text('Informasi Pengguna'),
      ),
      backgroundColor: Colors.grey[100],
      body: (!loadWidget)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      height: size.height / 2.2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.grey[350],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nama user',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    nama,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.grey[350],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No hp user',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    nohp,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => (listPelanggan.length == 0)
                                  ? bottomSheetAddNoPel()
                                  : bottomSheet(),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  color: Colors.grey[350],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Nomor pelanggan',
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
                                      onPressed: () =>
                                          (listPelanggan.length == 0)
                                              ? bottomSheetAddNoPel()
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
                          ),
                        ],
                      ),
                    ),
                    (listPelanggan.length == 0)
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: (size.height * 1 / 4.5) / 2,
                                        margin:
                                            EdgeInsets.only(top: 10, bottom: 5),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nama',
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          14,
                                                  color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              detailPelanggan[0].nama,
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          12),
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
                                        height: (size.height * 1 / 4.5) / 2,
                                        margin:
                                            EdgeInsets.only(top: 10, bottom: 5),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Alamat',
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          14,
                                                  color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              detailPelanggan[0].alamat,
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          12),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: (size.height * 1 / 4.5) / 2,
                                        margin:
                                            EdgeInsets.only(top: 10, bottom: 5),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Golongan',
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          14,
                                                  color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              detailPelanggan[0].kodeGolongan,
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          12),
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
                                        height: (size.height * 1 / 4.5) / 2,
                                        margin:
                                            EdgeInsets.only(top: 10, bottom: 5),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Merk Meter',
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          14,
                                                  color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              detailPelanggan[0].merekMeter,
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      (size.height * 1 / 4.5) /
                                                          12),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 75,
                    width: double.infinity,
                    color: Colors.white,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border(
                    //     top: BorderSide(
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: colorTagihan,
                      ),
                      onPressed: () => bottomSheetAddNoPel(),
                      child: Text(
                        'Tambah Nomor Pelanggan',
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
