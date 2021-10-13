import 'dart:convert';

JenisPengaduanModel jenisPengaduanModelFromJson(String str) =>
    JenisPengaduanModel.fromJson(json.decode(str));

String jenisPengaduanModelToJson(JenisPengaduanModel data) =>
    json.encode(data.toJson());

class JenisPengaduanModel {
  JenisPengaduanModel({
    required this.status,
    required this.message,
    required this.resultJenisPengaduan,
  });

  bool status;
  String message;
  List<ResultJenisPengaduan> resultJenisPengaduan;

  factory JenisPengaduanModel.fromJson(Map<String, dynamic> json) =>
      JenisPengaduanModel(
        status: json["status"],
        message: json["message"],
        resultJenisPengaduan: List<ResultJenisPengaduan>.from(
            json["result"].map((x) => ResultJenisPengaduan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultJenisPengaduan":
            List<dynamic>.from(resultJenisPengaduan.map((x) => x.toJson())),
      };
}

class ResultJenisPengaduan {
  ResultJenisPengaduan({
    required this.id,
    required this.nama,
  });

  int id;
  String nama;

  factory ResultJenisPengaduan.fromJson(Map<String, dynamic> json) =>
      ResultJenisPengaduan(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}
