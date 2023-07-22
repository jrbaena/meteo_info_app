import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meteo_info_app/extensions/string_extension.dart';

import '../../current_record/model/record.dart';
import '../../current_record/repository/record_repository.dart';
import '../../municipalities/repository/municipalities_repository_impl.dart';
import '../model/Prediction.dart';
import '../repository/prediction_repository.dart';

part 'prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  final PredictionRepository _predictionRepository;
  final RecordRepository _recordRepository;

  PredictionCubit(this._predictionRepository, this._recordRepository)
      : super(PredictionInitialState());

  Record? currentWeather;

  void init() async {
    currentWeather = await getCurrentWeather("3195");
    searchLocation("Madrid");
  }

  void searchLocation(String municipalityName) async {
    try {
      emit(PredictionLoadingState());
      final municipalityCode = await _getMunicipalityCode(municipalityName);
      final prediction = await _predictionRepository.search(municipalityCode);
      emit(
        PredictionLoadedState(
          prediction: prediction,
          municipalityName: municipalityName,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(PredictionErrorState());
    }
  }

  Future<String> _getMunicipalityCode(String municipalityName) async {
    final municipalities = MunicipalitiesRepositoryImpl.municipalities;
    try {
      return municipalities!
          .firstWhere((element) =>
              element.name.replaceSpecialCharacters().toLowerCase() ==
              municipalityName.trim().replaceSpecialCharacters().toLowerCase())
          .municipalityCode;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> backToForm() async {
    emit(PredictionLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(PredictionInitialState());
  }

  Future<Record> getCurrentWeather(String idema) async {
    try {
      final currentRecord = await _recordRepository.search(idema);
      return currentRecord;
    } catch (e) {
      rethrow;
    }
  }
}
