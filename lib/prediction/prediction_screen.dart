import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_bloc.dart';
import 'package:meteo_info_app/prediction/widgets/custom_text_form_field.dart';

import '../injector.dart';

class PredictionScreen extends StatelessWidget {
  PredictionScreen({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final predictionBloc = Injector.resolve<PredictionBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Predicción"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<PredictionBloc, PredictionState>(
            bloc: predictionBloc,
            builder: (context, state) {
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
                          predictionBloc
                              .add(SearchLocation(textController.text));
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
      ),
    );
  }
}
