import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/localisation/app_localizations.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';

class ChangeThemeRow extends StatelessWidget {
  const ChangeThemeRow({super.key});

  @override
  Widget build(final BuildContext context) {
    final SettingsBloc settingsBloc = context.read<SettingsBloc>();
    final AppLocalizations loc = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(loc.darkTheme),
        Switch(
          thumbColor: WidgetStateProperty.all(AppColors.redGradientStart),
          activeTrackColor: AppColors.redGradientMiddle.withValues(alpha: 0.4),
          value:
              context.watch<SettingsBloc>().state.themeMode == ThemeMode.dark,
          onChanged: (_) => settingsBloc.add(const ChangeThemeEvent()),
        ),
      ],
    );
  }
}
