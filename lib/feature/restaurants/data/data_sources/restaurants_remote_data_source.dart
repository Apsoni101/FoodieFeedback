import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:foodiefeedback/core/constants/app_constants.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_firestore_service.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_storage_service.dart';
import 'package:foodiefeedback/core/services/notification/notification_service.dart';
import 'package:foodiefeedback/feature/restaurants/data/models/restaurants_model.dart';
import 'package:foodiefeedback/feature/restaurants/data/models/review_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<Either<Failure, RestaurantModel>> getRestaurant(final String id);

  Stream<Either<Failure, RestaurantModel>> listenToSingleRestaurant(
    final String id,
  );

  Stream<Either<Failure, List<RestaurantModel>>> listenToAllRestaurants();

  Future<Either<Failure, Unit>> addReview({
    required final String restaurantId,
    required final ReviewModel review,
  });

  Future<Either<Failure, String>> addRestaurant({
    required final RestaurantModel restaurant,
    final File? image,
  });
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  RestaurantRemoteDataSourceImpl({
    required this.firestoreService,
    required this.notificationService,
    required this.storageService,
  });

  final FirebaseFirestoreService firestoreService;
  final NotificationService notificationService;
  final FirebaseStorageService storageService;

  @override
  Future<Either<Failure, RestaurantModel>> getRestaurant(
    final String id,
  ) async {
    final Either<Failure, Map<String, dynamic>> result = await firestoreService
        .getDocument(
          collectionPath: AppsConstants.restaurantsCollection,
          docId: id,
        );

    return result.fold(
      Left.new,
      (final Map<String, dynamic> data) => Right<Failure, RestaurantModel>(
        RestaurantModel.fromMap(Map<String, dynamic>.from(data)),
      ),
    );
  }

  @override
  Stream<Either<Failure, RestaurantModel>> listenToSingleRestaurant(
    final String id,
  ) => firestoreService
      .listenToDocument(
        collectionPath: AppsConstants.restaurantsCollection,
        docId: id,
      )
      .map(
        (final Either<Failure, Map<String, dynamic>> eitherData) =>
            eitherData.fold(Left.new, (final Map<String, dynamic> data) {
              try {
                return Right<Failure, RestaurantModel>(
                  RestaurantModel.fromMap(data),
                );
              } catch (e) {
                return Left<Failure, RestaurantModel>(
                  Failure('Failed to parse restaurant data: $e'),
                );
              }
            }),
      );

  @override
  Stream<Either<Failure, List<RestaurantModel>>> listenToAllRestaurants() =>
      firestoreService
          .listenToAllDocuments(
            collectionPath: AppsConstants.restaurantsCollection,
          )
          .map(
            (final Either<Failure, List<Map<String, dynamic>>> result) => result
                .fold(Left.new, (final List<Map<String, dynamic>> dataList) {
                  try {
                    final List<RestaurantModel> restaurants =
                        dataList.map(RestaurantModel.fromMap).toList();
                    return Right<Failure, List<RestaurantModel>>(restaurants);
                  } on Exception catch (_, e) {
                    return Left<Failure, List<RestaurantModel>>(
                      Failure('Failed to parse restaurant list: $e'),
                    );
                  }
                }),
          );

  @override
  Future<Either<Failure, Unit>> addReview({
    required final String restaurantId,
    required final ReviewModel review,
  }) async {
    try {
      final Either<Failure, Map<String, dynamic>> result =
          await firestoreService.getDocument(
            collectionPath: AppsConstants.restaurantsCollection,
            docId: restaurantId,
          );

      return await result.fold(Left.new, (
        final Map<String, dynamic> data,
      ) async {
        final List<dynamic> existingReviews =
            (data['reviews'] ?? <dynamic>[])..add(review.toMap());

        final List<double> ratings =
            existingReviews
                .map((final e) => (e['rating'] as num).toDouble())
                .toList();
        final double averageRating =
            ratings.reduce((final double a, final double b) => a + b) /
            ratings.length;

        final Either<Failure, Unit> updateResult = await firestoreService
            .updateDocument(
              collectionPath: AppsConstants.restaurantsCollection,
              docId: restaurantId,
              data: <String, dynamic>{
                'reviews': existingReviews,
                'rating': averageRating,
              },
            );

        await updateResult.fold((_) => null, (_) async {
          final String restaurantName = data['name'] ?? 'A restaurant';
          final String rating = review.rating.toString();

          await notificationService.sendNotification(
            topic: AppsConstants.restaurantsCollection,
            title: 'New Review Alert!',
            body:
                '$restaurantName got a new $rating-star review. Check it out!',
            deepLink: 'restaurant_detail',
            restaurantId: restaurantId,
            additionalData: <String, String>{
              'notification_type': 'new_review',
              'restaurant_name': restaurantName,
              'review_rating': rating,
            },
          );
        });
        return updateResult;
      });
    } catch (e) {
      return Left<Failure, Unit>(Failure('Failed to add review: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> addRestaurant({
    required final RestaurantModel restaurant,
    final File? image,
  }) async {
    try {
      String imageUrl = restaurant.imageUrl;
      if (image != null) {
        final Either<Failure, String> imageResult = await storageService
            .uploadFile(
              path: 'restaurants/${DateTime.now()}_main.jpg',
              file: image,
              contentType: 'image/jpeg',
            );

        return await imageResult.fold(
          (final Failure failure) => Left<Failure, String>(
            Failure('Image upload failed: ${failure.message}'),
          ),
          (final String uploadedUrl) async {
            imageUrl = uploadedUrl;

            final RestaurantModel updatedRestaurant = RestaurantModel(
              id: restaurant.id,
              name: restaurant.name,
              description: restaurant.description,
              imageUrl: imageUrl,
              rating: 0,
              address: restaurant.address,
              cuisine: restaurant.cuisine,
              isOpen: restaurant.isOpen,
              reviews: const <ReviewModel>[],
            );

            final Either<Failure, Unit> saveResult = await firestoreService
                .setData(
                  collectionPath: AppsConstants.restaurantsCollection,
                  docId: updatedRestaurant.id,
                  data: updatedRestaurant.toMap(),
                );

            return saveResult.fold(
              (final Failure failure) => Left<Failure, String>(
                Failure('Failed to save restaurant: ${failure.message}'),
              ),
              (_) => Right<Failure, String>(updatedRestaurant.id),
            );
          },
        );
      }

      // If no image provided, i am proceeding with saving directly
      final RestaurantModel updatedRestaurant = RestaurantModel(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        imageUrl: '',
        rating: 0,
        address: restaurant.address,
        cuisine: restaurant.cuisine,
        isOpen: restaurant.isOpen,
        reviews: const <ReviewModel>[],
      );

      final Either<Failure, Unit> saveResult = await firestoreService.setData(
        collectionPath: AppsConstants.restaurantsCollection,
        docId: updatedRestaurant.id,
        data: updatedRestaurant.toMap(),
      );

      return saveResult.fold(
        (final Failure failure) => Left<Failure, String>(
          Failure('Failed to save restaurant: ${failure.message}'),
        ),
        (_) => Right<Failure, String>(updatedRestaurant.id),
      );
    } catch (e) {
      return Left<Failure, String>(Failure('Unexpected error: $e'));
    }
  }
}
