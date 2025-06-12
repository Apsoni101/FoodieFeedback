// restaurants_list_bloc.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/use_cases/restaurants_use_case.dart';

part 'restaurants_listing_event.dart';

part 'restaurants_listing_state.dart';

class RestaurantsListBloc
    extends Bloc<RestaurantsListEvent, RestaurantsListState> {
  RestaurantsListBloc({required this.useCases})
    : super(RestaurantsListInitial()) {
    on<RestaurantsListFetching>(_onRestaurantsListFetching);
    on<RestaurantsListUpdated>(_restaurantsListUpdated);
    on<SearchQuery>(_searchQuery);
  }

  final RestaurantsUseCases useCases;

  Future<void> _onRestaurantsListFetching(
    final RestaurantsListFetching event,
    final Emitter<RestaurantsListState> emit,
  ) async {
    emit(RestaurantsListLoading());

    await useCases.listenToAllRestaurants().forEach((
      final Either<Failure, List<RestaurantEntity>> result,
    ) {
      result.fold(
        (final Failure failure) {
          emit(RestaurantsListFailure(message: failure.message));
        },
        (final List<RestaurantEntity> restaurants) {
          add(RestaurantsListUpdated(restaurants));
        },
      );
    });
  }

  Future<void> _restaurantsListUpdated(
    final RestaurantsListUpdated event,
    final Emitter<RestaurantsListState> emit,
  ) async {
    emit(RestaurantsListLoaded(restaurants: event.restaurants));
  }

  Future<void> _searchQuery(
    final SearchQuery event,
    final Emitter<RestaurantsListState> emit,
  ) async {
    emit(RestaurantsListLoading());

    await useCases.listenToAllRestaurants().forEach((
      final Either<Failure, List<RestaurantEntity>> result,
    ) {
      result.fold(
        (final Failure failure) {
          emit(RestaurantsListFailure(message: failure.message));
        },
        (final List<RestaurantEntity> restaurants) {
          final List<RestaurantEntity> filtered =
              restaurants
                  .where(
                    (final RestaurantEntity restaurant) => restaurant.name
                        .toLowerCase()
                        .contains(event.query.toLowerCase()),
                  )
                  .toList();
          add(RestaurantsListUpdated(filtered));
        },
      );
    });
  }
}
