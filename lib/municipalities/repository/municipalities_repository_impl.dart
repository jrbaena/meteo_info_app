import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/municipality.dart';

class MunicipalitiesRepositoryImpl {
  static List<Municipality>? municipalities;

  Future<List<Municipality>> fetch() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://gist.githubusercontent.com/jrbaena/40a145974fdcc99b264f886c9882e228/raw/1082f7167cbe830f2cdfe6b3e512c423003cb33a/capitals.json",
        queryParameters: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      try {
        return
            (Municipalities.fromRawJson(response.data)).municipalities;
      } catch (e) {
        debugPrint("[Municipalities Repository] Error $e");
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }
}