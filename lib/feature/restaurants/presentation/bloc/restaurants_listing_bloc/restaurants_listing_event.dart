part of 'restaurants_listing_bloc.dart';

sealed class RestaurantsListEvent extends Equatable {
  const RestaurantsListEvent();

  @override
  List<Object> get props => <Object>[];
}

class RestaurantsListFetching extends RestaurantsListEvent {}

class RestaurantsListUpdated extends RestaurantsListEvent {
  const RestaurantsListUpdated(this.restaurants);

  final List<RestaurantEntity> restaurants;

  @override
  List<Object> get props => [restaurants];
}

class EmitFailure extends RestaurantsListEvent {
  const EmitFailure(this.failure);

  final Failure failure;

  @override
  List<Object> get props => [failure];
}

class SearchQuery extends RestaurantsListEvent {
  const SearchQuery({required this.query});

  final String query;
}
