import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/use_cases/restaurants_use_case.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({required this.useCases}) : super(ReviewInitial()) {
    on<ReviewNameChanged>(_onReviewNameChanged);
    on<ReviewCommentChanged>(_onReviewCommentChanged);
    on<ReviewRatingChanged>(_onReviewRatingChanged);
    on<AddReviewSubmitted>(_onAddReviewSubmitted);
  }

  final RestaurantsUseCases useCases;

  void _onReviewNameChanged(
    final ReviewNameChanged event,
    final Emitter<ReviewState> emit,
  ) {
    final ReviewState currentState = state;
    if (currentState is ReviewFormState) {
      emit(currentState.copyWith(name: event.name));
    } else {
      emit(ReviewFormState(name: event.name));
    }
  }

  void _onReviewCommentChanged(
    final ReviewCommentChanged event,
    final Emitter<ReviewState> emit,
  ) {
    final ReviewState currentState = state;
    if (currentState is ReviewFormState) {
      emit(currentState.copyWith(comment: event.comment));
    } else {
      emit(ReviewFormState(comment: event.comment));
    }
  }

  void _onReviewRatingChanged(
    final ReviewRatingChanged event,
    final Emitter<ReviewState> emit,
  ) {
    final ReviewState currentState = state;
    if (currentState is ReviewFormState) {
      emit(currentState.copyWith(rating: event.rating));
    } else {
      emit(ReviewFormState(rating: event.rating));
    }
  }

  Future<void> _onAddReviewSubmitted(
    final AddReviewSubmitted event,
    final Emitter<ReviewState> emit,
  ) async {
    final ReviewState currentState = state;

    final String name = event.name;
    final String comment = event.comment;
    double rating = 0;

    if (currentState is ReviewFormState) {
      rating = currentState.rating;
    }

    final bool nameError = name.trim().isEmpty;
    final bool commentError = comment.trim().isEmpty;
    final bool ratingError = rating == 0;

    if (nameError || commentError || ratingError) {
      emit(
        ReviewFormValidationError(
          nameError: nameError,
          commentError: commentError,
          ratingError: ratingError,
        ),
      );
      return;
    }

    emit(const ReviewLoading());

    final ReviewEntity review = ReviewEntity(
      userName: name.trim(),
      comment: comment.trim(),
      rating: rating,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    final Either<Failure, Unit> result = await useCases.addReview(
      restaurantId: event.restaurantId,
      review: review,
    );

    result.fold(
      (final Failure failure) => emit(ReviewError(failure.message)),
      (_) => emit(const ReviewAddedSuccess()),
    );
  }
}
