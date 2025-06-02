import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/auth/data/models/user_model.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';
import 'package:foodiefeedback/feature/settings/data/data_sources/settings_local_data_source.dart';
import 'package:foodiefeedback/feature/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required this.local});

  final SettingsLocalDataSource local;

  @override
  Future<Either<Failure, void>> saveThemeMode(final ThemeMode? mode) =>
      local.saveThemeMode(mode);

  @override
  Either<Failure, ThemeMode> getThemeMode() => local.getThemeMode();

  @override
  Future<Either<Failure, void>> saveLanguage(final Locale language) =>
      local.saveLanguageCode(language.languageCode);

  @override
  Either<Failure, Locale> getLanguage() => local.getLanguage();

  @override
  Either<Failure, UserEntity?> getSavedUserCredentials() => local.getUserCredentials();
}
