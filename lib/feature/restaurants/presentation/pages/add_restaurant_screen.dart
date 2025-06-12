import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/adding_loading.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/address_field.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/cuisine_field.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/description_field.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/image_picker_card.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/name_field.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/open_status_switch.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/submit_button.dart';

@RoutePage()
class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _cuisineController.dispose();
    super.dispose();
  }

  void _submitForm(final BuildContext context, final AddRestaurantState state) {
    final File? mainImage =
        state is AddRestaurantFormState ? state.mainImage : null;
    final bool? isOpen = state is AddRestaurantFormState ? state.isOpen : null;

    if (mainImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.localisation.pleaseSelectImage)),
      );
      return;
    }

    if (isOpen == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.localisation.pleaseSpecifyOpenStatus)),
      );
      return;
    }

    context.read<AddRestaurantBloc>().add(
      AddRestaurantSubmitted(
        name: _nameController.text,
        description: _descriptionController.text,
        address: _addressController.text,
        cuisine: _cuisineController.text,
        isOpen: isOpen,
        mainImage: mainImage,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) => BlocProvider<AddRestaurantBloc>(
    create: (_) => AppInjector.getIt<AddRestaurantBloc>(),
    child: Scaffold(
      appBar: AppBar(title: Text(context.localisation.addRestaurantTitle)),
      body: BlocConsumer<AddRestaurantBloc, AddRestaurantState>(
        listener: (final BuildContext context, final AddRestaurantState state) {
          if (state is AddRestaurantSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.localisation.restaurantAddedSuccess),
              ),
            );
            context.router.pop();
          } else if (state is AddRestaurantFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.localisation.errorMessage(state.message)),
              ),
            );
          }
        },
        builder:
            (
              final BuildContext context,
              final AddRestaurantState state,
            ) => switch (state) {
              AddRestaurantSuccess() ||
              AddRestaurantInitial() ||
              AddRestaurantFormState() ||
              AddRestaurantFormValidationError() => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    NameTextField(
                      controller: _nameController,
                      onChanged: (final String value) {
                        context.read<AddRestaurantBloc>().add(
                          RestaurantNameChanged(value),
                        );
                      },
                      errorText:
                          state is AddRestaurantFormValidationError &&
                                  state.nameError
                              ? context.localisation.enter_name_error
                              : null,
                    ),
                    DescriptionTextField(
                      errorText:
                          state is AddRestaurantFormValidationError &&
                                  state.descriptionError
                              ? context.localisation.enter_name_error
                              : null,
                      onChanged: (final String value) {
                        context.read<AddRestaurantBloc>().add(
                          RestaurantDescriptionChanged(value),
                        );
                      },
                      controller: _descriptionController,
                    ),
                    AddressTextField(
                      onChanged: (final String value) {
                        context.read<AddRestaurantBloc>().add(
                          RestaurantAddressChanged(value),
                        );
                      },
                      errorText:
                          state is AddRestaurantFormValidationError &&
                                  state.addressError
                              ? context.localisation.enter_name_error
                              : null,
                      controller: _addressController,
                    ),
                    CuisineTextField(
                      onChanged: (final String value) {
                        context.read<AddRestaurantBloc>().add(
                          RestaurantCuisineChanged(value),
                        );
                      },
                      errorText:
                          state is AddRestaurantFormValidationError &&
                                  state.cuisineError
                              ? context.localisation.enter_name_error
                              : null,
                      controller: _cuisineController,
                    ),
                    OpenStatusSwitch(
                      isOpen: state is AddRestaurantFormState && state.isOpen,
                      onChanged: (final bool value) {
                        context.read<AddRestaurantBloc>().add(
                          RestaurantOpenStatusChanged(isOpen: value),
                        );
                      },
                    ),
                    ImagePickerCard(
                      image:
                          state is AddRestaurantFormState
                              ? state.mainImage
                              : null,
                    ),
                    SubmitButton(
                      isLoading: state is AddRestaurantLoading,
                      onPressed: () => _submitForm(context, state),
                    ),
                  ],
                ),
              ),
              AddRestaurantLoading() => const AddingLoading(),

              AddRestaurantFailure(message: final String message) =>
                 Center(child: Text(message)),
            },
      ),
    ),
  );
}
