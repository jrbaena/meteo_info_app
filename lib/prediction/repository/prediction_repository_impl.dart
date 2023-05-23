import 'dart:convert';

import 'package:meteo_info_app/prediction/model/Prediction.dart';
import 'package:meteo_info_app/prediction/repository/prediction_repository.dart';
import 'package:http/http.dart' as http;

class PredictionRepositoryImpl extends PredictionRepository {
  PredictionRepositoryImpl();

  @override
  Future<Prediction> search(String locationCode) async {
    //TODO Replace hardcoded api_key to credentials token
    final response = await http.get(
      Uri.parse("https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/$locationCode"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'api_key': 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkam9zZWZ1a29AZ21haWwuY29tIiwianRpIjoiZWZjYWNhZmYtY2I5ZS00MTQzLWIzMjktYmMwMzU3ZWI0YTQyIiwiaXNzIjoiQUVNRVQiLCJpYXQiOjE1ODAwNzk2NDAsInVzZXJJZCI6ImVmY2FjYWZmLWNiOWUtNDE0My1iMzI5LWJjMDM1N2ViNGE0MiIsInJvbGUiOiIifQ.GdxYniiPiOFXtVtEcTCXoj5VmNosR0i9VpqxVQzgs4g'
      },
    );

    try {
      final dataUrl = jsonDecode(response.body)["datos"];

      final response2 = await http.get(
        Uri.parse(dataUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return Prediction.fromRawJson(response2.body);
    } catch (e) {
      rethrow;
    }
  }
}
