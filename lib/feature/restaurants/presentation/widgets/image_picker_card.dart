import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/add_restaurant/add_restaurant_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({this.image, super.key});

  final File? image;

  Future<void> _pickMainImage(final BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<AddRestaurantBloc>().add(
        RestaurantImageChanged(File(image.path)),
      );
    }
  }

  @override
  Widget build(final BuildContext context) => Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.localisation.restaurantImage,
            style: AppTextStyles.subtitle,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.bgGrey,
              borderRadius: BorderRadius.circular(8),
              image:
                  image != null
                      ? DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
            child:
                image == null
                    ? const Icon(
                      Icons.image,
                      size: 64,
                      color: AppColors.brokenImgGrey,
                    )
                    : null,
          ),
          ElevatedButton.icon(
            onPressed: () => _pickMainImage(context),
            icon: const Icon(Icons.photo),
            label: Text(
              image != null
                  ? context.localisation.changeImage
                  : context.localisation.pickImage,
            ),
          ),
        ],
      ),
    ),
  );
}
