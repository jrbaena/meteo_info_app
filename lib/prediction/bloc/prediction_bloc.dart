import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../model/Prediction.dart';
import '../use_cases/search_prediction.dart';

part 'prediction_state.dart';

part 'prediction_event.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  final SearchPrediction _searchPrediction;

  PredictionBloc(this._searchPrediction) : super(PredictionInitialState()) {
    on<SearchLocation>((event, emit) => _searchLocation(event, emit));
  }

  void _searchLocation(
      SearchLocation event, Emitter<PredictionState> emit) async {
    final prediction = await _searchPrediction.execute(event.locationCode);
    emit(PredictionLoadedState(prediction));
  }
}
