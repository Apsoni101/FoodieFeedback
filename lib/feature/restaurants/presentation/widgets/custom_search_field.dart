import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({required this.onChanged, super.key});
  final Function(String)? onChanged;

  @override
  Widget build(final BuildContext context) => Expanded(
    child: SearchBar(
      backgroundColor: WidgetStatePropertyAll<Color>(
        Theme.of(context).colorScheme.surface,
      ),
      hintText: context.localisation.searchRestaurantsHint,
      hintStyle: const WidgetStatePropertyAll<TextStyle>(
        AppTextStyles.subtitle,
      ),
      onChanged: onChanged,
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      leading: const Icon(Icons.search),
      elevation: const WidgetStatePropertyAll<double>(1),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}
