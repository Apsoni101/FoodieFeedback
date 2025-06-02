import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/localisation/app_localizations.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';

class ChangeLanguageRow extends StatelessWidget {
  const ChangeLanguageRow({super.key});

  @override
  Widget build(final BuildContext context) {
    final SettingsBloc settingsBloc = context.read<SettingsBloc>();
    final AppLocalizations loc = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(loc.changeLanguage),
        DropdownButton<Locale>(
          value: context.watch<SettingsBloc>().state.locale,
          items: <DropdownMenuItem<Locale>>[
            DropdownMenuItem<Locale>(
              value: const Locale('en'),
              child: Text(loc.languageEnglish),
            ),
            DropdownMenuItem<Locale>(
              value: const Locale('hi'),
              child: Text(loc.languageHindi),
            ),
            DropdownMenuItem<Locale>(
              value: const Locale('ar'),
              child: Text(loc.languageArabic),
            ),
          ],
          onChanged: (final Locale? locale) {
            if (locale != null) {
              settingsBloc.add(ChangeLanguageEvent(locale));
            }
          },
        ),
      ],
    );
  }
}
