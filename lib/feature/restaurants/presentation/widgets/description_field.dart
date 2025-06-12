import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    required this.onChanged,
    required this.errorText,
    required this.controller,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String? errorText;
  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) => TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: context.localisation.description,
      border: const OutlineInputBorder(),
      errorText: errorText,
    ),
    maxLines: 3,
    onChanged: onChanged,
  );
}
