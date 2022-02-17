import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/koneksi.dart';
import 'package:bsainfo_mobile/models/bacamandiri_model.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:bsainfo_mobile/pages/bacamandiri/bacamandiri_form.dart';
import 'package:bsainfo_mobile/photoHero.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BacaMandiriPage extends StatefulWidget {
  @override
  _BacaMandiriPageState createState() => _BacaMandiriPageState();
}

class _BacaMandiriPageState extends State<BacaMandiriPage> {
  var namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  final api = Api();
  List<Result> listPelanggan = List.empty();
  List<ResultBacaMandiri> listBacaMandiri = List.empty();
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
          api.getBacaMandiri(nopel: selectedNo).then((value) {
            setState(() {
              listBacaMandiri = value.resultBacaMandiri;
              loadWidget = true;
            });
          }).catchError((onError) {
            setState(() {
              loadWidget = true;
              listBacaMandiri = List.empty();
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
          'Baca Mandiri',
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
                        'Histori Baca Mandiri',
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
                            : (listBacaMandiri.length == 0)
                                ? Center(
                                    child: Text('Data baca mandiri tidak ada'),
                                  )
                                : ListView(
                                    children: [
                                      ...List.generate(
                                          listBacaMandiri.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: size.width,
                                                  height: 120,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                        blurRadius: 2.0,
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
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
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
                                                            namaBulan[
                                                                listBacaMandiri[
                                                                            index]
                                                                        .createdAt
                                                                        .month -
                                                                    1],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          )),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (ctx) {
                                                                  return PhotoHeroNetwork(
                                                                    photo: listBacaMandiri[
                                                                            index]
                                                                        .foto1,
                                                                  );
                                                                }));
                                                              },
                                                              child: Container(
                                                                width:
                                                                    size.width /
                                                                        3,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  ),
                                                                  // image:
                                                                  //     DecorationImage(
                                                                  //   image:
                                                                  //       NetworkImage(
                                                                  //     listBacaMandiri[
                                                                  //             index]
                                                                  //         .foto1,
                                                                  //   ),
                                                                  //   fit: BoxFit
                                                                  //       .cover,
                                                                  // ),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      listBacaMandiri[
                                                                              index]
                                                                          .foto1,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Container(
                                                                    height:
                                                                        80.0,
                                                                    width: 50.0,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Image
                                                                          .asset(
                                                                    'assets/bsinfo.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height:
                                                                        80.0,
                                                                    width: 50.0,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Stan Meter : ${listBacaMandiri[index].stanIni} m\u00B3',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      'Stan Lalu : ${listBacaMandiri[index].stanLalu} ',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    Text(
                                                                      'Pemakaian : ${listBacaMandiri[index].pemakaian} ',
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        '${listBacaMandiri[index].memo}',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                        maxLines:
                                                                            10,
                                                                        softWrap:
                                                                            false,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
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
                      onPressed: () {
                        DateTime now = DateTime.now();
                        Api().getConfig().then((value) {
                          if (value['result']['tgl_batas_bm'] < now.day)
                            Fluttertoast.showToast(
                                msg:
                                    "Bacameter Mandiri Hanya Bisa Dilakukan sebelum tgl ${value['result']['tgl_batas_bm']} setiap bulannya!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          else {
                            Api()
                                .cekStatusPelanggan(nopel: selectedNo)
                                .then((value) async {
                              if (value['status']) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (ctx) {
                                  return BacaMandiriForm(
                                    nopel: selectedNo,
                                  );
                                }));
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Bacameter Mandiri Hanya Bisa Dilakukan untuk Pelanggan Aktif, Pelanggan dengan nomor $selectedNo merupakan pelanggan Non Aktif!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pop(context);
                              }
                            });
                          }
                        });
                        // Navigator.pushNamed(context, '/bacamandiri-form');
                      },
                      child: Text(
                        'Baca Mandiri',
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
