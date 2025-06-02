import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_detail_bloc/restaurant_detail_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/custom_image.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/detail_page_body_description.dart';
import 'package:lottie/lottie.dart';

class DetailPageBody extends StatelessWidget {
  const DetailPageBody({super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
        builder:
            (final BuildContext context, final RestaurantDetailState state) =>
                switch (state) {
                  RestaurantDetailInitial() || RestaurantDetailLoading() =>
                    Center(child: Lottie.asset(AppAssets.loading)),
                  RestaurantDetailLoaded(
                    restaurant: final RestaurantEntity restaurant,
                  ) =>
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CustomImage(
                            imageUrl: restaurant.imageUrl,
                            aspectRatio: 0.9,
                          ),
                          DetailPageBodyDescription(restaurant: restaurant),
                        ],
                      ),
                    ),
                  RestaurantDetailError(:final String message) => Center(
                    child: Text(message),
                  ),
                },
      );
}
