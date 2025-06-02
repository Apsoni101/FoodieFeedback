import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_detail_bloc/restaurant_detail_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/detail_page_body.dart';

@RoutePage()
class RestaurantsDetailPage extends StatelessWidget {
  const RestaurantsDetailPage({required this.restaurantsId, super.key});

  final String restaurantsId;

  @override
  Widget build(final BuildContext context) =>
      BlocProvider<RestaurantDetailBloc>(
        create:
            (_) =>
                AppInjector.getIt<RestaurantDetailBloc>()
                  ..add(LoadRestaurantDetail(restaurantsId)),
        child: const Scaffold(body: DetailPageBody()),
      );
}
