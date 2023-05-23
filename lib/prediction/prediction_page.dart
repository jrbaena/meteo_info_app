import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'package:meteo_info_app/prediction/model/Prediction.dart';
import 'package:meteo_info_app/prediction/widgets/municipality_search_form_widget.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PredictionCubit predictionCubit = BlocProvider.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
            if (state is PredictionLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PredictionLoadedState) {
              //TODO date format, avoid empty fields, convert to cards with standard size and style...
              List<Widget> days = _getWidgetDays(state.prediction.days);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Predicción por municipios: ${state.municipalityName}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: days)),
                ],
              );
            }
            return const MunicipalitySearchFormWidget();
          },
        ),
      ),
    );
  }

  List<Widget> _getWidgetDays(List<Day> days) {
    List<Widget> dayWidgets = [];
    for (var element in days) {
      dayWidgets.add(
        Container(
          margin:
              element != days.first ? const EdgeInsets.only(left: 10.0) : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${element.date.day}"),
              const Text("Estado del cielo:"),
              Text(element.skyState.description),
              const Text("Tª (°C)"),
              Text("${element.temperature.tMin} / ${element.temperature.tMax}"),
            ],
          ),
        ),
      );
    }
    return dayWidgets;
  }
}
