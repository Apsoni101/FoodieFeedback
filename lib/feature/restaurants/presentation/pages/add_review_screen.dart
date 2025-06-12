import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/add_review_page_body.dart';

@RoutePage()
class AddReviewPage extends StatelessWidget {
  const AddReviewPage({required this.restaurantId, super.key});
  final String restaurantId;

  @override
  Widget build(final BuildContext context) => BlocProvider<ReviewBloc>(
    create: (final BuildContext context) => AppInjector.getIt<ReviewBloc>(),
    child: BlocListener<ReviewBloc, ReviewState>(
      listener: (final BuildContext context, final ReviewState state) {
        if (state is ReviewAddedSuccess) {
          context.router.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localisation.review_added_success)),
          );
        } else if (state is ReviewError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Text(context.localisation.write_review),
        ),
        body: AddReviewPageBody(restaurantId: restaurantId),
      ),
    ),
  );
}
