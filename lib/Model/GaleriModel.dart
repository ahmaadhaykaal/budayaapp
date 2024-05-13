// To parse this JSON data, do
//
//     final modelGaleri = modelGaleriFromJson(jsonString);

import 'dart:convert';

ModelGaleri modelGaleriFromJson(String str) => ModelGaleri.fromJson(json.decode(str));

String modelGaleriToJson(ModelGaleri data) => json.encode(data.toJson());

class ModelGaleri {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelGaleri({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelGaleri.fromJson(Map<String, dynamic> json) => ModelGaleri(
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
    String foto;

    Datum({
        required this.id,
        required this.foto,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "foto": foto,
    };
}
