import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const TextForm({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return 'The value cannot be empty';
        }
        return null;
      },
    );
  }
}
