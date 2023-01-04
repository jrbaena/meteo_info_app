import 'package:meteo_info_app/prediction/repository/prediction_repository.dart';

import '../model/Prediction.dart';

class SearchPrediction {
  final PredictionRepository predictionRepository;

  SearchPrediction(this.predictionRepository);

  Future<Prediction> execute(String locationCode){
    return predictionRepository.search(locationCode);
  }
}