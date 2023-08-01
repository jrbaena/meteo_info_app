import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_info_app/extensions/string_extension.dart';

import '../prediction/model/Prediction.dart';

extension DaysExtension on List<Day> {
  List<Widget> getWidgetDays() {
    List<Widget> dayWidgets = [];
    List<Widget> daysOfWeek = [];
    List<Widget> skyStates = [];
    List<Widget> minTemperatures = [];
    List<Widget> maxTemperatures = [];
    var textStyle = const TextStyle(
        fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black45);
    for (var day in this) {
      if (day == first) {
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
        margin: const EdgeInsets.only(left: 15.0, bottom: 35.0, right: 15.0),
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
