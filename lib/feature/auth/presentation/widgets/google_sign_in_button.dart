import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => TextButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(2),
    ),
    child: Image.asset(AppAssets.google, width: 48, height: 48),
  );
}
