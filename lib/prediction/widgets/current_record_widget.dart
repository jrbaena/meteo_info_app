import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:meteo_info_app/prediction/widgets/weather_header_widget.dart';

import '../../current_record/model/record.dart';
import '../model/Prediction.dart';

class CurrentRecordWidget extends StatelessWidget {
  const CurrentRecordWidget({
    super.key,
    required this.todayPrediction,
    required this.prediction,
    required this.currentRecord,
    required this.municipalityName,
  });

  final Day todayPrediction;
  final Prediction prediction;
  final Record? currentRecord;
  final String municipalityName;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiagonalPathClipperOne(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.75,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage(
              'https://pbs.twimg.com/media/DEzMk2fWAAAfRaB.jpg',
            ),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
          color: Colors.amber.withOpacity(0.6),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const WeatherHeaderWidget(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    municipalityName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "${currentRecord?.temperature.round() ?? ""}º",
                    style: const TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  prediction.days[1].skyState.description,
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
                      padding: const EdgeInsets.only(top: 40.0, right: 20.0),
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
    );
  }
}
