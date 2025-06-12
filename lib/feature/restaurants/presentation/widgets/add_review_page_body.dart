import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/add_review_page_actions.dart';

class AddReviewPageBody extends StatefulWidget {
  const AddReviewPageBody({required this.restaurantId, super.key});

  final String restaurantId;

  @override
  State<AddReviewPageBody> createState() => _AddReviewPageBodyState();
}

class _AddReviewPageBodyState extends State<AddReviewPageBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<ReviewBloc, ReviewState>(
        // can be done by records with bloc selector
        builder: (final BuildContext context, final ReviewState state) {
          final ReviewBloc bloc = context.read<ReviewBloc>();

          final bool nameError =
              state is ReviewFormValidationError && state.nameError;
          final bool commentError =
              state is ReviewFormValidationError && state.commentError;
          final num rating = (state is ReviewFormState) ? state.rating : 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: context.localisation.your_name,
                        border: const OutlineInputBorder(),
                        errorText:
                            nameError
                                ? context.localisation.enter_name_error
                                : null,
                      ),
                      onChanged:
                          (final String val) =>
                              bloc.add(ReviewNameChanged(val.trim())),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      context.localisation.rating_label,
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        5,
                        (final int index) => IconButton(
                          onPressed: () {
                            bloc.add(ReviewRatingChanged(index + 1));
                          },
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: AppColors.amber,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: context.localisation.your_review,
                        border: const OutlineInputBorder(),
                        alignLabelWithHint: true,
                        errorText:
                            commentError
                                ? context.localisation.enter_review_error
                                : null,
                      ),
                      maxLines: 6,
                      onChanged:
                          (final String val) =>
                              bloc.add(ReviewCommentChanged(val.trim())),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AddReviewPageActions(
                onSubmit: () {
                 bloc.add(
                    AddReviewSubmitted(
                      restaurantId: widget.restaurantId,
                      name: _nameController.text.trim(),
                      comment: _commentController.text.trim(),
                    ),
                  );
                  _nameController.clear();
                  _commentController.clear();
                },
              ),
            ],
          );
        },
      );
}
