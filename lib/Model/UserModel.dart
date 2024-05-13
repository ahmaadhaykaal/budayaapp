// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    bool isSuccess;
    String message;
    List<Datum> data;

    UserModel({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
    String username;
    String email;
    String password;
    String fullname;
    String bp;
    DateTime tglDaftar;

    Datum({
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.fullname,
        required this.bp,
        required this.tglDaftar,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        fullname: json["fullname"],
        bp: json["bp"],
        tglDaftar: DateTime.parse(json["tgl_daftar"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "bp": bp,
        "tgl_daftar": tglDaftar.toIso8601String(),
    };
}
