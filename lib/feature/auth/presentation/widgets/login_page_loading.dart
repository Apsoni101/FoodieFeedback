import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:lottie/lottie.dart';

class LoginPageLoading extends StatelessWidget {
  const LoginPageLoading({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Lottie.asset(AppAssets.signingLoading),
      Text(context.localisation.loading, style: AppTextStyles.title),
    ],
  );
}
