import 'dart:async';
import 'dart:convert';
import 'package:bsainfo_mobile/models/bacamandiri_model.dart';
import 'package:bsainfo_mobile/models/cekTagihan_model.dart';
import 'package:bsainfo_mobile/models/detail_pelanggan_model.dart';
import 'package:bsainfo_mobile/models/historibacameter_model.dart';
import 'package:bsainfo_mobile/models/jenis_pengaduan_model.dart';
import 'package:bsainfo_mobile/models/login_model.dart';
import 'package:bsainfo_mobile/models/pengaduan_model.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Client client = Client();
  final apiUrl = 'https://api.pudam-bayuangga.id/api';
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

    if (_response.statusCode == 200) {
      return loginModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> doUpdateProfile({
    required String nohp,
    required String nama,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = '$apiUrl/doUpdateProfile';
    final _response = await client.post(Uri.parse(_url), body: {
      "nohp": nohp,
      "nama": nama,
      "nohp_old": '${prefs.getString('nohp')}',
    });

    if (_response.statusCode == 200) {
      return json.decode(_response.body);
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
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> hapusPelanggan({required String id}) async {
    final String _url = '$apiUrl/deletePelanggan/$id';
    final _response = await client.get(Uri.parse(_url));
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<PengaduanModel> getPengaduan({required String nopel}) async {
    final String _url = '$apiUrl/getPengaduan/$nopel';
    final _response = await client.get(Uri.parse(_url));
    if (_response.statusCode == 200) {
      return pengaduanModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<JenisPengaduanModel> getJenisPengaduan() async {
    final String _url = '$apiUrl/getJenisPengaduan';
    final _response = await client.get(Uri.parse(_url));
    if (_response.statusCode == 200) {
      return jenisPengaduanModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<DetailPelangganModel> detailPelanggan({required String nopel}) async {
    final String _url = '$apiUrl/detailPelanggan/$nopel';
    final _response = await client.get(Uri.parse(_url));
    if (_response.statusCode == 200) {
      return detailPelangganModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> savePengaduan({
    required String pelangganId,
    required String nama,
    required String alamat,
    required String noIdentitas,
    required String noTlp,
    required String jenisAduan,
    required String keterangan,
  }) async {
    final String _url = '$apiUrl/savePengaduan';
    final _response = await client.post(Uri.parse(_url), body: {
      "pelanggan_id": pelangganId,
      "nama": nama,
      "alamat": alamat,
      "no_identitas": noIdentitas,
      "no_telp": noTlp,
      "jenis_aduan_id": jenisAduan,
      "keterangan": keterangan,
    });
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> bacaMandiri({
    required String noPelanggan,
    required String stan,
    required String foto,
    required String keterangan,
  }) async {
    final String _url = '$apiUrl/bacaMandiri';
    final _response = await client.post(Uri.parse(_url), body: {
      "no_pelanggan": noPelanggan,
      "stan": stan,
      "foto": foto,
      "memo": keterangan,
    });
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String nohp,
    required String token,
  }) async {
    final String _url = '$apiUrl/resetPassword';
    final _response = await client.post(Uri.parse(_url), body: {
      "nohp": nohp,
      "token": token,
    });
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('${json.decode(_response.body)}');
    }
  }

  Future<BacaMandiriModel> getBacaMandiri({required String nopel}) async {
    final String _url = '$apiUrl/getBacaMandiri/$nopel';
    final _response = await client.get(Uri.parse(_url));
    if (_response.statusCode == 200) {
      return bacaMandiriModelFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<CekTagihan> getListTagihan({required String nopel}) async {
    final String _url = '$apiUrl/cekTagihan/$nopel';
    final _response = await client.get(Uri.parse(_url));
    if (_response.statusCode == 200) {
      return cekTagihanFromJson(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> getConfig() async {
    final response = await client.get(
      Uri.parse("https://api.pudam-bayuangga.id/penagihan/getConfig"),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var tmp = json.decode(response.body);
      throw Exception(tmp['message']);
    }
  }

  Future<HistroriBacameterModel> getHistoriBacameter(
      {required String nopel}) async {
    final response = await client.get(
      Uri.parse("$apiUrl/getHistori/$nopel"),
    );
    if (response.statusCode == 200) {
      return histroriBacameterModelFromJson(response.body);
    } else {
      var tmp = json.decode(response.body);
      throw Exception(tmp['message']);
    }
  }

  Future<Map<String, dynamic>> cekStatusPelanggan(
      {required String nopel}) async {
    final response = await client.get(
      Uri.parse("$apiUrl/cekStatusPelanggan/$nopel"),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var tmp = json.decode(response.body);
      throw Exception(tmp['message']);
    }
  }

  Future<Map<String, dynamic>> getTagihanUserBulanan(
      {required String nopel}) async {
    final String _url = '$apiUrl/cekTagihanUser/$nopel';
    final _response = await client.get(Uri.parse(_url));
    print(_response.body);
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }

  Future<Map<String, dynamic>> generateVABankJatim({
    required String noVA,
    required String tagihan,
    required String batas,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = 'https://jatimva.bankjatim.co.id/Va/RegPen';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({
      "VirtualAccount": noVA,
      "Nama": "${prefs.getString('nama')!} PDAM Probo Testing",
      "TotalTagihan": tagihan,
      "TanggalExp": batas,
      "Berita1": "Pembayaran Rekening PDAM Probolinggo",
      "Berita2": "INFO 2",
      "Berita3": "INFO 3",
      "Berita4": "INFO 4",
      "Berita5": "INFO 5",
      "FlagProses": 1
    });
    final _response = await client.post(
      Uri.parse(_url),
      headers: headers,
      body: msg,
    );
    print(_response.body);
    if (_response.statusCode == 200) {
      return json.decode(_response.body);
    } else {
      throw Exception('Server Error');
    }
  }
}
