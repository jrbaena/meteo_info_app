import 'dart:convert';

import 'package:flutter/material.dart';

class Prediction {
  final List<Day> days;

  Prediction({required this.days});

  factory Prediction.fromRawJson(String str) =>
      Prediction.fromJson(json.decode(str)[0]);

  factory Prediction.fromJson(Map<String, dynamic> json) {
    List<Day> days = [];

    json["prediccion"]["dia"].forEach((element) {
      try {
        days.add(Day.fromJson(element));
      } catch (e) {
        debugPrint("[Day] Error $e");
      }
    });

    return Prediction(days: days);
  }
}

class Day {
  final SkyState skyState;
  final Temperature temperature;

  Day({required this.skyState, required this.temperature});

  factory Day.fromRawJson(String str) => Day.fromJson(json.decode(str));

  factory Day.fromJson(Map<String, dynamic> json) {
    final skyState = SkyState.fromJson(json["estadoCielo"][0]);
    final temperature = Temperature.fromJson(json["temperatura"]);

    return Day(skyState: skyState, temperature: temperature);
  }
}

class SkyState {
  final String description;

  SkyState({required this.description});

  factory SkyState.fromRawJson(String str) =>
      SkyState.fromJson(json.decode(str));

  factory SkyState.fromJson(Map<String, dynamic> json) {
    final description = json["descripcion"];

    return SkyState(description: description);
  }
}

class Temperature {
  final int tMax;
  final int tMin;

  Temperature({required this.tMax, required this.tMin});

  factory Temperature.fromRawJson(String str) =>
      Temperature.fromJson(json.decode(str));

  factory Temperature.fromJson(Map<String, dynamic> json) {
    final tMax = json["maxima"];
    final tMin = json["minima"];

    return Temperature(tMax: tMax, tMin: tMin);
  }
}
