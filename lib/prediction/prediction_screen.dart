import 'package:flutter/material.dart';
import 'package:meteo_info_app/prediction/widgets/custom_text_form_field.dart';

class PredictionScreen extends StatelessWidget {
  PredictionScreen({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predicción"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text("Predicción por municipio: "),
              CustomTextFormField(textController: textController),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Center(
                      child: Text("Buscar"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
