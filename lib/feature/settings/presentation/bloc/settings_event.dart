part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class ChangeThemeEvent extends SettingsEvent {
  const ChangeThemeEvent();
}

final class ChangeLanguageEvent extends SettingsEvent {
  const ChangeLanguageEvent(this.locale);
  final Locale locale;

  @override
  List<Object?> get props => <Object?>[locale];
}
class RefreshUserData extends SettingsEvent {
  const RefreshUserData();
}