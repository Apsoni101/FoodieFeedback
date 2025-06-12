import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_listing_bloc/restaurants_listing_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/restaurant_listing_appbar.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/restaurants_listing_page_body.dart';

@RoutePage()
class RestaurantsListingPage extends StatelessWidget {
  const RestaurantsListingPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<RestaurantsListBloc>(
    create:
        (_) =>
            AppInjector.getIt<RestaurantsListBloc>()
              ..add(RestaurantsListFetching()),
    child: Scaffold(
      appBar: const RestaurantsListingAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () async {
          await context.router.push(const AddRestaurantScreen());
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: RestaurantsListingPageBody(),
      ),
    ),
  );
}
