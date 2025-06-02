part of 'restaurant_detail_bloc.dart';

@immutable
sealed class RestaurantDetailState extends Equatable {
  const RestaurantDetailState();

  @override
  List<Object?> get props => <Object>[];
}

class RestaurantDetailInitial extends RestaurantDetailState {
  const RestaurantDetailInitial();
}

class RestaurantDetailLoading extends RestaurantDetailState {
  const RestaurantDetailLoading();
}

class RestaurantDetailLoaded extends RestaurantDetailState {
  const RestaurantDetailLoaded(this.restaurant);
  final RestaurantEntity restaurant;

  @override
  List<Object?> get props => <Object?>[restaurant];
}

class RestaurantDetailError extends RestaurantDetailState {
  const RestaurantDetailError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
