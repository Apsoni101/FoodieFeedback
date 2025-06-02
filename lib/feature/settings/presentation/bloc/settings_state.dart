part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.themeMode,
    required this.locale,
    required this.user,
  });
  final ThemeMode themeMode;
  final Locale locale;
  final UserEntity? user;

  SettingsState copyWith({
    final ThemeMode? themeMode,
    final Locale? locale,
    final UserEntity? user,
  }) => SettingsState(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
    user: user ,
  );

  @override
  List<Object?> get props => <Object?>[themeMode, locale, user];
}
