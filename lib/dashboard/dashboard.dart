import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/prediction_screen.dart';

import '../current_record/repository/record_repository.dart';
import '../current_record/repository/record_repository_impl.dart';
import '../prediction/repository/prediction_repository.dart';
import '../prediction/repository/prediction_repository_impl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO sliverAppBar with others options like warnings, provinces, regions...

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PredictionRepository>(
          create: (context) => PredictionRepositoryImpl(),
        ),
        RepositoryProvider<RecordRepository>(
          create: (context) => RecordRepositoryImpl(),
        ),
      ],
      child: const PredictionScreen(),
    );
  }
}
