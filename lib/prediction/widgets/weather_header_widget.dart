import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_info_app/prediction/bloc/prediction_cubit.dart';

import '../../common/widgets/custom_text_form_field.dart';
import '../../maps/maps_page.dart';

class WeatherHeaderWidget extends StatelessWidget {
  WeatherHeaderWidget({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PredictionCubit predictionCubit =
        BlocProvider.of<PredictionCubit>(context);
    final record =
        (predictionCubit.state as PredictionLoadedState).currentRecord;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsPage(
                        latitude: record.latitude,
                        longitude: record.longitude,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
          CustomTextFormField(
            textController: textController,
            onPressed: (String municipality) {
              predictionCubit.searchLocation(municipality);
            },
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
