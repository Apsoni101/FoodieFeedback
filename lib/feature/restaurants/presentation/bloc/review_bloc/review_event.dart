part of 'review_bloc.dart';

@immutable
sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => <Object>[];
}

class ReviewNameChanged extends ReviewEvent {
  const ReviewNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => <Object>[name];
}

class ReviewCommentChanged extends ReviewEvent {
  const ReviewCommentChanged(this.comment);
  final String comment;

  @override
  List<Object> get props => <Object>[comment];
}

class ReviewRatingChanged extends ReviewEvent {
  const ReviewRatingChanged(this.rating);
  final double rating;

  @override
  List<Object> get props => <Object>[rating];
}

class AddReviewSubmitted extends ReviewEvent {
  const AddReviewSubmitted({
    required this.restaurantId,
    required this.name,
    required this.comment,
  });
  final String restaurantId;
  final String name;
  final String comment;

  @override
  List<Object> get props => <Object>[restaurantId, name, comment];
}
