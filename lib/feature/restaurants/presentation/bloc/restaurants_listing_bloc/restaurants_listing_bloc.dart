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
    on<SearchQuery>(_searchQuery);
  }

  final RestaurantsUseCases useCases;

  Future<void> _onRestaurantsListFetching(
    final RestaurantsListFetching event,
    final Emitter<RestaurantsListState> emit,
  ) async {
    emit(RestaurantsListLoading());
    final Either<Failure, List<RestaurantEntity>> result =
        await useCases.getAllRestaurants();
    result.fold(
      (final Failure failure) =>
          emit(RestaurantsListFailure(message: failure.message)),
      (final List<RestaurantEntity> restaurants) =>
          emit(RestaurantsListLoaded(restaurants: restaurants)),
    );
  }

  Future<void> _searchQuery(
    final SearchQuery event,
    final Emitter<RestaurantsListState> emit,
  ) async {
    emit(RestaurantsListLoading());
    final Either<Failure, List<RestaurantEntity>> result =
        await useCases.getAllRestaurants();
    result.fold(
      (final Failure failure) =>
          emit(RestaurantsListFailure(message: failure.message)),
      (final List<RestaurantEntity> restaurants) {
        final List<RestaurantEntity> updatedList =
            restaurants
                .where(
                  (final RestaurantEntity restaurant) => restaurant.name.toLowerCase().contains(
                    event.query.toLowerCase(),
                  ),
                )
                .toList();
        return emit(RestaurantsListLoaded(restaurants: updatedList));
      },
    );
  }
}
