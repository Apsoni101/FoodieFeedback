import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/auth/data/models/user_model.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';
import 'package:foodiefeedback/feature/settings/domain/repositories/settings_repository.dart';

class SettingsUseCase {
  SettingsUseCase({required this.repository});
  final SettingsRepository repository;

  Either<Failure, ThemeMode> getThemeMode() => repository.getThemeMode();

  Either<Failure, Locale> getLocale() => repository.getLanguage();
  Either<Failure, UserEntity?> getSavedUserCredentials() =>
      repository.getSavedUserCredentials();

  Future<Either<Failure, void>> saveThemeMode(final ThemeMode mode) =>
      repository.saveThemeMode(mode);

  Future<Either<Failure, void>> saveLocale(final Locale locale) =>
      repository.saveLanguage(locale);
}
