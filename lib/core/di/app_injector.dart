import 'package:foodiefeedback/core/navigation/auth_guard.dart';
import 'package:foodiefeedback/core/services/firebase/crashlytics_service.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_auth%20_service.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_firestore_service.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_storage_service.dart';
import 'package:foodiefeedback/core/services/networking/network_service.dart';
import 'package:foodiefeedback/core/services/notification/fcm_service.dart';
import 'package:foodiefeedback/core/services/notification/notification_service.dart';
import 'package:foodiefeedback/core/services/storage%20/shared_prefs_service.dart';
import 'package:foodiefeedback/feature/auth/data/data_sources/auth_local_data_source.dart';
import 'package:foodiefeedback/feature/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:foodiefeedback/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:foodiefeedback/feature/auth/domain/repositories/auth_repo.dart';
import 'package:foodiefeedback/feature/auth/domain/use_cases/auth_usecase.dart';
import 'package:foodiefeedback/feature/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:foodiefeedback/feature/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:foodiefeedback/feature/restaurants/data/repositories/restaurants_repository_impl.dart';
import 'package:foodiefeedback/feature/restaurants/domain/repositories/restaurants_repository.dart';
import 'package:foodiefeedback/feature/restaurants/domain/use_cases/restaurants_use_case.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_detail_bloc/restaurant_detail_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_listing_bloc/restaurants_listing_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:foodiefeedback/feature/settings/data/data_sources/settings_local_data_source.dart';
import 'package:foodiefeedback/feature/settings/data/repositories/settings_repository_impl.dart';
import 'package:foodiefeedback/feature/settings/domain/repositories/settings_repository.dart';
import 'package:foodiefeedback/feature/settings/domain/use_cases/settings_usecase.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:get_it/get_it.dart';

/// Responsible for injecting dependencies
class AppInjector {
  static final GetIt getIt = GetIt.instance;

  /// This method should be called in main to set up all dependencies
  static Future<void> setUp() async {
    getIt
      // Core Services
      ..registerLazySingleton(SharedPrefsService.new)
      ..registerLazySingleton(FirebaseAuthService.new)
      ..registerLazySingleton(NetworkService.new)
      ..registerLazySingleton(FirebaseFirestoreService.new)
      ..registerLazySingleton(FirebaseStorageService.new)
      ..registerLazySingleton(CrashlyticsService.new)
      ..registerLazySingleton<NotificationService>(
        () => FCMService(networkService: getIt<NetworkService>()),
      )
      // Auth Feature
      ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
          authService: getIt<FirebaseAuthService>(),
          firestoreService: getIt<FirebaseFirestoreService>(),
        ),
      )
      ..registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(
          sharedPrefsService: getIt<SharedPrefsService>(),
        ),
      )
      ..registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(
          authRemoteDataSource: getIt<AuthRemoteDataSource>(),
          authLocalDataSource: getIt<AuthLocalDataSource>(),
        ),
      )
      ..registerLazySingleton<AuthUseCase>(
        () => AuthUseCase(authRepo: getIt<AuthRepo>()),
      )
      ..registerFactory<AuthBloc>(
        () => AuthBloc(authUseCase: getIt<AuthUseCase>()),
      )
      ..registerFactory<RegisterBloc>(
        () => RegisterBloc(authUseCase: getIt<AuthUseCase>()),
      )
      // Auth Guard
      ..registerLazySingleton<AuthGuard>(
        () => AuthGuard(authUseCase: getIt<AuthUseCase>()),
      )
      // Restaurants Feature
      ..registerLazySingleton<RestaurantRemoteDataSource>(
        () => RestaurantRemoteDataSourceImpl(
          firestoreService: getIt<FirebaseFirestoreService>(),
          notificationService: getIt<NotificationService>(),
          storageService: getIt<FirebaseStorageService>(),
        ),
      )
      ..registerLazySingleton<RestaurantsRepository>(
        () => RestaurantsRepositoryImpl(
          remoteDataSource: getIt<RestaurantRemoteDataSource>(),
        ),
      )
      ..registerLazySingleton<RestaurantsUseCases>(
        () => RestaurantsUseCases(repository: getIt<RestaurantsRepository>()),
      )
      ..registerFactory<RestaurantsListBloc>(
        () => RestaurantsListBloc(useCases: getIt<RestaurantsUseCases>()),
      )
      ..registerFactory<AddRestaurantBloc>(
        () => AddRestaurantBloc(useCases: getIt<RestaurantsUseCases>()),
      )
      ..registerFactory<RestaurantDetailBloc>(
        () => RestaurantDetailBloc(useCases: getIt<RestaurantsUseCases>()),
      )
      ..registerFactory<ReviewBloc>(
        () => ReviewBloc(useCases: getIt<RestaurantsUseCases>()),
      )
      // Settings Feature
      ..registerLazySingleton<SettingsLocalDataSource>(
        () => SettingsLocalDataSourceImpl(
          sharedPrefs: getIt<SharedPrefsService>(),
        ),
      )
      ..registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(local: getIt<SettingsLocalDataSource>()),
      )
      ..registerLazySingleton<SettingsUseCase>(
        () => SettingsUseCase(repository: getIt<SettingsRepository>()),
      )
      ..registerFactory<SettingsBloc>(
        () => SettingsBloc(useCase: getIt<SettingsUseCase>()),
      );
  }
}
