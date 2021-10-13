import 'dart:convert';

PengaduanModel pengaduanModelFromJson(String str) =>
    PengaduanModel.fromJson(json.decode(str));

String pengaduanModelToJson(PengaduanModel data) => json.encode(data.toJson());

class PengaduanModel {
  PengaduanModel({
    required this.status,
    required this.message,
    required this.resultPengaduan,
  });

  bool status;
  String message;
  List<ResultPengaduan> resultPengaduan;

  factory PengaduanModel.fromJson(Map<String, dynamic> json) => PengaduanModel(
        status: json["status"],
        message: json["message"],
        resultPengaduan: List<ResultPengaduan>.from(
            json["result"].map((x) => ResultPengaduan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultPengaduan":
            List<dynamic>.from(resultPengaduan.map((x) => x.toJson())),
      };
}

class ResultPengaduan {
  ResultPengaduan({
    required this.id,
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.noIdentitas,
    required this.noTelp,
    required this.isProcessed,
    required this.namaPetugas,
    required this.processedAt,
    required this.isComplete,
    required this.completedAt,
    required this.createdAt,
    required this.keterangan,
    required this.tglTarget,
    required this.jenis,
  });

  int id;
  String nomor;
  String nama;
  String alamat;
  String noIdentitas;
  String noTelp;
  int isProcessed;
  dynamic namaPetugas;
  dynamic processedAt;
  int isComplete;
  dynamic completedAt;
  DateTime createdAt;
  String keterangan;
  dynamic tglTarget;
  List<Jeni> jenis;

  factory ResultPengaduan.fromJson(Map<String, dynamic> json) =>
      ResultPengaduan(
        id: json["id"],
        nomor: json["nomor"],
        nama: json["nama"],
        alamat: json["alamat"],
        noIdentitas: json["no_identitas"],
        noTelp: json["no_telp"],
        isProcessed: json["is_processed"],
        namaPetugas: json["nama_petugas"],
        processedAt: json["processed_at"],
        isComplete: json["is_complete"],
        completedAt: json["completed_at"],
        createdAt: DateTime.parse(json["created_at"]),
        keterangan: json["keterangan"],
        tglTarget: json["tgl_target"],
        jenis: List<Jeni>.from(json["jenis"].map((x) => Jeni.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor": nomor,
        "nama": nama,
        "alamat": alamat,
        "no_identitas": noIdentitas,
        "no_telp": noTelp,
        "is_processed": isProcessed,
        "nama_petugas": namaPetugas,
        "processed_at": processedAt,
        "is_complete": isComplete,
        "completed_at": completedAt,
        "created_at": createdAt.toIso8601String(),
        "keterangan": keterangan,
        "tgl_target": tglTarget,
        "jenis": List<dynamic>.from(jenis.map((x) => x.toJson())),
      };
}

class Jeni {
  Jeni({
    required this.id,
    required this.nama,
  });

  int id;
  String nama;

  factory Jeni.fromJson(Map<String, dynamic> json) => Jeni(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}
