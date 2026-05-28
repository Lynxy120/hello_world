// To parse this JSON data, do
//
//     final modelBerita = modelBeritaFromJson(jsonString);

import 'dart:convert';

ModelBerita modelBeritaFromJson(String str) => ModelBerita.fromJson(json.decode(str));

String modelBeritaToJson(ModelBerita data) => json.encode(data.toJson());

class ModelBerita {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBerita({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBerita.fromJson(Map<String, dynamic> json) => ModelBerita(
    isSuccess: json["is_success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judul;
  String isiBerita;
  String gambar;
  DateTime tgl;

  Datum({
    required this.id,
    required this.judul,
    required this.isiBerita,
    required this.gambar,
    required this.tgl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    isiBerita: json["isi_berita"],
    gambar: json["gambar"],
    tgl: DateTime.parse(json["tgl"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "isi_berita": isiBerita,
    "gambar": gambar,
    "tgl": tgl.toIso8601String(),
  };
}
