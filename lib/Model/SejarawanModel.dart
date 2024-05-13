// To parse this JSON data, do
//
//     final sejarawanModel = sejarawanModelFromJson(jsonString);

import 'dart:convert';

SejarawanModel sejarawanModelFromJson(String str) => SejarawanModel.fromJson(json.decode(str));

String sejarawanModelToJson(SejarawanModel data) => json.encode(data.toJson());

class SejarawanModel {
    bool isSuccess;
    String message;
    List<Datum> data;

    SejarawanModel({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory SejarawanModel.fromJson(Map<String, dynamic> json) => SejarawanModel(
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
    String nama;
    DateTime tglLahir;
    String asal;
    String jk;
    String deskripsi;
    String foto;

    Datum({
        required this.id,
        required this.nama,
        required this.tglLahir,
        required this.asal,
        required this.jk,
        required this.deskripsi,
        required this.foto,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        tglLahir: DateTime.parse(json["tgl_lahir"]),
        asal: json["asal"],
        jk: json["jk"],
        deskripsi: json["deskripsi"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "tgl_lahir": "${tglLahir.year.toString().padLeft(4, '0')}-${tglLahir.month.toString().padLeft(2, '0')}-${tglLahir.day.toString().padLeft(2, '0')}",
        "asal": asal,
        "jk": jk,
        "deskripsi": deskripsi,
        "foto": foto,
    };
}
