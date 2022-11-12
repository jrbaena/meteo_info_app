import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textController;

  const CustomTextFormField({super.key, required this.textController});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          controller: textController,
          validator: _validate,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Colors.black26), //<-- SEE HERE
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Colors.red), //<-- SEE HERE
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: Colors.blue), //<-- SEE HERE
            ),
          ),
        ),
      ),
    );
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo no puede estar vacío";
    }
    return null;
  }
}