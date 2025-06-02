import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/core/localisation/app_localizations.dart';
import 'package:foodiefeedback/core/navigation/app_router.dart';
import 'package:foodiefeedback/core/services/firebase/crashlytics_service.dart';
import 'package:foodiefeedback/core/services/notification/notification_service.dart';
import 'package:foodiefeedback/core/services/storage%20/shared_prefs_service.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:foodiefeedback/firebase_options.dart';

/// The main entry point of the Flutter application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppInjector.setUp();

  await AppInjector.getIt<NotificationService>().initialize((
    final String deepLink,
  ) {
    if (deepLink.isNotEmpty) {}
  });
  await AppInjector.getIt<SharedPrefsService>().initSharedPreferences();
  await AppInjector.getIt<CrashlyticsService>().initialize();

  runApp(MyApp());
}

/// Sets up the  with a default theme and home screen.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
  MyApp({super.key});

  ///appRouter
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(final BuildContext context) => BlocProvider<SettingsBloc>(
    create: (_) => AppInjector.getIt<SettingsBloc>(),
    child: BlocBuilder<SettingsBloc, SettingsState>(
      builder:
          (final BuildContext context, final SettingsState state) =>
              MaterialApp.router(
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: state.themeMode,
                locale: state.locale,
                routerConfig: appRouter.config(),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                debugShowCheckedModeBanner: false,
              ),
    ),
  );
}
