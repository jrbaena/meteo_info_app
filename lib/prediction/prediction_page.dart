import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
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
              return ListView(
                children: [
                  Text(
                    "Predicción por municipios: ${state.municipalityName}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }
            return const MunicipalitySearchFormWidget();
          },
        ),
      ),
    );
  }
}
