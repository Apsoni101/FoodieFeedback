import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:lottie/lottie.dart';

class AddingLoading extends StatelessWidget {
  const AddingLoading({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Lottie.asset(AppAssets.loading),
      Text(context.localisation.adding, style: AppTextStyles.title),
    ],
  );
}
