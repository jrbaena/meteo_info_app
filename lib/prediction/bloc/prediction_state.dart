part of 'prediction_cubit.dart';

@immutable
abstract class PredictionState {}

class PredictionLoadedState extends PredictionState {
  final Prediction prediction;
  final String municipalityName;

  PredictionLoadedState(this.prediction, this.municipalityName);

}

class PredictionInitialState extends PredictionState {}

class PredictionLoadingState extends PredictionState {}

class PredictionErrorState extends PredictionState {}