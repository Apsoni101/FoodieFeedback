part of 'add_restaurant_bloc.dart';

@immutable
sealed class AddRestaurantState extends Equatable {
  const AddRestaurantState();

  @override
  List<Object?> get props => <Object?>[];
}

final class AddRestaurantInitial extends AddRestaurantState {}

class AddRestaurantLoading extends AddRestaurantState {
  const AddRestaurantLoading();
}

class AddRestaurantFormState extends AddRestaurantState {
  const AddRestaurantFormState({
    this.name = '',
    this.description = '',
    this.address = '',
    this.cuisine = '',
    this.mainImage,
    this.isOpen = false,
  });

  final String name;
  final String description;
  final String address;
  final String cuisine;
  final File? mainImage;
  final bool isOpen;

  AddRestaurantFormState copyWith({
    final String? name,
    final String? description,
    final String? address,
    final String? cuisine,
    final File? mainImage,
    final bool? isOpen,
  }) => AddRestaurantFormState(
    name: name ?? this.name,
    description: description ?? this.description,
    address: address ?? this.address,
    cuisine: cuisine ?? this.cuisine,
    mainImage: mainImage ?? this.mainImage,
    isOpen: isOpen ?? this.isOpen,
  );

  @override
  List<Object?> get props => <Object?>[
    name,
    description,
    address,
    cuisine,
    mainImage,
    isOpen,
  ];
}

class AddRestaurantFormValidationError extends AddRestaurantState {
  const AddRestaurantFormValidationError({
    required this.nameError,
    required this.descriptionError,
    required this.addressError,
    required this.cuisineError,
  });

  final bool nameError;
  final bool descriptionError;
  final bool addressError;
  final bool cuisineError;

  @override
  List<Object> get props => <Object>[
    nameError,
    descriptionError,
    addressError,
    cuisineError,
  ];
}

class AddRestaurantSuccess extends AddRestaurantState {
  const AddRestaurantSuccess({required this.restaurantId});

  final String restaurantId;

  @override
  List<Object?> get props => <Object?>[restaurantId];
}

class AddRestaurantFailure extends AddRestaurantState {
  const AddRestaurantFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
