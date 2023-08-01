import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textController;

  const CustomTextFormField({super.key, required this.textController});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 150,
      child: TextFormField(
        controller: textController,
        validator: _validate,
        textAlignVertical: TextAlignVertical.top,
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
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)
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