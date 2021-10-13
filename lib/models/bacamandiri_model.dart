import 'dart:convert';

BacaMandiriModel bacaMandiriModelFromJson(String str) =>
    BacaMandiriModel.fromJson(json.decode(str));

String bacaMandiriModelToJson(BacaMandiriModel data) =>
    json.encode(data.toJson());

class BacaMandiriModel {
  BacaMandiriModel({
    required this.status,
    required this.message,
    required this.resultBacaMandiri,
  });

  bool status;
  String message;
  List<ResultBacaMandiri> resultBacaMandiri;

  factory BacaMandiriModel.fromJson(Map<String, dynamic> json) =>
      BacaMandiriModel(
        status: json["status"],
        message: json["message"],
        resultBacaMandiri: List<ResultBacaMandiri>.from(
            json["result"].map((x) => ResultBacaMandiri.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultBacaMandiri":
            List<dynamic>.from(resultBacaMandiri.map((x) => x.toJson())),
      };
}

class ResultBacaMandiri {
  ResultBacaMandiri({
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
    required this.tglBaca,
    required this.pakai1BlnLalu,
    required this.pakai2BlnLalu,
    required this.pakai3BlnLalu,
    required this.foto1,
    required this.estimasi,
    required this.memo,
    required this.createdAt,
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
  dynamic foto1;
  dynamic estimasi;
  dynamic memo;
  DateTime createdAt;
  DateTime tglBaca;

  factory ResultBacaMandiri.fromJson(Map<String, dynamic> json) =>
      ResultBacaMandiri(
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
        foto1: json["foto1"],
        estimasi: json["estimasi"],
        memo: json["memo"],
        createdAt: DateTime.parse(json["created_at"]),
        tglBaca: DateTime.parse(json["tgl_baca"]),
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
        "foto1": foto1,
        "estimasi": estimasi,
        "memo": memo,
        "created_at": createdAt.toIso8601String(),
        "tgl_baca": tglBaca.toIso8601String(),
      };
}
