import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/municipality.dart';

class MunicipalitiesRepositoryImpl {
  static late final List<Municipality>? municipalities;

  Future<void> fetch() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://gist.githubusercontent.com/jrbaena/40a145974fdcc99b264f886c9882e228/raw/99b69a50d96d21c1fb585cc211eb7936455ce6eb/capitals.json",
        queryParameters: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint(response.data);
      for (var element in response.data) {
        try {
          municipalities?.add(Municipality.fromJson(element));
        } catch (e) {
          debugPrint("Failed obtain municipalities from response");
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}