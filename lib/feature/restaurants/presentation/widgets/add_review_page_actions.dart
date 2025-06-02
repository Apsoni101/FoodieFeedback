import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/review_bloc/review_bloc.dart';

class AddReviewPageActions extends StatelessWidget {
  const AddReviewPageActions({
    required this.restaurantId,
    required this.name,
    required this.comment,
    this.onSubmit,
    super.key,
  });

  final String restaurantId;
  final String name;
  final String comment;
  final VoidCallback? onSubmit;

  @override
  Widget build(final BuildContext context) => Row(
    spacing: 16,
    children: <Widget>[
      Expanded(
        child: OutlinedButton(
          onPressed: () => context.router.pop(),
          child: Text(context.localisation.cancel),
        ),
      ),
      Expanded(
        child: BlocBuilder<ReviewBloc, ReviewState>(
          builder: (final BuildContext context, final ReviewState state) {
            final bool isLoading = state is ReviewLoading;
            return ElevatedButton(
              onPressed:
                  isLoading
                      ? null
                      : () {
                        context.read<ReviewBloc>().add(
                          AddReviewSubmitted(
                            restaurantId: restaurantId,
                            name: name,
                            comment: comment,
                          ),
                        );
                        onSubmit?.call();
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redGradientMiddle,
                foregroundColor: AppColors.white,
              ),
              child:
                  isLoading
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : Text(context.localisation.submit_review),
            );
          },
        ),
      ),
    ],
  );
}
