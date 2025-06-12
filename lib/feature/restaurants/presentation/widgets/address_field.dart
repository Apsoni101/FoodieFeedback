import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/add_restaurant/add_restaurant_bloc.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({
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
        labelText: context.localisation.address,
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
}
