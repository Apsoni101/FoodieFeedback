import 'package:equatable/equatable.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';

class RestaurantEntity extends Equatable {
  const RestaurantEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.cuisine,
    required this.isOpen,
    required this.reviews,
  });
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String address;
  final String cuisine;
  final bool isOpen;
  final List<ReviewEntity> reviews;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    description,
    imageUrl,
    rating,
    address,
    cuisine,
    isOpen,
    reviews,
  ];
}
