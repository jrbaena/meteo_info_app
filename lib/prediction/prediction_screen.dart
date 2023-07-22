import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/current_record/repository/record_repository.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'package:meteo_info_app/prediction/prediction_page.dart';
import 'package:meteo_info_app/prediction/repository/prediction_repository.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO Future navigation between screens?
    return Scaffold(
      body: BlocProvider(
        create: (context) => PredictionCubit(
          RepositoryProvider.of<PredictionRepository>(context),
          RepositoryProvider.of<RecordRepository>(context),
        ),
        child: const PredictionPage(),
      ),
    );
  }
}
