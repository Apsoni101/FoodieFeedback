import 'package:auto_route/auto_route.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/core/navigation/auth_guard.dart';
import 'package:foodiefeedback/core/navigation/route_paths.dart';
import 'package:foodiefeedback/core/navigation/routes/login_screen_router.dart';
import 'package:foodiefeedback/core/navigation/routes/restaurants_listing_router.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard = AppInjector.getIt<AuthGuard>();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: SplashRoute.page, path: RoutePaths.splash, initial: true),
    restaurantsListingRoute(authGuard),
    loginRoute,
  ];
}
