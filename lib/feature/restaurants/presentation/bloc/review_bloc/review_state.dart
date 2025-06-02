part of 'review_bloc.dart';

@immutable
sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object?> get props => <Object>[];
}

final class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {
  const ReviewLoading();
}

class ReviewFormState extends ReviewState {
  const ReviewFormState({this.name = '', this.comment = '', this.rating = 0});

  final String name;
  final String comment;
  final double rating;

  ReviewFormState copyWith({
    final String? name,
    final String? comment,
    final double? rating,
  }) => ReviewFormState(
    name: name ?? this.name,
    comment: comment ?? this.comment,
    rating: rating ?? this.rating,
  );

  @override
  List<Object> get props => <Object>[name, comment, rating];
}

class ReviewFormValidationError extends ReviewState {
  const ReviewFormValidationError({
    required this.nameError,
    required this.commentError,
    required this.ratingError,
  });

  final bool nameError;
  final bool commentError;
  final bool ratingError;

  @override
  List<Object> get props => <Object>[nameError, commentError, ratingError];
}

class ReviewAddedSuccess extends ReviewState {
  const ReviewAddedSuccess();
}

class ReviewError extends ReviewState {
  const ReviewError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
