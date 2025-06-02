import 'package:flutter/material.dart';
import 'package:foodiefeedback/feature/restaurants/domain/entities/restaurants_entity.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/custom_image.dart';
import 'package:foodiefeedback/feature/restaurants/presentation/widgets/restaurant_item_card_description.dart';

class RestaurantCard extends StatefulWidget {
  const RestaurantCard({
    required this.restaurant,
    required this.onTap,
    super.key,
  });

  final RestaurantEntity restaurant;
  final VoidCallback onTap;

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard>
    with AutomaticKeepAliveClientMixin {//
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(final BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomImage(imageUrl: widget.restaurant.imageUrl, aspectRatio: 2.3),
            RestaurantItemCardDescription(restaurant: widget.restaurant),
          ],
        ),
      ),
    );
  }
}
