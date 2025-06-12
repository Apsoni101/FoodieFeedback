import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/add_restaurant/add_restaurant_bloc.dart';

class CuisineTextField extends StatelessWidget {
  const CuisineTextField({
    required this.onChanged,
    required this.errorText,
    required this.controller,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String? errorText;
  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    final AddRestaurantState state = context.watch<AddRestaurantBloc>().state;
    final bool hasError =
        state is AddRestaurantFormValidationError && state.cuisineError;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: context.localisation.cuisine,
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
      onChanged: onChanged,
    );
  }
}
