import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:intl/intl.dart';

class ReviewItemTile extends StatelessWidget {
  const ReviewItemTile({required this.review, super.key});

  final ReviewEntity review;

  @override
  Widget build(final BuildContext context) {
    final String dateFormatted = DateFormat.yMMMd().format(review.date);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(review.userName),
        subtitle: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: List<Widget>.generate(
                5,
                (final int i) => Icon(
                  i < review.rating ? Icons.star : Icons.star_border,
                  color: AppColors.amber,
                  size: 20,
                ),
              ),
            ),
            Text(review.comment),
            Text(
              dateFormatted,
              style: AppTextStyles.restaurantsCardCaption.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
