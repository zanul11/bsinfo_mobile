import 'dart:math';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/koneksi.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihan.dart';
import 'package:bsainfo_mobile/pages/pembayaran/pembayaran_bayar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembayaranPage extends StatefulWidget {
  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final api = Api();
  List<Result> listPelanggan = List.empty();
  String selectedNo = '';
  bool loadWidget = false;
  String tagihanRekening = '0';
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
          loadWidget = true;
          listPelanggan = value.result;
          if (!prefs.containsKey('selectedNoPel')) {
            prefs.setString('selectedNoPel', listPelanggan[0].noPelanggan);
            selectedNo = listPelanggan[0].noPelanggan;
          } else {
            selectedNo = prefs.getString('selectedNoPel')!;
          }
          api.getTagihanUserBulanan(nopel: selectedNo).then((value) {
            if (value['status']) {
              setState(() {
                tagihanRekening = value['result'].toString();
              });
            }
          }).catchError((onError) {});
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
          'Pembayaran Online',
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
                    (listPelanggan.length == 0)
                        ? Container()
                        : tagihanWidget(MediaQuery.of(context).size,
                            tagihanRekening, selectedNo, context)
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
                        backgroundColor: (listPelanggan.length == 0)
                            ? Colors.grey
                            : colorTagihan,
                      ),
                      onPressed: () {
                        if (listPelanggan.length == 0) {
                          Fluttertoast.showToast(
                            msg:
                                'Tambah nomer pelanggan pada menu profile terlebih dahulu!',
                            backgroundColor: Colors.orange,
                            textColor: whiteColor,
                          );
                        } else {
                          var today = new DateTime.now();
                          var datebatas = today.add(new Duration(days: 2));
                          Random random = new Random();
                          int randomNumber = random.nextInt(1000);
                          print(
                              "${datebatas.year}${datebatas.month}${datebatas.day}");
                          api
                              .generateVABankJatim(
                                  batas:
                                      "${datebatas.year}${datebatas.month}${datebatas.day}",
                                  noVA: "14812101$selectedNo$randomNumber",
                                  tagihan: tagihanRekening)
                              .then((value) {
                            if (!value['Status']['IsError']) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return PembayaranVAPage(
                                  noVa: value['VirtualAccount'],
                                  batas:
                                      "${datebatas.day}-${datebatas.month}-${datebatas.year}",
                                  total: int.parse(tagihanRekening),
                                );
                              }));
                            } else {
                              Fluttertoast.showToast(
                                msg: value['Status']['ErrorDesc'],
                                backgroundColor: Colors.red,
                                toastLength: Toast.LENGTH_LONG,
                                textColor: whiteColor,
                              );
                            }
                          }).catchError((onError) {
                            Fluttertoast.showToast(
                              msg: 'Server Error!',
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: whiteColor,
                            );
                          });
                        }
                      },
                      child: Text(
                        'Bayar Via Bank Jatim (VA)',
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
