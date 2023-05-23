import 'dart:convert';

class Municipality {
  final String municipalityCode;
  final String name;

  Municipality({
    required this.municipalityCode,
    required this.name,
  });

  factory Municipality.fromRawJson(String str) =>
      Municipality.fromJson(json.decode(str));

  factory Municipality.fromJson(Map<String, dynamic> json) {
    final municipalityCode = json["municipalityCode"];
    final name = json["nombre"];

    return Municipality(municipalityCode: municipalityCode, name: name);
  }
}
