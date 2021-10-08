import 'dart:async';
import 'dart:convert';
import 'package:bsainfo_mobile/models/login_model.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<UserPelangganModel> getuserPelanggan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = '$apiUrl/getPelanggan/${prefs.getString('nohp')}';
    final _response = await client.get(Uri.parse(_url));
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      return userPelangganModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> addPelanggan({required String nopel}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = '$apiUrl/addPelanggan';
    final _response = await client.post(Uri.parse(_url), body: {
      "nohp": prefs.getString('nohp'),
      "no_pelanggan": nopel,
    });
    print(_response.body);
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> hapusPelanggan({required String id}) async {
    final String _url = '$apiUrl/deletePelanggan/$id';
    final _response = await client.get(Uri.parse(_url));
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }
}
