import 'package:flutter/widgets.dart';
import 'package:foodiefeedback/core/localisation/app_localizations.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalizations get localisation => AppLocalizations.of(this);
}
