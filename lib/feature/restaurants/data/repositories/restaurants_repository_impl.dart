import 'package:dartz/dartz.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/data/data_sources/restaurants_remote_data_source.dart';
import 'package:foodiefeedback/feature/restaurants/data/models/restaurants_model.dart';
import 'package:foodiefeedback/feature/restaurants/data/models/review_model.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/repositories/restaurants_repository.dart';

class RestaurantsRepositoryImpl implements RestaurantsRepository {
  RestaurantsRepositoryImpl({required this.remoteDataSource});

  final RestaurantRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurant(
    final String id,
  ) async {
    final Either<Failure, RestaurantModel> result = await remoteDataSource
        .getRestaurant(id);
    return result.fold(Left.new, Right.new);
  }

  @override
  Future<Either<Failure, Unit>> addReview(
    final String restaurantId,
    final ReviewEntity review,
  ) => remoteDataSource.addReview(
    restaurantId: restaurantId,
    review: ReviewModel.fromEntity(review),
  );

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getAllRestaurants() async {
    final Either<Failure, List<RestaurantModel>> result =
        await remoteDataSource.getAllRestaurants();

    return result.fold(
      Left.new,
      (final List<RestaurantModel> restaurantModels) =>
          Right<Failure, List<RestaurantEntity>>(
            restaurantModels.cast<RestaurantEntity>(),
          ),
    );
  }

  @override
  Stream<Either<Failure, RestaurantEntity>> listenToSingleRestaurant(
    final String id,
  ) => remoteDataSource
      .listenToSingleRestaurant(id)
      .map(
        (final Either<Failure, RestaurantModel> either) =>
            either.fold(Left.new, Right.new),
      );
}
