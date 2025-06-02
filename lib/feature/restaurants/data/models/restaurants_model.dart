import 'package:foodiefeedback/feature/restaurants/data/models/review_model.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.images,
    required super.rating,
    required super.address,
    required super.cuisine,
    required super.isOpen,
    required List<ReviewModel> super.reviews,
  });

  factory RestaurantModel.fromEntity(final RestaurantEntity entity) =>
      RestaurantModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        imageUrl: entity.imageUrl,
        images: entity.images,
        rating: entity.rating,
        address: entity.address,
        cuisine: entity.cuisine,
        isOpen: entity.isOpen,
        reviews: entity.reviews.map(ReviewModel.fromEntity).toList(),
      );

  factory RestaurantModel.fromMap(
    final Map<String, dynamic> map, {
    required final String id,
  }) => RestaurantModel(
    id: id,
    name: map['name'] ?? '',
    description: map['description'] ?? '',
    imageUrl: map['imageUrl'] ?? '',
    images: List<String>.from(map['images'] ?? <String>[]),
    rating: (map['rating'] ?? 0).toDouble(),
    address: map['address'] ?? '',
    cuisine: map['cuisine'] ?? '',
    isOpen: map['isOpen'] ?? false,
    reviews:
        (map['reviews'] as List<dynamic>? ?? <dynamic>[])
            .map((final e) => ReviewModel.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'images': images,
    'rating': rating,
    'address': address,
    'cuisine': cuisine,
    'isOpen': isOpen,
    'reviews':
        reviews
            .map((final ReviewEntity e) => (e as ReviewModel).toMap())
            .toList(),
  };

  RestaurantEntity toEntity() => RestaurantEntity(
    id: id,
    name: name,
    description: description,
    imageUrl: imageUrl,
    images: images,
    rating: rating,
    address: address,
    cuisine: cuisine,
    isOpen: isOpen,
    reviews: reviews,
  );
}
