import 'dart:convert';

import 'package:flutter/material.dart';

class Municipalities {
  final List<Municipality> municipalities;

  Municipalities({required this.municipalities});

  factory Municipalities.fromRawJson(String str) =>
      Municipalities.fromJson(json.decode(str));

  factory Municipalities.fromJson(Map<String, dynamic> json) {
    final List<Municipality> municipalities = [];
    json["data"].forEach((element) {
      try {
        municipalities.add(Municipality.fromJson(element));
      } catch (e) {
        debugPrint("[Municipalities] Error $e");
      }
    });
    return Municipalities(municipalities: municipalities);
  }
}

class Municipality {
  final String municipalityCode;
  final String name;
  final String idema;

  Municipality({
    required this.municipalityCode,
    required this.name,
    required this.idema,
  });

  factory Municipality.fromRawJson(String str) =>
      Municipality.fromJson(json.decode(str));

  factory Municipality.fromJson(Map<String, dynamic> json) {
    final municipalityCode = json["code"];
    final name = json["nombre"];
    final idema = json["idema"];

    return Municipality(
        municipalityCode: municipalityCode, name: name, idema: idema);
  }
}
