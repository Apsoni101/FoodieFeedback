import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_listing_bloc/restaurants_listing_bloc.dart';

class RestaurantsListingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const RestaurantsListingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(final BuildContext context) => AppBar(
    backgroundColor: Theme.of(context).colorScheme.background,
    toolbarHeight: preferredSize.height,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          context.localisation.appNameWithoutEmoji,
          style: AppTextStyles.headline1FontChange.copyWith(
            color: AppColors.redGradientStart,
          ),
        ),
        Text(
          context.localisation.appSubtitle,
          style: AppTextStyles.subtitleFontChange,
        ),
      ],
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () {
            context.router.push(const SettingsRoute());
          },

          child: Image.asset(AppAssets.profile, width: 48, height: 48),
        ),
      ),
    ],
  );
}
