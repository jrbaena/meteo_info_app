part of 'prediction_bloc.dart';

abstract class PredictionEvent {
  const PredictionEvent();
}

class SearchLocation extends PredictionEvent{
  String locationCode;

  SearchLocation(this.locationCode);
}