// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:foodiefeedback/core/navigation/routes/login_screen_router.dart' as _i3;
import 'package:foodiefeedback/core/navigation/routes/restaurants_listing_router.dart'
    as _i7;
import 'package:foodiefeedback/feature/auth/presentation/pages/login_page.dart'
    as _i2;
import 'package:foodiefeedback/feature/auth/presentation/pages/register_page.dart'
    as _i4;
import 'package:foodiefeedback/feature/restaurants/presentation/pages/add_review_page.dart'
    as _i1;
import 'package:foodiefeedback/feature/restaurants/presentation/pages/restaurants_detail_page.dart'
    as _i5;
import 'package:foodiefeedback/feature/restaurants/presentation/pages/restaurants_listing_page.dart'
    as _i6;
import 'package:foodiefeedback/feature/settings/presentation/pages/settings_page.dart'
    as _i8;
import 'package:foodiefeedback/feature/splash/presentation/pages/splash_page.dart'
    as _i9;

/// generated route for
/// [_i1.AddReviewPage]
class AddReviewRoute extends _i10.PageRouteInfo<AddReviewRouteArgs> {
  AddReviewRoute({
    required String restaurantId,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         AddReviewRoute.name,
         args: AddReviewRouteArgs(restaurantId: restaurantId, key: key),
         initialChildren: children,
       );

  static const String name = 'AddReviewRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddReviewRouteArgs>();
      return _i1.AddReviewPage(restaurantId: args.restaurantId, key: args.key);
    },
  );
}

class AddReviewRouteArgs {
  const AddReviewRouteArgs({required this.restaurantId, this.key});

  final String restaurantId;

  final _i11.Key? key;

  @override
  String toString() {
    return 'AddReviewRouteArgs{restaurantId: $restaurantId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddReviewRouteArgs) return false;
    return restaurantId == other.restaurantId && key == other.key;
  }

  @override
  int get hashCode => restaurantId.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i11.Key? key,
    _i11.VoidCallback? onLoggedIn,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, onLoggedIn: onLoggedIn),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i2.LoginPage(key: args.key, onLoggedIn: args.onLoggedIn);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoggedIn});

  final _i11.Key? key;

  final _i11.VoidCallback? onLoggedIn;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoggedIn: $onLoggedIn}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key && onLoggedIn == other.onLoggedIn;
  }

  @override
  int get hashCode => key.hashCode ^ onLoggedIn.hashCode;
}

/// generated route for
/// [_i3.LoginRouterPage]
class LoginRouter extends _i10.PageRouteInfo<void> {
  const LoginRouter({List<_i10.PageRouteInfo>? children})
    : super(LoginRouter.name, initialChildren: children);

  static const String name = 'LoginRouter';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginRouterPage();
    },
  );
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i11.Key? key,
    _i11.VoidCallback? onRegistered,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         RegisterRoute.name,
         args: RegisterRouteArgs(key: key, onRegistered: onRegistered),
         initialChildren: children,
       );

  static const String name = 'RegisterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return _i4.RegisterPage(key: args.key, onRegistered: args.onRegistered);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key, this.onRegistered});

  final _i11.Key? key;

  final _i11.VoidCallback? onRegistered;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, onRegistered: $onRegistered}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterRouteArgs) return false;
    return key == other.key && onRegistered == other.onRegistered;
  }

  @override
  int get hashCode => key.hashCode ^ onRegistered.hashCode;
}

/// generated route for
/// [_i5.RestaurantsDetailPage]
class RestaurantsDetailRoute
    extends _i10.PageRouteInfo<RestaurantsDetailRouteArgs> {
  RestaurantsDetailRoute({
    required String restaurantsId,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         RestaurantsDetailRoute.name,
         args: RestaurantsDetailRouteArgs(
           restaurantsId: restaurantsId,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'RestaurantsDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RestaurantsDetailRouteArgs>();
      return _i5.RestaurantsDetailPage(
        restaurantsId: args.restaurantsId,
        key: args.key,
      );
    },
  );
}

class RestaurantsDetailRouteArgs {
  const RestaurantsDetailRouteArgs({required this.restaurantsId, this.key});

  final String restaurantsId;

  final _i11.Key? key;

  @override
  String toString() {
    return 'RestaurantsDetailRouteArgs{restaurantsId: $restaurantsId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RestaurantsDetailRouteArgs) return false;
    return restaurantsId == other.restaurantsId && key == other.key;
  }

  @override
  int get hashCode => restaurantsId.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i6.RestaurantsListingPage]
class RestaurantsListingRoute extends _i10.PageRouteInfo<void> {
  const RestaurantsListingRoute({List<_i10.PageRouteInfo>? children})
    : super(RestaurantsListingRoute.name, initialChildren: children);

  static const String name = 'RestaurantsListingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.RestaurantsListingPage();
    },
  );
}

/// generated route for
/// [_i7.RestaurantsRouterPage]
class RestaurantsRouter extends _i10.PageRouteInfo<void> {
  const RestaurantsRouter({List<_i10.PageRouteInfo>? children})
    : super(RestaurantsRouter.name, initialChildren: children);

  static const String name = 'RestaurantsRouter';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.RestaurantsRouterPage();
    },
  );
}

/// generated route for
/// [_i8.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SettingsPage();
    },
  );
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashPage();
    },
  );
}
