import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/prediction_screen.dart';

import '../prediction/repository/prediction_repository.dart';
import '../prediction/repository/prediction_repository_impl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO sliverAppBar with others options like warnings, provinces, regions...
    return RepositoryProvider<PredictionRepository>(
      create: (context) => PredictionRepositoryImpl(),
      child: const PredictionScreen(),
    );
  }
}
