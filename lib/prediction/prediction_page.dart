import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:meteo_info_app/extensions/string_extension.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'package:meteo_info_app/prediction/model/Prediction.dart';

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
            //TODO date format, avoid empty fields, convert to cards with standard size and style...
            final todayPrediction = state.prediction.days.first;
            List<Widget> days = _getWidgetDays(state.prediction.days);

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
                        ClipPath(
                          clipper: DiagonalPathClipperOne(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.85,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://pbs.twimg.com/media/DEzMk2fWAAAfRaB.jpg',
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.5,
                              ),
                              color: Colors.amber.withOpacity(0.5),
                            ),
                            child: SafeArea(
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, top: 30.0),
                                      child: Text(
                                        state.municipalityName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "${state.currentRecord?.temperature.round() ?? ""}º",
                                        style: const TextStyle(
                                          fontSize: 65,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      state.prediction.days[1].skyState
                                          .description,
                                      style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 40.0, right: 20.0),
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            "${todayPrediction.temperature.tMin}º/ ${todayPrediction.temperature.tMax}º",
                                            style: const TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
          return const  Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> _getWidgetDays(List<Day> days) {
    List<Widget> dayWidgets = [];
    List<Widget> daysOfWeek = [];
    List<Widget> skyStates = [];
    List<Widget> minTemperatures = [];
    List<Widget> maxTemperatures = [];
    var textStyle = const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black45);
    for (var day in days) {
      if (day == days.first) {
        continue;
      }

      daysOfWeek.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Text(
            DateFormat('EEEE', 'es').format(day.date).capitalize(),
            style: textStyle,
          ),
        ),
      );
      skyStates.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Text(
            day.skyState.description,
            style: textStyle,
          ),
        ),
      );
      minTemperatures.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Text(
            "${day.temperature.tMin.toString()}º / ",
            style: textStyle,
          ),
        ),
      );
      maxTemperatures.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Text(
            "${day.temperature.tMax.toString()}º",
            style: textStyle,
          ),
        ),
      );
    }

    dayWidgets.add(
      Container(
        margin: const EdgeInsets.only(left: 15.0, bottom: 45.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: daysOfWeek,
            ),
            Column(
              children: skyStates,
            ),
            Row(
              children: [
                Column(
                  children: minTemperatures,
                ),
                Column(
                  children: maxTemperatures,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return dayWidgets;
  }
}
