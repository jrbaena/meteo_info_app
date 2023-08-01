import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/custom_text_form_field.dart';
import '../bloc/prediction_cubit.dart';

class MunicipalitySearchFormWidget extends StatefulWidget {
  const MunicipalitySearchFormWidget({super.key});

  @override
  State<MunicipalitySearchFormWidget> createState() =>
      _MunicipalitySearchFormWidgetState();
}

class _MunicipalitySearchFormWidgetState
    extends State<MunicipalitySearchFormWidget> {
  final TextEditingController textController = TextEditingController();
  late final PredictionCubit predictionCubit;
  final _searchMunicipalityFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    predictionCubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _searchMunicipalityFormKey,
      child: ListView(
        children: [
          const Text("Predicción por municipio: "),
          CustomTextFormField(textController: textController),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                if (_searchMunicipalityFormKey.currentState!.validate()) {
                  predictionCubit.searchLocation(textController.text);
                }
              },
              child: const Center(
                child: Text("Buscar"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
