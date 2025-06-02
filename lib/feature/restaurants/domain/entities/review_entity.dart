import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  const ReviewEntity({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  @override
  List<Object?> get props => <Object?>[id, userName, rating, comment, date];
}
