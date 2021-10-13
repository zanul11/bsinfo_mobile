import 'dart:io';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // bool _rememberMe = false;
  final TextEditingController noHp = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _tombomasuk = false;
  bool passwordShow = false;
  @override
  void dispose() {
    noHp.dispose();
    password.dispose();
    super.dispose();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: noHp,
          keyboardType: TextInputType.number,
          style: GoogleFonts.openSans(
            color: Colors.grey,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan no hp anda!';
            }
            return null;
          },
          onChanged: (v) {
            setState(() {
              if (password.text != '' && v != '') {
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
                Icons.phone_android,
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
              hintText: 'Masukkan no hp ',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey,
              ),
              labelStyle: GoogleFonts.openSans(
                color: Colors.black,
              )),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        TextFormField(
          obscureText: !passwordShow,
          controller: password,
          style: GoogleFonts.openSans(
            color: Colors.grey,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan password anda!';
            }
            return null;
          },
          onChanged: (v) {
            setState(() {
              if (noHp.text != '' && v != '') {
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Masukkan password ',
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordShow = !passwordShow;
                });
              },
              icon: Icon(
                  (!passwordShow) ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 2.0,
        onPressed: () async {
          try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              if (formKey.currentState!.validate()) {
                setState(() {
                  _loading = true;
                });
                FirebaseMessaging.instance.getToken().then((token) {
                  Api()
                      .doLogin(
                          nohp: noHp.text,
                          password: password.text,
                          token: token.toString())
                      .then((value) async {
                    if (value.status) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      await prefs.setString('nama', value.result.nama);
                      await prefs.setString('nohp', value.result.noHp);
                      Fluttertoast.showToast(
                        msg: 'Berhasil Login!',
                        backgroundColor: Colors.green,
                        toastLength: Toast.LENGTH_LONG,
                        textColor: whiteColor,
                      );
                      setState(() {
                        _loading = false;
                      });
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    } else {
                      if (value.message == 'belum daftar') {
                        Fluttertoast.showToast(
                          msg: 'No Hp Belum Terdaftar!',
                          backgroundColor: Colors.red,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: whiteColor,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Password Salah!',
                          backgroundColor: Colors.red,
                          toastLength: Toast.LENGTH_LONG,
                          textColor: whiteColor,
                        );
                      }
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
        padding: EdgeInsets.all(15.0),
        color: (_tombomasuk) ? Colors.blueAccent : Colors.grey[350],
        child: Text(
          'MASUK',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                              height: (MediaQuery.of(context).size.height / 7)),
                          Image.asset(
                            "assets/bsinfo.png",
                            height: 100,
                          ),
                          SizedBox(height: 20.0),
                          _buildEmailTF(),
                          SizedBox(
                            height: 10.0,
                          ),
                          _buildPasswordTF(),
                          (_loading)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(),
                          _buildLoginBtn(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Kembali ke halaman'),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/home", (route) => false);
                                },
                                child: Text(
                                  ' Utama',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(15),
                height: 75,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun?'),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        ' Daftar Sekarang',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
