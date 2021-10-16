import 'dart:io';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/models/jenis_pengaduan_model.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  String selectedNo = '';
  String namaUser = '', nohpUser = '';
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('nama')) {
        namaUser = prefs.getString('nama')!;
        nohpUser = prefs.getString('nohp')!;
      }
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

  final TextEditingController nama = TextEditingController();
  final TextEditingController noIdentitas = TextEditingController();
  final TextEditingController alamat = TextEditingController();
  final TextEditingController noTlp = TextEditingController();
  final TextEditingController ket = TextEditingController();

  List<ResultJenisPengaduan> dataJenisPengaduan = [];

  getDataSpesialis() {
    Api().getJenisPengaduan().then((value) {
      dataJenisPengaduan = value.resultJenisPengaduan;
    });
  }

  Widget _customDropDown(BuildContext context, ResultJenisPengaduan? item,
      String itemDesignation) {
    if (item == null) {
      return Container();
    }
    return Container(
        child: ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(item.nama),
    ));
  }

  Future<List<ResultJenisPengaduan>> getDataSpesialisCari(filter) async {
    return dataJenisPengaduan
        .where((element) => (element.nama.contains(filter)))
        .toList();
  }

  Widget _customPopupItemBuilder(
      BuildContext context, ResultJenisPengaduan item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        title: Text(item.nama),
      ),
    );
  }

  @override
  void initState() {
    getUser();
    getDataSpesialis();
    super.initState();
  }

  @override
  void dispose() {
    nama.dispose();
    noIdentitas.dispose();
    alamat.dispose();
    noTlp.dispose();
    ket.dispose();
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
  ResultJenisPengaduan _selectedJenisPengaduan =
      ResultJenisPengaduan(id: 0, nama: 'Pilih Jenis Pengaduan');

  showAlertDialog(BuildContext context, String isi) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: GoogleFonts.openSans(),
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Perhatian!",
        style: GoogleFonts.openSans(),
      ),
      content: Text(
        "$isi",
        style: GoogleFonts.openSans(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    // ignore: unnecessary_statements
    if (_currentStep < 1) {
      FocusScope.of(context).requestFocus(new FocusNode());
      if (_currentStep == 0) {
        if (menu == 0) {
          if (noIdentitas.text == '' || alamat.text == '') {
            showAlertDialog(context, 'Field Tidak boleh kosong');
          } else
            setState(() => _currentStep += 1);
        } else {
          if (noIdentitas.text == '' ||
              alamat.text == '' ||
              nama.text == '' ||
              noTlp.text == '') {
            showAlertDialog(context, 'Field Tidak boleh kosong');
          } else
            setState(() => _currentStep += 1);
        }

        // setState(() => _currentStep += 1);
      } else {
        setState(() => _currentStep += 1);
      }
    } else {
      print('habis');
    }
  }

  cancel() {
    // ignore: unnecessary_statements
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
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
          'Form Pengaduan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: (_currentStep == 1)
          ? FloatingActionButton.extended(
              onPressed: () async {
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    Api()
                        .savePengaduan(
                            pelangganId: (menu == 0) ? selectedNo : '',
                            nama: (menu == 0) ? namaUser : nama.text,
                            alamat: alamat.text,
                            noIdentitas: noIdentitas.text,
                            noTlp: (menu == 0) ? nohpUser : noTlp.text,
                            jenisAduan: _selectedJenisPengaduan.id.toString(),
                            keterangan: ket.text)
                        .then((value) {
                      if (value['status']) {
                        Fluttertoast.showToast(
                            msg: "Berhasil Mengirim Pengaduan!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil("/home", (route) => false);
                      }
                    }).catchError((onError) {
                      Fluttertoast.showToast(
                          msg: "Server Error!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Tidak ada jaringan internet!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    print('not connected');
                  }
                } on SocketException catch (_) {
                  Fluttertoast.showToast(
                      msg: "Tidak ada jaringan internet!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  print('not connected');
                }
              },
              label: Text('KIRIM PENGADUAN'),
              icon: Icon(Icons.send),
              backgroundColor: Colors.blue,
            )
          : Container(),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
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
                                color: (menu == 0)
                                    ? Colors.green.shade500
                                    : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  'PELANGGAN',
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: (menu == 0)
                                          ? Colors.white
                                          : Colors.grey),
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
                                color: (menu == 1)
                                    ? Colors.green.shade500
                                    : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'NON PELANGGAN',
                                  style: GoogleFonts.nunito(
                                      fontSize: 15,
                                      color: (menu == 1)
                                          ? Colors.white
                                          : Colors.grey),
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
                    (menu == 1)
                        ? Container()
                        : GestureDetector(
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
                  'Form Pengaduan',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: _currentStep < 1 ? continued : null,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                        title: Text('Informasi Pengadu'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (menu == 0)
                                ? Container()
                                : TextFormField(
                                    style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                    ),
                                    controller: nama,
                                    decoration: InputDecoration(
                                      labelText: 'Nama',
                                      labelStyle: GoogleFonts.openSans(
                                        fontSize: 10.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      hintText: 'Nama',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              style: GoogleFonts.openSans(
                                fontSize: 14.0,
                              ),
                              controller: noIdentitas,
                              decoration: InputDecoration(
                                labelText: 'No Identitas',
                                labelStyle: GoogleFonts.openSans(
                                  fontSize: 10.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText: 'No Identitas',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            (menu == 0)
                                ? Container()
                                : TextFormField(
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                    ),
                                    controller: noTlp,
                                    decoration: InputDecoration(
                                      labelText: 'No Telp/Hp',
                                      labelStyle: GoogleFonts.openSans(
                                        fontSize: 10.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      hintText: 'No Telp/Hp',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              style: GoogleFonts.openSans(
                                fontSize: 14.0,
                              ),
                              maxLines: 2,
                              controller: alamat,
                              decoration: InputDecoration(
                                labelText: 'Alamat',
                                labelStyle: GoogleFonts.openSans(
                                  fontSize: 10.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText: 'Alamat',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Step(
                        isActive: _currentStep >= 1,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                        title: Text('Informasi Gangguan'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            DropdownSearch<ResultJenisPengaduan>(
                              mode: Mode.DIALOG,
                              showSearchBox: false,
                              // isFilteredOnline: true,
                              // showClearButton: true,
                              onFind: (String filter) =>
                                  getDataSpesialisCari(filter),
                              dropdownBuilder: _customDropDown,
                              popupItemBuilder: _customPopupItemBuilder,
                              label: "Jenis Pengaduan",
                              hint: "Pilih Spesialisasi",
                              // popupItemDisabled: (String s) => s.startsWith('I'),
                              onChanged: (value) {
                                _selectedJenisPengaduan = value!;
                              },
                              selectedItem: _selectedJenisPengaduan,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              style: GoogleFonts.openSans(
                                fontSize: 14.0,
                              ),
                              maxLines: 3,
                              controller: ket,
                              decoration: InputDecoration(
                                labelText: 'Rincian Aduan',
                                labelStyle: GoogleFonts.openSans(
                                  fontSize: 10.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText: 'Rincian Aduan',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // child: ListView(
                //   children: [
                //     Padding(
                //         padding:
                //             EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           children: <Widget>[
                //             Flexible(
                //               child: DropdownSearch<ResultJenisPengaduan>(
                //                 mode: Mode.DIALOG,
                //                 showSearchBox: false,
                //                 // isFilteredOnline: true,
                //                 // showClearButton: true,
                //                 onFind: (String filter) =>
                //                     getDataSpesialisCari(filter),
                //                 dropdownBuilder: _customDropDown,
                //                 popupItemBuilder: _customPopupItemBuilder,
                //                 label: "Jenis Pengaduan",
                //                 hint: "Pilih Spesialisasi",
                //                 // popupItemDisabled: (String s) => s.startsWith('I'),
                //                 onChanged: (value) {
                //                   _selectedJenisPengaduan = value!;
                //                 },
                //                 selectedItem: _selectedJenisPengaduan,
                //               ),
                //             ),
                //           ],
                //         )),
                //     SizedBox(
                //       height: 15.0,
                //     ),
                //     TextFormField(
                //       maxLines: 3,
                //       // controller: ketController,
                //       textInputAction: TextInputAction.done,
                //       style: GoogleFonts.openSans(
                //         fontSize: 14.0,
                //       ),
                //       // maxLength: 150,
                //       decoration: InputDecoration(
                //         labelStyle: GoogleFonts.openSans(
                //           fontSize: 10.0,
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(15.0),
                //           borderSide: BorderSide(
                //             color: Colors.blue,
                //           ),
                //         ),
                //         hintText: 'Keterangan',
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(15.0),
                //           borderSide: BorderSide(
                //             color: Colors.blueAccent,
                //             width: 1.0,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              )
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     height: 75,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border: Border(
          //         top: BorderSide(
          //           color: Colors.grey.shade200,
          //           width: 1.0,
          //         ),
          //       ),
          //     ),
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         backgroundColor: colorTagihan,
          //       ),
          //       onPressed: null,
          //       child: Text(
          //         'Kirim Pengaduan',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
