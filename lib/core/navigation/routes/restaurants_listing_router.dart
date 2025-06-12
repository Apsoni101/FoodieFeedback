import 'package:auto_route/auto_route.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/core/navigation/auth_guard.dart';
import 'package:foodiefeedback/core/navigation/route_paths.dart';

@RoutePage(name: "RestaurantsRouter")
class RestaurantsRouterPage extends AutoRouter {
  const RestaurantsRouterPage({super.key});
}

AutoRoute restaurantsListingRoute(final AuthGuard authGuard) => AutoRoute(
  page: RestaurantsRouter.page,
  path: RoutePaths.restaurantsListingTab,
  guards: <AutoRouteGuard>[authGuard],
  children: <AutoRoute>[
    AutoRoute(page: RestaurantsListingRoute.page, path: '', initial: true),
    AutoRoute(
      page: RestaurantsDetailRoute.page,
      path: RoutePaths.restaurantsDetail,
    ),
    AutoRoute(
      page: AddRestaurantScreen.page,
      path: RoutePaths.restaurantsAdding,
    ),
    AutoRoute(page: AddReviewRoute.page, path: RoutePaths.addReview),
    AutoRoute(page: SettingsRoute.page, path: RoutePaths.settings),
  ],
);
