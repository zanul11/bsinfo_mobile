import 'dart:convert';

HistroriBacameterModel histroriBacameterModelFromJson(String str) =>
    HistroriBacameterModel.fromJson(json.decode(str));

String histroriBacameterModelToJson(HistroriBacameterModel data) =>
    json.encode(data.toJson());

class HistroriBacameterModel {
  HistroriBacameterModel({
    required this.status,
    required this.message,
    required this.resultHistori,
  });

  bool status;
  String message;
  ResultHistori resultHistori;

  factory HistroriBacameterModel.fromJson(Map<String, dynamic> json) =>
      HistroriBacameterModel(
        status: json["status"],
        message: json["message"],
        resultHistori: ResultHistori.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultHistori": resultHistori.toJson(),
      };
}

class ResultHistori {
  ResultHistori({
    required this.id,
    required this.pelangganId,
    required this.periodeBaca,
    required this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.golonganId,
    required this.stanIni,
    required this.stanLalu,
    required this.pemakaian,
    required this.kelainan,
    required this.pakai1BlnLalu,
    required this.pakai2BlnLalu,
    required this.pakai3BlnLalu,
  });

  dynamic id;
  dynamic pelangganId;
  dynamic periodeBaca;
  dynamic noPelanggan;
  dynamic nama;
  dynamic alamat;
  dynamic golonganId;
  dynamic stanIni;
  dynamic stanLalu;
  dynamic pemakaian;
  dynamic kelainan;
  dynamic pakai1BlnLalu;
  dynamic pakai2BlnLalu;
  dynamic pakai3BlnLalu;

  factory ResultHistori.fromJson(Map<String, dynamic> json) => ResultHistori(
        id: json["id"],
        pelangganId: json["pelanggan_id"],
        periodeBaca: json["periode_baca"],
        noPelanggan: json["no_pelanggan"],
        nama: json["nama"],
        alamat: json["alamat"],
        golonganId: json["golongan_id"],
        stanIni: json["stan_ini"],
        stanLalu: json["stan_lalu"],
        pemakaian: json["pemakaian"],
        kelainan: json["kelainan"],
        pakai1BlnLalu: json["pakai_1bln_lalu"],
        pakai2BlnLalu: json["pakai_2bln_lalu"],
        pakai3BlnLalu: json["pakai_3bln_lalu"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pelanggan_id": pelangganId,
        "periode_baca": periodeBaca,
        "no_pelanggan": noPelanggan,
        "nama": nama,
        "alamat": alamat,
        "golongan_id": golonganId,
        "stan_ini": stanIni,
        "stan_lalu": stanLalu,
        "pemakaian": pemakaian,
        "kelainan": kelainan,
        "pakai_1bln_lalu": pakai1BlnLalu,
        "pakai_2bln_lalu": pakai2BlnLalu,
        "pakai_3bln_lalu": pakai3BlnLalu,
      };
}
