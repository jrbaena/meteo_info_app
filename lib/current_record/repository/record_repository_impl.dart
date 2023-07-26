import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/record.dart';
import 'record_repository.dart';

class RecordRepositoryImpl extends RecordRepository {
  RecordRepositoryImpl();

  @override
  Future<Record> search(String idema) async {
    //TODO Replace hardcoded api_key to credentials token
    try {
      final response = await http.get(
        Uri.parse(
            "https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/$idema"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'api_key':
              'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJkam9zZWZ1a29AZ21haWwuY29tIiwianRpIjoiZWZjYWNhZmYtY2I5ZS00MTQzLWIzMjktYmMwMzU3ZWI0YTQyIiwiaXNzIjoiQUVNRVQiLCJpYXQiOjE1ODAwNzk2NDAsInVzZXJJZCI6ImVmY2FjYWZmLWNiOWUtNDE0My1iMzI5LWJjMDM1N2ViNGE0MiIsInJvbGUiOiIifQ.GdxYniiPiOFXtVtEcTCXoj5VmNosR0i9VpqxVQzgs4g'
        },
      );

      final dataUrl = jsonDecode(response.body)["datos"];

      final response2 = await http.get(
        Uri.parse(dataUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final currentRecord = Record.fromJson((jsonDecode(response2.body) as List).last);

      return currentRecord;
    } catch (e) {
      rethrow;
    }
  }
}
