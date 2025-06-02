import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/core/services/storage%20/shared_prefs_keys.dart';
import 'package:foodiefeedback/core/services/storage%20/shared_prefs_service.dart';
import 'package:foodiefeedback/feature/auth/data/models/user_model.dart';

sealed class SettingsLocalDataSource {
  Future<Either<Failure, void>> saveThemeMode(final ThemeMode? themeMode);

  Either<Failure, ThemeMode> getThemeMode();

  Future<Either<Failure, void>> saveLanguageCode(final String language);

  Either<Failure, Locale> getLanguage();

  Either<Failure, UserModel?> getUserCredentials();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl({required this.sharedPrefs});

  final SharedPrefsService sharedPrefs;

  @override
  Future<Either<Failure, Unit>> saveThemeMode(final ThemeMode? mode) async {
    try {
      await sharedPrefs.setString(SharedPrefsKeys.themeMode, mode!.name);
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(Failure("Failed to save theme mode: $e"));
    }
  }

  @override
  Either<Failure, ThemeMode> getThemeMode() {
    try {
      final String? value = sharedPrefs.getString(SharedPrefsKeys.themeMode);
      return Right<Failure, ThemeMode>(_parseThemeMode(value ?? 'system'));
    } catch (e) {
      return Left<Failure, ThemeMode>(Failure("Failed to get theme mode: $e"));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLanguageCode(final String code) async {
    try {
      await sharedPrefs.setString(SharedPrefsKeys.languageCode, code);
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(Failure("Failed to save language code: $e"));
    }
  }

  @override
  Either<Failure, Locale> getLanguage() {
    try {
      final String code =
          sharedPrefs.getString(SharedPrefsKeys.languageCode) ?? 'en';
      return Right<Failure, Locale>(Locale(code));
    } catch (e) {
      return Left<Failure, Locale>(Failure("Failed to get language code: $e"));
    }
  }

  @override
  Either<Failure, UserModel?> getUserCredentials() {
    try {
      final String? email = sharedPrefs.getString(SharedPrefsKeys.userEmail);
      final String? name = sharedPrefs.getString(SharedPrefsKeys.userName);
      final String? uid = sharedPrefs.getString(SharedPrefsKeys.userUid);

      if (email == null || name == null || uid == null) {
        return const Right(null);
      }

      final UserModel userModel = UserModel(uid: uid, email: email, name: name);
      return Right(userModel);
    } catch (e) {
      return Left(
        Failure("Failed to get saved user credentials: $e"),
      );
    }
  }


  ThemeMode _parseThemeMode(final String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
