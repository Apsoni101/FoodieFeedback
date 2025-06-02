import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_listing_bloc/restaurants_listing_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/no_restaurants.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/restaurant_item_card.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/search_and_filter_row.dart';
import 'package:lottie/lottie.dart';

class RestaurantsListingPageBody extends StatelessWidget {
  const RestaurantsListingPageBody({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    spacing: 16,
    children: <Widget>[
      const SearchAndFilterRow(),
      Expanded(
        child: BlocBuilder<RestaurantsListBloc, RestaurantsListState>(
          builder:
              (
                final BuildContext context,
                final RestaurantsListState state,
              ) => switch (state) {
                RestaurantsListInitial() || RestaurantsListLoading() => Center(
                  child: Lottie.asset(AppAssets.loading),
                ),
                RestaurantsListFailure(message: final String message) => Center(
                  child: Text(
                    message,
                    style: AppTextStyles.subtitle.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),

                RestaurantsListLoaded(
                  restaurants: final List<RestaurantEntity> restaurants,
                ) =>
                  restaurants.isEmpty
                      ? const NoRestaurants()
                      : ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (
                          final BuildContext context,
                          final int index,
                        ) {
                          final RestaurantEntity restaurant =
                              restaurants[index];
                          return RestaurantCard(
                            restaurant: restaurant,
                            onTap: () async {
                              await context.router.push(
                                RestaurantsDetailRoute(
                                  restaurantsId: restaurant.id,
                                ),
                              );
                            },
                          );
                        },
                      ),
              },
        ),
      ),
    ],
  );
}
