import '../model/record.dart';

abstract class RecordRepository {
  Future<Record> search(String idema);
}