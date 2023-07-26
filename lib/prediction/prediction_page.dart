import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/extensions/days_extension.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'widgets/current_record_widget.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PredictionCubit predictionCubit = BlocProvider.of(context);

    predictionCubit.init();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocBuilder<PredictionCubit, PredictionState>(
        bloc: predictionCubit,
        builder: (context, state) {
          if (state is PredictionErrorState) {
            return const Center(
              child: Text(
                "El nombre de la capital no se encuentra en el servicio o es incorrecto",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (state is PredictionLoadedState) {
            final todayPrediction = state.prediction.days.first;
            List<Widget> days = state.prediction.days.getWidgetDays();

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFFC782FC).withOpacity(0.8),
                      const Color(0xFF3366FF).withOpacity(0.8),
                    ],
                    begin: const FractionalOffset(0.5, 0.5),
                    end: const FractionalOffset(0.5, 1.0),
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        CurrentRecordWidget(
                          todayPrediction: todayPrediction,
                          prediction: state.prediction,
                          currentRecord: state.currentRecord,
                          municipalityName: state.municipalityName,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: ListView(shrinkWrap: true, children: days)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
