import 'package:dartz/dartz.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';

abstract class RestaurantsRepository {
  Future<Either<Failure, RestaurantEntity>> getRestaurant(final String id);

  Stream<Either<Failure, RestaurantEntity>> listenToSingleRestaurant(
    final String id,
  );

  Future<Either<Failure, List<RestaurantEntity>>> getAllRestaurants();

  Future<Either<Failure, Unit>> addReview(
    final String restaurantId,
    final ReviewEntity review,
  );
}
