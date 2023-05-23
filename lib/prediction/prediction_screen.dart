import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'package:meteo_info_app/prediction/prediction_page.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predicción"),
      ),
      body: BlocProvider(
        create: (context) => PredictionCubit(
          RepositoryProvider.of(context),
        ),
        child: const PredictionPage(),
      ),
    );
  }
}
