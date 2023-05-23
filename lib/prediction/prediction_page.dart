import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';
import 'package:meteo_info_app/prediction/widgets/custom_text_form_field.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
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
                  "Error al cargar los datos",
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
              return Container(
                color: Colors.purple,
                height: 400,
                width: 400,
                child: Text(state.prediction.name),
              );
            }
            return ListView(
              children: [
                const Text("Predicción por municipio: "),
                CustomTextFormField(textController: textController),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        predictionCubit.searchLocation(textController.text);
                      },
                      child: const Center(
                        child: Text("Buscar"),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
