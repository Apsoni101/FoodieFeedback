part of 'restaurants_listing_bloc.dart';

sealed class RestaurantsListEvent extends Equatable {
  const RestaurantsListEvent();

  @override
  List<Object> get props => <Object>[];
}

class RestaurantsListFetching extends RestaurantsListEvent {}
class SearchQuery extends RestaurantsListEvent {
  const SearchQuery({required this.query});
  final String query;
}
