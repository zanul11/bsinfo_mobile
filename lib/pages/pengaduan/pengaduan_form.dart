import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaduanForm extends StatefulWidget {
  @override
  _PengaduanFormState createState() => _PengaduanFormState();
}

class _PengaduanFormState extends State<PengaduanForm> {
  final api = Api();
  List<Result> listPelanggan = List.empty();
  String nama = '', nohp = '', selectedNo = '';
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama')!;
      nohp = prefs.getString('nohp')!;
    });
    api.getuserPelanggan().then((value) {
      if (value.message == 'tidak ditemukan') {
        setState(() {
          // countPelanggan = 0;
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
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      selectedNo = listPelanggan[index].noPelanggan;

                      prefs.setString(
                          'selectedNoPel', listPelanggan[index].noPelanggan);
                    });
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  int menu = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTagihan,
        title: Text(
          'Form Pengaduan',
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                menu = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                color:
                                    (menu == 0) ? Colors.amber : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 1.0,
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  'PELANGGAN',
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: (menu == 0)
                                          ? Colors.black
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                menu = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color:
                                    (menu == 1) ? Colors.amber : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 1.0,
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  'NON PELANGGAN',
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: (menu == 1)
                                          ? Colors.black
                                          : Colors.black),
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
                    GestureDetector(
                      onTap: () => (listPelanggan.length == 0)
                          ? Fluttertoast.showToast(
                              msg: 'Tambah nomer pelanggan pada menu profile!',
                              backgroundColor: Colors.green,
                              textColor: whiteColor,
                            )
                          : bottomSheet(),
                      child: Container(
                        margin: EdgeInsets.all(7),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nomor Pelanggan',
                                    style: TextStyle(color: Colors.grey[600]),
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
                                      backgroundColor: Colors.green,
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
                  'Form Pengaduan',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.white,
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.white,
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.white,
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.white,
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.white,
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.white,
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    color: Colors.amber,
                  )
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
                onPressed: null,
                child: Text(
                  'Kirim Pengaduan',
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
