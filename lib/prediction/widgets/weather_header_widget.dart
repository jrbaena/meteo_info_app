import 'package:flutter/material.dart';

import '../../common/widgets/custom_text_form_field.dart';

class WeatherHeaderWidget extends StatefulWidget {
  const WeatherHeaderWidget({super.key});

  @override
  State<WeatherHeaderWidget> createState() => _WeatherHeaderWidgetState();
}

class _WeatherHeaderWidgetState extends State<WeatherHeaderWidget> {
  late bool showTextForm;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    showTextForm = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (showTextForm) CustomTextFormField(textController: textController),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            color: Colors.green,
            onPressed: () {
              setState(() {
                showTextForm = !showTextForm;
              });
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
