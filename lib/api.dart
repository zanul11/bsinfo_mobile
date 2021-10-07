import 'dart:async';
import 'package:bsainfo_mobile/models/login_model.dart';
import 'package:http/http.dart';

class Api {
  Client client = Client();
  final apiUrl = 'https://api.garagebit.xyz/api';
  Future<LoginModel> doRegister({
    required String nohp,
    required String nama,
    required String password,
    required String token,
  }) async {
    final String _url = '$apiUrl/doRegister';
    final _response = await client.post(Uri.parse(_url), body: {
      "nohp": nohp,
      "password": password,
      "nama": nama,
      "token": token,
    });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      return loginModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<LoginModel> doLogin({
    required String nohp,
    required String password,
    required String token,
  }) async {
    final String _url = '$apiUrl/doLogin';
    final _response = await client.post(Uri.parse(_url), body: {
      "nohp": nohp,
      "password": password,
      "token": token,
    });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      return loginModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }
}
