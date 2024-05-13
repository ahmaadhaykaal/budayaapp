// To parse this JSON data, do
//
//     final modelBudaya = modelBudayaFromJson(jsonString);

import 'dart:convert';

ModelBudaya modelBudayaFromJson(String str) => ModelBudaya.fromJson(json.decode(str));

String modelBudayaToJson(ModelBudaya data) => json.encode(data.toJson());

class ModelBudaya {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelBudaya({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelBudaya.fromJson(Map<String, dynamic> json) => ModelBudaya(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String judul;
    String isi;
    String gambar;
    DateTime tglMasuk;

    Datum({
        required this.id,
        required this.judul,
        required this.isi,
        required this.gambar,
        required this.tglMasuk,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        judul: json["judul"],
        isi: json["isi"],
        gambar: json["gambar"],
        tglMasuk: DateTime.parse(json["tgl_masuk"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "isi": isi,
        "gambar": gambar,
        "tgl_masuk": tglMasuk.toIso8601String(),
    };
}
