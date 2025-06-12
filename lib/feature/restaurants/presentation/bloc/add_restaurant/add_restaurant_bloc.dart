import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/review_entity.dart';
import 'package:foodiefeedback/feature/restaurants/domain/use_cases/restaurants_use_case.dart';

part 'add_restaurant_event.dart';

part 'add_restaurant_state.dart';

class AddRestaurantBloc extends Bloc<AddRestaurantEvent, AddRestaurantState> {
  AddRestaurantBloc({required this.useCases}) : super(AddRestaurantInitial()) {
    on<RestaurantNameChanged>(_onNameChanged);
    on<RestaurantDescriptionChanged>(_onDescriptionChanged);
    on<RestaurantAddressChanged>(_onAddressChanged);
    on<RestaurantCuisineChanged>(_onCuisineChanged);
    on<RestaurantImageChanged>(_onImageChanged);
    on<RestaurantOpenStatusChanged>(_onOpenStatusChanged);
    on<AddRestaurantSubmitted>(_onSubmitted);
  }

  final RestaurantsUseCases useCases;

  void _onNameChanged(
    final RestaurantNameChanged event,
    final Emitter<AddRestaurantState> emit,
  ) {
    final AddRestaurantState currentState = state;
    if (currentState is AddRestaurantFormState) {
      emit(currentState.copyWith(name: event.name));
    } else {
      emit(AddRestaurantFormState(name: event.name));
    }
  }

  void _onDescriptionChanged(
    final RestaurantDescriptionChanged event,
    final Emitter<AddRestaurantState> emit,
  ) {
    final AddRestaurantState currentState = state;
    if (currentState is AddRestaurantFormState) {
      emit(currentState.copyWith(description: event.description));
    } else {
      emit(AddRestaurantFormState(description: event.description));
    }
  }

  void _onAddressChanged(
    final RestaurantAddressChanged event,
    final Emitter<AddRestaurantState> emit,
  ) {
    final AddRestaurantState currentState = state;
    if (currentState is AddRestaurantFormState) {
      emit(currentState.copyWith(address: event.address));
    } else {
      emit(AddRestaurantFormState(address: event.address));
    }
  }

  void _onCuisineChanged(
    final RestaurantCuisineChanged event,
    final Emitter<AddRestaurantState> emit,
  ) {
    final AddRestaurantState currentState = state;
    if (currentState is AddRestaurantFormState) {
      emit(currentState.copyWith(cuisine: event.cuisine));
    } else {
      emit(AddRestaurantFormState(cuisine: event.cuisine));
    }
  }

  void _onImageChanged(
    final RestaurantImageChanged event,
    final Emitter<AddRestaurantState> emit,
  ) {
    final AddRestaurantState currentState = state;
    if (currentState is AddRestaurantFormState) {
      emit(currentState.copyWith(mainImage: event.image));
    } else {
      emit(AddRestaurantFormState(mainImage: event.image));
    }
  }

  void _onOpenStatusChanged(
    final RestaurantOpenStatusChanged event,
    final Emitter<AddRestaurantState> emit,
  ) {
    final AddRestaurantState currentState = state;
    if (currentState is AddRestaurantFormState) {
      emit(currentState.copyWith(isOpen: event.isOpen));
    } else {
      emit(AddRestaurantFormState(isOpen: event.isOpen));
    }
  }

  Future<void> _onSubmitted(
    final AddRestaurantSubmitted event,
    final Emitter<AddRestaurantState> emit,
  ) async {
    final String name = event.name.trim();
    final String description = event.description.trim();
    final String address = event.address.trim();
    final String cuisine = event.cuisine.trim();
    final File mainImage = event.mainImage;
    final bool isOpen = event.isOpen;

    final bool nameError = name.isEmpty;
    final bool descriptionError = description.isEmpty;
    final bool addressError = address.isEmpty;
    final bool cuisineError = cuisine.isEmpty;

    if (nameError || descriptionError || addressError || cuisineError) {
      emit(
        AddRestaurantFormValidationError(
          nameError: nameError,
          descriptionError: descriptionError,
          addressError: addressError,
          cuisineError: cuisineError,
        ),
      );
      return;
    }

    emit(const AddRestaurantLoading());



    final RestaurantEntity restaurant = RestaurantEntity(
      name: name,
      description: description,
      address: address,
      cuisine: cuisine,
      id: DateTime.now().toString(),
      imageUrl: '', // This is set after image upload
      rating: 0,
      isOpen: isOpen,
      reviews: const <ReviewEntity>[],
    );

    final Either<Failure, String> result = await useCases.addRestaurant(
      restaurant: restaurant,
      image: mainImage,
    );

    result.fold(
      (final Failure failure) =>
          emit(AddRestaurantFailure(message: failure.message)),
      (final String restaurantId) =>
          emit(AddRestaurantSuccess(restaurantId: restaurantId)),
    );
  }
}
