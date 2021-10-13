import 'dart:io';

import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KoneksiInternet {
  Future<bool> koneksi() async {
    bool hasil = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasil = true;
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg: 'Tidak ada koneksi internet!',
        backgroundColor: Colors.red,
        textColor: whiteColor,
      );
    }
    return hasil;
  }
}
