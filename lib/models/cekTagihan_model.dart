import 'dart:convert';

CekTagihan cekTagihanFromJson(String str) =>
    CekTagihan.fromJson(json.decode(str));

String cekTagihanToJson(CekTagihan data) => json.encode(data.toJson());

class CekTagihan {
  CekTagihan({
    required this.status,
    required this.message,
    required this.resultTagihan,
  });

  bool status;
  String message;
  List<ResultTagihan> resultTagihan;

  factory CekTagihan.fromJson(Map<String, dynamic> json) => CekTagihan(
        status: json["status"],
        message: json["message"],
        resultTagihan: List<ResultTagihan>.from(
            json["result"].map((x) => ResultTagihan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultTagihan":
            List<dynamic>.from(resultTagihan.map((x) => x.toJson())),
      };
}

class ResultTagihan {
  ResultTagihan({
    required this.tagihan,
    required this.denda,
  });

  Tagihan tagihan;
  dynamic denda;

  factory ResultTagihan.fromJson(Map<String, dynamic> json) => ResultTagihan(
        tagihan: Tagihan.fromJson(json["tagihan"]),
        denda: json["denda"],
      );

  Map<String, dynamic> toJson() => {
        "tagihan": tagihan.toJson(),
        "denda": denda,
      };
}

class Tagihan {
  Tagihan({
    required this.id,
    required this.bacameterId,
    required this.periode,
    required this.stanIni,
    required this.stanLalu,
    required this.pemakaian,
    required this.byPemeliharaan,
    required this.byRetribusi,
    required this.byAdministrasi,
    required this.byLingkungan,
    required this.byMaterai,
    required this.byLainnya,
    required this.hargaAir,
    required this.byAngsuran,
    required this.userId,
    required this.tglBayar,
    required this.isPaid,
    required this.bacameter,
  });

  dynamic id;
  dynamic bacameterId;
  dynamic periode;
  dynamic stanIni;
  dynamic stanLalu;
  dynamic pemakaian;
  dynamic byPemeliharaan;
  dynamic byRetribusi;
  dynamic byAdministrasi;
  dynamic byLingkungan;
  dynamic byMaterai;
  dynamic byLainnya;
  dynamic hargaAir;
  dynamic byAngsuran;
  dynamic userId;
  dynamic tglBayar;
  dynamic isPaid;
  Bacameter bacameter;

  factory Tagihan.fromJson(Map<String, dynamic> json) => Tagihan(
        id: json["id"],
        bacameterId: json["bacameter_id"],
        periode: json["periode"],
        stanIni: json["stan_ini"],
        stanLalu: json["stan_lalu"],
        pemakaian: json["pemakaian"],
        byPemeliharaan: json["by_pemeliharaan"],
        byRetribusi: json["by_retribusi"],
        byAdministrasi: json["by_administrasi"],
        byLingkungan: json["by_lingkungan"],
        byMaterai: json["by_materai"],
        byLainnya: json["by_lainnya"],
        hargaAir: json["harga_air"],
        byAngsuran: json["by_angsuran"],
        userId: json["user_id"],
        tglBayar: json["tgl_bayar"],
        isPaid: json["is_paid"],
        bacameter: Bacameter.fromJson(json["bacameter"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bacameter_id": bacameterId,
        "periode": periode,
        "stan_ini": stanIni,
        "stan_lalu": stanLalu,
        "pemakaian": pemakaian,
        "by_pemeliharaan": byPemeliharaan,
        "by_retribusi": byRetribusi,
        "by_administrasi": byAdministrasi,
        "by_lingkungan": byLingkungan,
        "by_materai": byMaterai,
        "by_lainnya": byLainnya,
        "harga_air": hargaAir,
        "by_angsuran": byAngsuran,
        "user_id": userId,
        "tgl_bayar": tglBayar,
        "is_paid": isPaid,
        "bacameter": bacameter.toJson(),
      };
}

class Bacameter {
  Bacameter({
    required this.id,
    required this.pelangganId,
    required this.kelainan,
    required this.foto1,
  });

  dynamic id;
  dynamic pelangganId;
  dynamic kelainan;
  dynamic foto1;

  factory Bacameter.fromJson(Map<String, dynamic> json) => Bacameter(
        id: json["id"],
        pelangganId: json["pelanggan_id"],
        kelainan: json["kelainan"],
        foto1: json["foto1"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pelanggan_id": pelangganId,
        "kelainan": kelainan,
        "foto1": foto1,
      };
}
