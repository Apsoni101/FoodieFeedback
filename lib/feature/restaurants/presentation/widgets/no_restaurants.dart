import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions.dart';

class NoRestaurants extends StatelessWidget {
  const NoRestaurants({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(AppAssets.empty),
      Text(
        context.localisation.noRestaurantsFound,
        style: AppTextStyles.headline2.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    ],
  );
}
