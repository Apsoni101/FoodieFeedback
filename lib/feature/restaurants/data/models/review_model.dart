import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.userName,
    required super.rating,
    required super.comment,
    required super.date,
  });

  factory ReviewModel.fromEntity(final ReviewEntity entity) => ReviewModel(
    id: entity.id,
    userName: entity.userName,
    rating: entity.rating,
    comment: entity.comment,
    date: entity.date,
  );

  factory ReviewModel.fromMap(final Map<String, dynamic> map) => ReviewModel(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      comment: map['comment'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );

  Map<String, dynamic> toMap() => <String,dynamic >{
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };

  ReviewEntity toEntity() => ReviewEntity(
    id: id,
    userName: userName,
    rating: rating,
    comment: comment,
    date: date,
  );
}
