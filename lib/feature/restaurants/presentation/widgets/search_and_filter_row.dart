import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/bloc/restaurants_listing_bloc/restaurants_listing_bloc.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/custom_search_field.dart';

class SearchAndFilterRow extends StatelessWidget {
  const SearchAndFilterRow({super.key});

  @override
  Widget build(final BuildContext context) => Row(
    spacing: 22,
    children: <Widget>[
      CustomSearchField(
        onChanged: (final String value) {
          context.read<RestaurantsListBloc>().add(SearchQuery(query: value));
        },
      ),
      IconButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: const CircleBorder(),
            side: const BorderSide(color: AppColors.profileRed,width: 2)
            ,padding: const EdgeInsets.all(2),),
        icon: const Icon(Icons.tune,color: AppColors.profileRed,size:28 ,),
      ),
    ],
  );
}
