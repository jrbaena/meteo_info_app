import 'package:flutter/material.dart';
import 'package:meteo_info_app/extensions/string_extension.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final void Function(String) onPressed;

  const CustomTextFormField({super.key, required this.textController, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 175,
      child: TextFormField(
        controller: textController,
        validator: _validate,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          hintText: "Escribe la capital",
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(bottom: 10.0, left: 15),
            onPressed: () {
              onPressed(textController.text.replaceSpecialCharacters().toLowerCase());
            },
            icon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 25,
          ),
          ),
        ),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white
        ),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "El campo no puede estar vacío";
    }
    return null;
  }
}