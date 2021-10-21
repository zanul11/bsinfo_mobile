import 'dart:io';
import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/pages/tagihan/tagihan_riwayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class TagihanPage extends StatefulWidget {
  @override
  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  // bool _rememberMe = false;
  final TextEditingController nopel = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _tombomasuk = false;
  bool _loading = false;
  @override
  void dispose() {
    nopel.dispose();
    super.dispose();
  }

  DateTime currentBackPressTime = DateTime.now();
  onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Tekan kembali sekali lagi untuk keluar.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

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
          'Tagihan Rekening',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: nopel,
                keyboardType: TextInputType.number,
                style: GoogleFonts.openSans(
                  color: Colors.grey,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan no pelanggan anda!';
                  }
                  return null;
                },
                onChanged: (v) {
                  setState(() {
                    if (v != '' && v.length > 5) {
                      _tombomasuk = true;
                    } else {
                      _tombomasuk = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20.0),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: 'Masukkan no pelanggan ',
                  hintStyle: GoogleFonts.openSans(
                    color: Colors.grey,
                  ),
                  labelStyle: GoogleFonts.openSans(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
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
                      backgroundColor:
                          (!_tombomasuk) ? Colors.grey : colorTagihan,
                    ),
                    onPressed: (!_tombomasuk)
                        ? null
                        : () async {
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  Api()
                                      .getListTagihan(nopel: nopel.text.trim())
                                      .then((value) {
                                    if (!value.status) {
                                      Fluttertoast.showToast(
                                        msg: 'Tagihan Tidak Ditemukan!',
                                        backgroundColor: Colors.red,
                                        textColor: whiteColor,
                                      );
                                      setState(() {
                                        _loading = false;
                                      });
                                    } else {
                                      setState(() {
                                        _loading = false;
                                      });
                                      // Navigator.pushNamed(
                                      //     context, '/tagihan-riwayat');
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return TagihanRiwayat(
                                            listTagihan: value.resultTagihan);
                                      }));
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
                                }
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
                      children: [
                        (_loading)
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'TAMPILKAN',
                                style: TextStyle(color: Colors.white),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
