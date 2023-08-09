part of 'prediction_cubit.dart';

@immutable
abstract class PredictionState {}

class PredictionLoadedState extends PredictionState {
  final Prediction prediction;
  final String municipalityName;
  final Record currentRecord;

  PredictionLoadedState({
    required this.prediction,
    required this.municipalityName,
    required this.currentRecord,
  });

  PredictionLoadedState copyWithRecord(Record record) {
    return PredictionLoadedState(
      prediction: prediction,
      municipalityName: municipalityName,
      currentRecord: record,
    );
  }
}

class PredictionInitialState extends PredictionState {}

class PredictionLoadingState extends PredictionState {}

class PredictionErrorState extends PredictionState {}
