import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/municipality.dart';

class MunicipalitiesRepositoryImpl {
  static late final List<Municipality>? municipalities;

  Future<void> fetch() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://gist.githubusercontent.com/jrbaena/7466c60f362d518a8addf4df72b2b713/raw/f41a986c70173853b547d1efcf963c8afd0ee54e/municipalities.json",
        queryParameters: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
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