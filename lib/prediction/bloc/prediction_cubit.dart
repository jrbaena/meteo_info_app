import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../model/Prediction.dart';
import '../repository/prediction_repository.dart';

part 'prediction_state.dart';

part 'prediction_event.dart';

class PredictionCubit extends Bloc<PredictionEvent, PredictionState> {
  final PredictionRepository _predictionRepository;

  PredictionBloc(this._predictionRepository) : super(PredictionInitialState()) {
    on<SearchLocation>((event, emit) => _searchLocation(event, emit));
  }

  void _searchLocation(
      SearchLocation event, Emitter<PredictionState> emit) async {
    try {
      final prediction = await _predictionRepository.search(event.locationCode);
      emit(PredictionLoadedState(prediction));
    } catch (e) {
      print(e);
    }
  }
}
