import 'dart:convert';

DetailPelangganModel detailPelangganModelFromJson(String str) =>
    DetailPelangganModel.fromJson(json.decode(str));

String detailPelangganModelToJson(DetailPelangganModel data) =>
    json.encode(data.toJson());

class DetailPelangganModel {
  DetailPelangganModel({
    required this.status,
    required this.message,
    required this.resultDetailPelanggan,
  });

  bool status;
  String message;
  List<ResultDetailPelanggan> resultDetailPelanggan;

  factory DetailPelangganModel.fromJson(Map<String, dynamic> json) =>
      DetailPelangganModel(
        status: json["status"],
        message: json["message"],
        resultDetailPelanggan: List<ResultDetailPelanggan>.from(
            json["result"].map((x) => ResultDetailPelanggan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultDetailPelanggan":
            List<dynamic>.from(resultDetailPelanggan.map((x) => x.toJson())),
      };
}

class ResultDetailPelanggan {
  ResultDetailPelanggan({
    required this.nama,
    required this.alamat,
    required this.merekMeter,
    required this.kodeGolongan,
  });

  dynamic nama;
  dynamic alamat;
  dynamic merekMeter;
  dynamic kodeGolongan;

  factory ResultDetailPelanggan.fromJson(Map<String, dynamic> json) =>
      ResultDetailPelanggan(
        nama: json["nama"],
        alamat: json["alamat"],
        merekMeter: json["merek_meter"],
        kodeGolongan: json["kode_golongan"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "alamat": alamat,
        "merek_meter": merekMeter,
        "kode_golongan": kodeGolongan,
      };
}
