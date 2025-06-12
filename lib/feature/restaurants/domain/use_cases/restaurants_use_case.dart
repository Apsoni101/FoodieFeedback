import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/repositories/restaurants_repository.dart';

class RestaurantsUseCases {
  RestaurantsUseCases({required this.repository});

  final RestaurantsRepository repository;

  Future<Either<Failure, RestaurantEntity>> getRestaurant(final String id) =>
      repository.getRestaurant(id);

  Stream<Either<Failure, List<RestaurantEntity>>> listenToAllRestaurants() =>
      repository.listenToAllRestaurants();

  Future<Either<Failure, Unit>> addReview({
    required final String restaurantId,
    required final ReviewEntity review,
  }) => repository.addReview(restaurantId, review);

  Stream<Either<Failure, RestaurantEntity>> listenToSingleRestaurant(
    final String id,
  ) => repository.listenToSingleRestaurant(id);

  Future<Either<Failure, String>> addRestaurant({
    required final RestaurantEntity restaurant,
    final File? image,
  })=>repository.addRestaurant(restaurant: restaurant,image: image);
}
