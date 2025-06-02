part of 'restaurant_detail_bloc.dart';

@immutable
sealed class RestaurantDetailEvent extends Equatable {
  const RestaurantDetailEvent();

  @override
  List<Object?> get props => <Object>[];
}

class LoadRestaurantDetail extends RestaurantDetailEvent {
  const LoadRestaurantDetail(this.id);
  final String id;

  @override
  List<Object?> get props => <String>[id];
}
