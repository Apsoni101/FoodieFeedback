import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';
import 'package:foodiefeedback/feature/settings/domain/use_cases/settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required this.useCase})
      : super(
    SettingsState(
      themeMode: useCase.getThemeMode().fold(
            (final Failure _) => ThemeMode.light,
            (final ThemeMode mode) => mode,
      ),
      locale: useCase.getLocale().fold(
            (final Failure _) => const Locale('en'),
            (final Locale locale) => locale,
      ),
      user: useCase.getSavedUserCredentials().fold(
            (_) => null,
            (final UserEntity? user) => user,
      ),
    ),
  ) {
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<RefreshUserData>(_onRefreshUserData);

  }

  final SettingsUseCase useCase;

  Future<void> _onChangeTheme(
      ChangeThemeEvent event,
      Emitter<SettingsState> emit,
      ) async {
    final ThemeMode newTheme =
    state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await useCase.saveThemeMode(newTheme);
    emit(state.copyWith(themeMode: newTheme));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event,
      Emitter<SettingsState> emit,
      ) async {
    await useCase.saveLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _onRefreshUserData(
      RefreshUserData event,
      Emitter<SettingsState> emit,
      ) async {
    final userResult = useCase.getSavedUserCredentials();
    final user = userResult.fold(
          (_) => null,
          (final UserEntity? user) => user,
    );
    emit(state.copyWith(user : user));
  }
}
