import 'package:flutter/material.dart';

class RestaurantInputField extends StatelessWidget {
  const RestaurantInputField({
    required this.controller,
    required this.labelText,
    required this.validator,
    super.key,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final int maxLines;

  @override
  Widget build(final BuildContext context) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    maxLines: maxLines,
    validator: validator,
  );
}
