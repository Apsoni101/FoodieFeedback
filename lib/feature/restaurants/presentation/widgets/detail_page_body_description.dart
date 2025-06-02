import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/rating_and_open_row.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/review_item_tile.dart';

class DetailPageBodyDescription extends StatelessWidget {
  const DetailPageBodyDescription({required this.restaurant, super.key});

  final RestaurantEntity restaurant;

  Future<void> _navigateToWriteReview(
    final BuildContext context,
    final String restaurantId,
  ) async {
    await context.router.push(AddReviewRoute(restaurantId: restaurantId));
  }

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RatingAndOpenRow(
          open: restaurant.isOpen,
          rating: restaurant.rating.toStringAsFixed(1),
        ),
        Text(
          restaurant.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(restaurant.cuisine),
        const SizedBox(height: 4),
        Text(restaurant.address),

        const SizedBox(height: 16),
        Text(restaurant.description),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(context.localisation.review, style: AppTextStyles.title),
            ElevatedButton(
              onPressed: () => _navigateToWriteReview(context, restaurant.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redGradientMiddle,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Text(context.localisation.write_review),
            ),
          ],
        ),
        const SizedBox(height: 12),
        restaurant.reviews.isEmpty
            ? Center(child: Text(context.localisation.noReviewsYet))
            : Column(
              children:
                  restaurant.reviews
                      .map(
                        (final ReviewEntity review) =>
                            ReviewItemTile(review: review),
                      )
                      .toList(),
            ),
      ],
    ),
  );
}
