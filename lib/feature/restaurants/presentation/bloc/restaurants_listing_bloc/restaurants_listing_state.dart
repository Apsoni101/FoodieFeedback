part of 'restaurants_listing_bloc.dart';

sealed class RestaurantsListState extends Equatable {
  const RestaurantsListState();

  @override
  List<Object> get props => <Object>[];
}

class RestaurantsListInitial extends RestaurantsListState {}

class RestaurantsListLoading extends RestaurantsListState {}

class RestaurantsListLoaded extends RestaurantsListState {
  const RestaurantsListLoaded({required this.restaurants});
  final List<RestaurantEntity> restaurants;

  @override
  List<Object> get props => <List<RestaurantEntity>>[restaurants];
}

class RestaurantsListFailure extends RestaurantsListState {
  const RestaurantsListFailure({required this.message});
  final String message;

  @override
  List<Object> get props => <String>[message];
}
