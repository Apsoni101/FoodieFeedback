import 'package:auto_route/auto_route.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/auth/domain/use_cases/auth_usecase.dart';

///authGuard for checking authentication
class AuthGuard extends AutoRouteGuard {
  ///authGuard instance
  AuthGuard({required this.authUseCase});

  ///authGuard instance
  final AuthUseCase authUseCase;
  @override
  Future<void> onNavigation(
    final NavigationResolver resolver,
    final StackRouter router,
  ) async {
    final bool isSignedIn = authUseCase.isSignedIn();

    if (isSignedIn) {
      resolver.next();
    } else {
      await router.push(
        LoginRoute(
          onLoggedIn: () async {
            await router.replaceAll(<PageRouteInfo<Object?>>[
              const RestaurantsListingRoute(),
            ]);
          },
        ),
      );
    }
  }
}
