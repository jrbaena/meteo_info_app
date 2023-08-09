import 'dart:convert';

class Records {
  final List<Record> records;

  Records(this.records);

  factory Records.fromRawJson(String str) => Records.fromJson(json.decode(str));

  factory Records.fromJson(Map<String, dynamic> json) {
    List<Record> records = [];
    json[""].forEach((e) {
      try {
        records.add(Record.fromJson(e));
      } catch (e) {
        rethrow;
      }
    });

    return Records(records);
  }
}

class Record {
  final double hr;
  final double temperature;
  final double latitude;
  final double longitude;

  Record(
      {required this.hr,
      required this.temperature,
      required this.latitude,
      required this.longitude});

  factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      hr: json["hr"],
      temperature: json["ta"],
      latitude: json["lat"],
      longitude: json["lon"],
    );
  }
}
