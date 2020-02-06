// To parse this JSON data, do
//
//     final casaModel = casaModelFromJson(jsonString);

import 'dart:convert';

CasaModel casaModelFromJson(String str) => CasaModel.fromJson(json.decode(str));

String casaModelToJson(CasaModel data) => json.encode(data.toJson());

class CasaModel {
    String id;
    int tipo;
    int cuartos;
    double baos;
    double metros;
    String descripcion;
    String colonia;
    double renta;
    bool disponible;
    List<String> fotos;

    CasaModel({
        this.id,
        this.tipo = 1,
        this.cuartos = 0,
        this.baos = 0.0,
        this.metros = 0.0,
        this.descripcion = "",
        this.colonia ="",
        this.renta = 0.0,
        this.disponible =true,
        this.fotos,
    });

    factory CasaModel.fromJson(Map<String, dynamic> json) => CasaModel(
        id: json["id"],
        tipo: json["tipo"],
        cuartos: json["cuartos"],
        baos: json["baños"],
        metros: json["metros"],
        descripcion: json["descripcion"],
        colonia: json["colonia"],
        renta: json["renta"],
        disponible: json["disponible"],
        fotos: List<String>.from(json["fotos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "cuartos": cuartos,
        "baños": baos,
        "metros": metros,
        "descripcion": descripcion,
        "colonia": colonia,
        "renta": renta,
        "disponible": disponible,
        "fotos": List<dynamic>.from(fotos.map((x) => x)),
    };
}