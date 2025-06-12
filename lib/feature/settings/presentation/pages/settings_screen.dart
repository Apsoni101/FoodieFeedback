import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:foodiefeedback/feature/settings/presentation/widgets/change_language_row.dart';
import 'package:foodiefeedback/feature/settings/presentation/widgets/change_theme_row.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(final BuildContext context) {

    final SettingsState state = context.watch<SettingsBloc>().state;

    return Scaffold(
      appBar: AppBar(title: Text(context.localisation.profileTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: <Widget>[
            const Icon(Icons.person, size: 56),
            Text(
              '${context.localisation.email} : ${state.user?.name}',
              style: AppTextStyles.subtitle,
            ),
            const ChangeThemeRow(),
            const ChangeLanguageRow(),
            const Spacer(),
            OutlinedButton.icon(
              icon: const Icon(
                Icons.logout,
                color: AppColors.redGradientStart,
                size: 28,
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.redGradientStart),
              ),
              onPressed: () {},
              label: Text(
                context.localisation.logout,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.redGradientStart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
