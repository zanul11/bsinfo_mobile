import 'dart:convert';

UserPelangganModel userPelangganModelFromJson(String str) =>
    UserPelangganModel.fromJson(json.decode(str));

String userPelangganModelToJson(UserPelangganModel data) =>
    json.encode(data.toJson());

class UserPelangganModel {
  UserPelangganModel({
    required this.status,
    required this.message,
    required this.result,
  });

  bool status;
  String message;
  List<Result> result;

  factory UserPelangganModel.fromJson(Map<String, dynamic> json) =>
      UserPelangganModel(
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.noHp,
    required this.noPelanggan,
    required this.pelangganDetail,
  });

  int id;
  String noHp;
  String noPelanggan;
  PelangganDetail pelangganDetail;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        noHp: json["no_hp"],
        noPelanggan: json["no_pelanggan"],
        pelangganDetail: PelangganDetail.fromJson(json["pelanggan_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_hp": noHp,
        "no_pelanggan": noPelanggan,
        "pelanggan_detail": pelangganDetail.toJson(),
      };
}

class PelangganDetail {
  PelangganDetail({
    required this.id,
    required this.status,
    required this.noPelanggan,
    required this.nama,
  });

  dynamic id;
  dynamic status;
  dynamic noPelanggan;
  dynamic nama;

  factory PelangganDetail.fromJson(Map<String, dynamic> json) =>
      PelangganDetail(
        id: json["id"],
        status: json["status"],
        noPelanggan: json["no_pelanggan"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "no_pelanggan": noPelanggan,
        "nama": nama,
      };
}
