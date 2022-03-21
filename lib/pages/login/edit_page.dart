import 'dart:io';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/pages/login/ganti_password.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePgae extends StatefulWidget {
  final String nama, noHp;
  EditProfilePgae({required this.nama, required this.noHp});
  @override
  _EditProfilePgaeState createState() => _EditProfilePgaeState();
}

class _EditProfilePgaeState extends State<EditProfilePgae> {
  // bool _rememberMe = false;
  // final TextEditingController password = TextEditingController();
  late TextEditingController namaLengkap;
  late TextEditingController noHp;
  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool passwordShow = false;

  @override
  void initState() {
    namaLengkap = TextEditingController(text: widget.nama);
    noHp = TextEditingController(text: widget.noHp);
    super.initState();
  }

  @override
  void dispose() {
    // password.dispose();
    namaLengkap.dispose();
    noHp.dispose();
    super.dispose();
  }

  Widget _buildnamL() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: namaLengkap,
          keyboardType: TextInputType.text,
          style: GoogleFonts.openSans(
            color: Colors.grey,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Masukkan Nama !';
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20.0),
              prefixIcon: Icon(
                Icons.person_outline_rounded,
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
              hintText: 'Nama anda',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey,
              ),
              labelText: 'Nama anda',
              labelStyle: GoogleFonts.openSans(
                color: Colors.grey,
              )),
        ),
      ],
    );
  }

  Widget _buildNoHp() {
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
              return 'Masukkan no hp!';
            }
            return null;
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
              hintText: 'No Hp',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey,
              ),
              labelText: 'No Hp',
              labelStyle: GoogleFonts.openSans(
                color: Colors.grey,
              )),
        ),
      ],
    );
  }

  // Widget _buildPasswordTF() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       SizedBox(height: 10.0),
  //       TextFormField(
  //         obscureText: !passwordShow,
  //         controller: password,
  //         style: GoogleFonts.openSans(
  //           color: Colors.grey,
  //         ),
  //         validator: (value) {
  //           if (value!.isEmpty) {
  //             return 'Masukkan password anda!';
  //           }
  //           return null;
  //         },
  //         onChanged: (v) {
  //           setState(() {
  //             if (namaLengkap.text != '' && v != '' && noHp.text != '') {
  //               _tombomasuk = true;
  //             } else {
  //               _tombomasuk = false;
  //             }
  //           });
  //         },
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.all(20.0),
  //           prefixIcon: Icon(
  //             Icons.lock,
  //             color: Colors.grey,
  //           ),
  //           labelText: 'Password',
  //           labelStyle: GoogleFonts.openSans(
  //             color: Colors.grey,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //             borderSide: BorderSide(color: Colors.grey),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //             borderSide: BorderSide(color: Colors.blue),
  //           ),
  //           hintText: 'Password',
  //           hintStyle: GoogleFonts.openSans(
  //             color: Colors.grey,
  //           ),
  //           suffixIcon: IconButton(
  //             onPressed: () {
  //               setState(() {
  //                 passwordShow = !passwordShow;
  //               });
  //             },
  //             icon: Icon(
  //                 (!passwordShow) ? Icons.visibility : Icons.visibility_off),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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

                Api()
                    .doUpdateProfile(
                  nohp: noHp.text,
                  nama: namaLengkap.text,
                )
                    .then((value) async {
                  if (value['status']) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    await prefs.setString('nama', namaLengkap.text);
                    await prefs.setString('nohp', noHp.text);
                    Fluttertoast.showToast(
                      msg: 'Berhasil Update User!',
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
                    Fluttertoast.showToast(
                      msg: 'No Hp Sudah Terdaftar!',
                      backgroundColor: Colors.red,
                      toastLength: Toast.LENGTH_LONG,
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
        color: Colors.blueAccent,
        child: Text(
          'UPDATE USER',
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
                    _buildnamL(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildNoHp(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) {
                              return GantiPassPage();
                            }));
                          },
                          child: Text(
                            'Ganti Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
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
