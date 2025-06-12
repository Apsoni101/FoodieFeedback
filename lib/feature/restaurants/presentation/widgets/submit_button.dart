import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => ElevatedButton(
    onPressed: isLoading ? null : onPressed,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16),
    ),
    child: Text(
      context.localisation.addRestaurant,
      style: AppTextStyles.subtitle,
    ),
  );
}
