import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/feature/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:foodiefeedback/feature/auth/presentation/widgets/register_page_body.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, this.onRegistered});

  final VoidCallback? onRegistered;

  @override
  Widget build(final BuildContext context) => BlocProvider<RegisterBloc>(
    create: (_) => AppInjector.getIt<RegisterBloc>(),
    child: Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            AppAssets.loginBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          RegisterPageBody(onRegistered: onRegistered),
        ],
      ),
    ),
  );
}
