import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/add_restaurant/add_restaurant_bloc.dart';

class OpenStatusSwitch extends StatelessWidget {
  const OpenStatusSwitch({
    required this.isOpen,
    required this.onChanged,
    super.key,
  });

  final bool isOpen;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(final BuildContext context) => SwitchListTile(
      title: Text(context.localisation.currentlyOpen),
      value: isOpen,
      onChanged: onChanged,
    );
}
