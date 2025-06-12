import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';

class RatingAndOpenRow extends StatelessWidget {
  const RatingAndOpenRow({required this.open, required this.rating, super.key});
  final bool open;
  final String rating;

  @override
  Widget build(final BuildContext context) => Row(
    children: <Widget>[
      const Icon(Icons.star, color: AppColors.amber,size: 16,),
      const SizedBox(width: 4),
      Text(rating),
      const SizedBox(width: 16),
      Text(
        open ? context.localisation.open : context.localisation.closed,
        style: AppTextStyles.restaurantsCardCaption.copyWith(
          color: open ? AppColors.green : AppColors.redGradientMiddle,
        ),
      ),
    ],
  );
}
