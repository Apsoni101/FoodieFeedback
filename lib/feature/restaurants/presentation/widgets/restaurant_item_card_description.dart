import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/rating_and_open_row.dart';

class RestaurantItemCardDescription extends StatelessWidget {
  const RestaurantItemCardDescription({required this.restaurant, super.key});

  final RestaurantEntity restaurant;

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            restaurant.name,
            style: AppTextStyles.title.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          RatingAndOpenRow(
            open: restaurant.isOpen,
            rating: restaurant.rating.toStringAsFixed(1),
          ),
          Text(
            restaurant.cuisine,
            style: AppTextStyles.body.copyWith(color: theme.colorScheme.error),
          ),
          Text(
            restaurant.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
