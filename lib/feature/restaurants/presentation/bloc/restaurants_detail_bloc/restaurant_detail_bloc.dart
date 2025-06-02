import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/use_cases/restaurants_use_case.dart';

part 'restaurant_detail_event.dart';

part 'restaurant_detail_state.dart';

class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  RestaurantDetailBloc({required this.useCases})
    : super(const RestaurantDetailInitial()) {
    on<LoadRestaurantDetail>(_onLoadRestaurantDetail);
  }

  final RestaurantsUseCases useCases;

  Future<void> _onLoadRestaurantDetail(
    final LoadRestaurantDetail event,
    final Emitter<RestaurantDetailState> emit,
  ) async {
    emit(const RestaurantDetailLoading());

    await emit.forEach<Either<Failure, RestaurantEntity>>(
      useCases.listenToSingleRestaurant(event.id),
      onData:
          (final Either<Failure, RestaurantEntity> either) => either.fold(
            (final Failure failure) => RestaurantDetailError(failure.message),
            (final RestaurantEntity restaurant) {
              final List<ReviewEntity> sortedReviews = List<ReviewEntity>.from(
                restaurant.reviews,
              )..sort(
                (final ReviewEntity a, final ReviewEntity b) =>
                    b.date.compareTo(a.date),
              );

              final RestaurantEntity sortedRestaurant = RestaurantEntity(
                id: restaurant.id,
                name: restaurant.name,
                description: restaurant.description,
                imageUrl: restaurant.imageUrl,
                images: restaurant.images,
                rating: restaurant.rating,
                address: restaurant.address,
                cuisine: restaurant.cuisine,
                isOpen: restaurant.isOpen,
                reviews: sortedReviews,
              );
              return RestaurantDetailLoaded(sortedRestaurant);
            },
          ),
      onError:
          (_, final _) =>
              const RestaurantDetailError('Unexpected error occurred'),
    );
  }
}
