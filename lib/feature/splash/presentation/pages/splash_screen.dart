import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ),
    );

    _controller.forward();

    Future<void>.delayed(const Duration(seconds: 5), () async {
      if (mounted) {
        await context.router.replaceAll(<PageRouteInfo<Object?>>[
          const RestaurantsListingRoute(),
        ]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Image.asset(
          AppAssets.splash_img,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Center(
          child: Text(
            context.localisation.appNameWithoutEmoji
                .replaceAll(' ', '\n'),
            style: AppTextStyles.displayXLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
