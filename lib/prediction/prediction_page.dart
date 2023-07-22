import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'package:meteo_info_app/prediction/model/Prediction.dart';
import 'package:meteo_info_app/prediction/widgets/municipality_search_form_widget.dart';

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
          if (state is PredictionLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PredictionLoadedState) {
            //TODO date format, avoid empty fields, convert to cards with standard size and style...
            List<Widget> days = _getWidgetDays(state.prediction.days);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: DiagonalPathClipperOne(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.85,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://pbs.twimg.com/media/DEzMk2fWAAAfRaB.jpg',),
                        fit: BoxFit.cover,
                        opacity: 0.5,
                      ),
                      color: Colors.amber,
                    ),
                    child: SafeArea(
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20.0, top: 50.0),
                              child: Text(
                                state.municipalityName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      children: days),
                ),
              ],
            );
          }
          return const MunicipalitySearchFormWidget();
        },
      ),
    );
  }

  List<Widget> _getWidgetDays(List<Day> days) {
    List<Widget> dayWidgets = [];
    for (var element in days) {
      dayWidgets.add(
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
