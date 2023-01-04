import 'package:get_it/get_it.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_bloc.dart';
import 'package:meteo_info_app/prediction/repository/prediction_repository.dart';
import 'package:meteo_info_app/prediction/repository/prediction_repository_impl.dart';
import 'package:meteo_info_app/prediction/use_cases/search_prediction.dart';

class Injector {
  static void init() {
    GetIt getIt = GetIt.I;

    // Repositories
    getIt.registerSingleton<PredictionRepository>(PredictionRepositoryImpl());

    // Use cases
    getIt.registerFactory(() => SearchPrediction(getIt()));

    // Blocs
    getIt.registerFactory(() => PredictionBloc(getIt()));
  }

  static T resolve<T extends Object>() {
    return GetIt.I.get<T>();
  }
}