import 'package:dartz/dartz.dart';
import 'package:foodiefeedback/core/constants/app_constants.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/core/services/firebase/firebase_firestore_service.dart';
import 'package:foodiefeedback/core/services/notification/notification_service.dart';
import 'package:foodiefeedback/feature/restaurants/data/models/restaurants_model.dart';
import 'package:foodiefeedback/feature/restaurants/data/models/review_model.dart';

abstract class RestaurantRemoteDataSource {
  Future<Either<Failure, RestaurantModel>> getRestaurant(final String id);

  Future<Either<Failure, List<RestaurantModel>>> getAllRestaurants();

  Stream<Either<Failure, RestaurantModel>> listenToSingleRestaurant(
    final String id,
  );

  Future<Either<Failure, Unit>> addReview({
    required final String restaurantId,
    required final ReviewModel review,
  });
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  RestaurantRemoteDataSourceImpl({
    required this.firestoreService,
    required this.notificationService,
  });

  final FirebaseFirestoreService firestoreService;
  final NotificationService notificationService;

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
      (final Map<String, dynamic> data) => Right<Failure, RestaurantModel>(// send through parser
        RestaurantModel.fromMap(Map<String, dynamic>.from(data), id: id),
      ),
    );
  }

  @override
  Future<Either<Failure, List<RestaurantModel>>> getAllRestaurants() async {
    try {
      final Either<Failure, List<Map<String, dynamic>>> result =
          await firestoreService.fetchAllDocuments(
            collectionPath: AppsConstants.restaurantsCollection,
          );

      return result.fold(Left.new, (
        final List<Map<String, dynamic>> documentsList,
      ) {
        try {
          final List<RestaurantModel> restaurants =
              documentsList.map((final Map<String, dynamic> docData) {
                String? docId;
                Map<String, dynamic> data;

                if (docData.containsKey('id')) {
                  docId = docData['id'] as String?;
                  data = Map<String, dynamic>.from(docData)..remove('id');
                } else {
                  data = Map<String, dynamic>.from(docData);
                  docId =
                      data.remove('documentId') as String? ??
                      data.remove('docId') as String?;
                }

                if (docId == null) {
                  throw Exception('Document ID not found in document data');
                }

                return RestaurantModel.fromMap(data, id: docId);
              }).toList();

          return Right<Failure, List<RestaurantModel>>(restaurants);
        } catch (e) {
          return Left<Failure, List<RestaurantModel>>(
            Failure('Failed to parse restaurants: $e'),
          );
        }
      });
    } catch (e) {
      return Left<Failure, List<RestaurantModel>>(
        Failure('Unexpected error while fetching restaurants: $e'),
      );
    }
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
                  RestaurantModel.fromMap(data, id: id),
                );
              } catch (e) {
                return Left<Failure, RestaurantModel>(
                  Failure('Failed to parse restaurant data: $e'),
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
            topic: 'restaurant-updates',
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
}
