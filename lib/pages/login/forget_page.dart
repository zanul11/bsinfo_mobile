import 'dart:io';

import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  // bool _rememberMe = false;

  final TextEditingController noHp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _tombomasuk = false;
  bool passwordShow = false;
  @override
  void dispose() {
    noHp.dispose();
    super.dispose();
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
                      setState(() {
                        _loading = true;
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
          'RESET PASSWORD',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorTagihan,
        title: Text('Form Lupa Password'),
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
                    _buildNoHp(),
                    SizedBox(
                      height: 10.0,
                    ),
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
