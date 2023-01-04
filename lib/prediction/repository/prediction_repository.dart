import '../model/Prediction.dart';

abstract class PredictionRepository {
  Future<Prediction> search(String locationCode);
}