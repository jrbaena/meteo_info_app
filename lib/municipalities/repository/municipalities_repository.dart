import '../model/municipality.dart';

abstract class AllMunicipalitiesRepository {
  Future<List<Municipality>>? fetch();
}