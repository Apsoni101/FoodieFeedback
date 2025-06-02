import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';

/// A reusable custom text field widget with optional validation.
class CustomTextField extends StatelessWidget {
  /// Creates a [CustomTextField] with label and hint text.
  const CustomTextField({
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    super.key,
    this.obscureText = false,
    this.keyboardType,
  });

  /// Controller for managing the input text.
  final TextEditingController textEditingController;

  /// Label text above the field.
  final String labelText;

  /// Hint text shown inside the field.
  final String hintText;

  /// Hides input text (for passwords).
  final bool obscureText;

  /// Input type (email, number, etc).
  final TextInputType? keyboardType;

  /// prefix icon
  final Icon prefixIcon;

  @override
  Widget build(final BuildContext context) => TextField(
    controller: textEditingController,
    obscureText: obscureText,
    keyboardType: keyboardType,

    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: AppTextStyles.subtitle.copyWith(
        color: AppColors.redGradientMiddle,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.redGradientMiddle, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.redGradientMiddle),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.redGradientMiddle),
      ),
    ),
  );
}
