import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    required this.imageUrl,
    required this.aspectRatio,
    super.key,
  });

  final String imageUrl;
  final double aspectRatio;

  @override
  Widget build(final BuildContext context) => AspectRatio(
    aspectRatio: aspectRatio,
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      cacheKey: imageUrl,
      progressIndicatorBuilder:
          (
            final BuildContext context,
            final String url,
            final DownloadProgress downloadProgress,
          ) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.redGradientMiddle,
            ),
          ),
      errorWidget:
          (final BuildContext context, final String url, final Object error) =>
              const Icon(Icons.broken_image),
    ),
  );
}
