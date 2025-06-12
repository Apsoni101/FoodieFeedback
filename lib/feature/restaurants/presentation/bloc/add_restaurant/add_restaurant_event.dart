part of 'add_restaurant_bloc.dart';

@immutable
sealed class AddRestaurantEvent extends Equatable {
  const AddRestaurantEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class RestaurantNameChanged extends AddRestaurantEvent {
  const RestaurantNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => <Object>[name];
}

class RestaurantDescriptionChanged extends AddRestaurantEvent {
  const RestaurantDescriptionChanged(this.description);
  final String description;

  @override
  List<Object> get props => <Object>[description];
}

class RestaurantAddressChanged extends AddRestaurantEvent {
  const RestaurantAddressChanged(this.address);
  final String address;

  @override
  List<Object> get props => <Object>[address];
}

class RestaurantCuisineChanged extends AddRestaurantEvent {
  const RestaurantCuisineChanged(this.cuisine);
  final String cuisine;

  @override
  List<Object> get props => <Object>[cuisine];
}

class RestaurantImageChanged extends AddRestaurantEvent {
  const RestaurantImageChanged(this.image);
  final File image;

  @override
  List<Object> get props => [image];
}

class RestaurantOpenStatusChanged extends AddRestaurantEvent {
  const RestaurantOpenStatusChanged({required this.isOpen});
  final bool isOpen;

  @override
  List<Object> get props => [isOpen];
}
class AddRestaurantSubmitted extends AddRestaurantEvent {
  const AddRestaurantSubmitted({
    required this.name,
    required this.description,
    required this.address,
    required this.cuisine,
    required this.isOpen,
    required this.mainImage,
  });

  final String name;
  final String description;
  final String address;
  final String cuisine;
  final bool isOpen;
  final File mainImage;

  @override
  List<Object> get props => <Object>[
    name,
    description,
    address,
    cuisine,
    mainImage,
    isOpen
  ];
}
