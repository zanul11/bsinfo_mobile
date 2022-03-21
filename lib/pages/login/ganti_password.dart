import 'dart:io';
import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class GantiPassPage extends StatefulWidget {
  @override
  _GantiPassPageState createState() => _GantiPassPageState();
}

class _GantiPassPageState extends State<GantiPassPage> {
  // bool _rememberMe = false;
  // final TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _tombomasuk = false;
  bool passwordShow1 = false;
  bool passwordShow2 = false;
  bool passwordShow3 = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // password.dispose();
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 2.0,
        onPressed: (!_tombomasuk)
            ? null
            : () async {
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    if (formKey.currentState!.validate()) {
                      if (newPassword.text != confirmPassword.text) {
                        Fluttertoast.showToast(
                          msg:
                              'Password Baru Anda Tidak Sama dengan Password Konfirmasi!',
                          backgroundColor: Colors.red,
                          textColor: whiteColor,
                        );
                      } else {
                        setState(() {
                          _loading = true;
                        });
                        Api()
                            .gantiPassword(
                                oldPass: oldPassword.text,
                                newPass: newPassword.text)
                            .then((value) {
                          if (!value['status']) {
                            setState(() {
                              _loading = false;
                            });
                            Fluttertoast.showToast(
                              msg: value['message'].toString(),
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: whiteColor,
                            );
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'Berhasil Ganti Password!',
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_LONG,
                              textColor: whiteColor,
                            );
                          }
                        });
                      }
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
        padding: EdgeInsets.all(15.0),
        color: (_tombomasuk) ? Colors.blueAccent : Colors.grey[350],
        child: Text(
          'GANTI PASSWORD',
          style: GoogleFonts.openSans(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
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

  Widget _buildOld() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        TextFormField(
          obscureText: !passwordShow1,
          controller: oldPassword,
          style: GoogleFonts.openSans(
            color: Colors.grey,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan password lama anda!';
            }
            return null;
          },
          onChanged: (v) {
            setState(() {
              if (newPassword.text != '' &&
                  v != '' &&
                  confirmPassword.text != '') {
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
              Icons.lock,
              color: Colors.grey,
            ),
            labelText: 'Password',
            labelStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Password',
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordShow1 = !passwordShow1;
                });
              },
              icon: Icon(
                  (!passwordShow1) ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNew() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        TextFormField(
          obscureText: !passwordShow2,
          controller: newPassword,
          style: GoogleFonts.openSans(
            color: Colors.grey,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan password baru anda!';
            }
            return null;
          },
          onChanged: (v) {
            setState(() {
              if (oldPassword.text != '' &&
                  v != '' &&
                  confirmPassword.text != '') {
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
              Icons.lock,
              color: Colors.grey,
            ),
            labelText: 'Password Baru',
            labelStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Password Baru',
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordShow2 = !passwordShow2;
                });
              },
              icon: Icon(
                  (!passwordShow2) ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        TextFormField(
          obscureText: !passwordShow3,
          controller: confirmPassword,
          style: GoogleFonts.openSans(
            color: Colors.grey,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan konfirmasi password anda!';
            }
            return null;
          },
          onChanged: (v) {
            setState(() {
              if (newPassword.text != '' && v != '' && oldPassword.text != '') {
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
              Icons.lock,
              color: Colors.grey,
            ),
            labelText: 'Konfirmasi Password',
            labelStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Konfirmasi Password',
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordShow3 = !passwordShow3;
                });
              },
              icon: Icon(
                  (!passwordShow3) ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorTagihan,
        title: Text('Form Edit User'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Image.asset(
                      "assets/bsinfo.png",
                      height: 100,
                    ),
                    SizedBox(height: 20.0),
                    _buildOld(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildNew(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildConfirm(),
                    SizedBox(
                      height: 10.0,
                    ),

                    // _buildPasswordTF(),
                    (_loading)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(),
                    _buildLoginBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
