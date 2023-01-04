import 'dart:convert';

class Prediction {
  String name;

  Prediction(this.name);

  factory Prediction.fromRawJson(String str) =>
      Prediction.fromJson(json.decode(str)[0]);

  factory Prediction.fromJson(Map<String, dynamic> json) {
    final name = json["nombre"];

    return Prediction(name);
  }
}