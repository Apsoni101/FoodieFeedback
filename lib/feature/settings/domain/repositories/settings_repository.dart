import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/auth/data/models/user_model.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> saveThemeMode(final ThemeMode? mode);
  Either<Failure, ThemeMode> getThemeMode();

  Future<Either<Failure, void>> saveLanguage(final Locale language);
  Either<Failure, Locale> getLanguage();

  Either<Failure, UserEntity?> getSavedUserCredentials();
}
