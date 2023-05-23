part of 'prediction_cubit.dart';

@immutable
abstract class PredictionState {}

class PredictionLoadedState extends PredictionState {
  final Prediction prediction;

  PredictionLoadedState(this.prediction);

}

class PredictionInitialState extends PredictionState {}

class PredictionLoadingState extends PredictionState {}

class PredictionErrorState extends PredictionState {}