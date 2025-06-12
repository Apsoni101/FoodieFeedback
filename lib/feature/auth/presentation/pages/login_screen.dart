import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/di/app_injector.dart';
import 'package:foodiefeedback/feature/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:foodiefeedback/feature/auth/presentation/widgets/login_page_body.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.onLoggedIn});

  final VoidCallback? onLoggedIn;

  @override
  Widget build(final BuildContext context) => BlocProvider<AuthBloc>(
    create: (_) => AppInjector.getIt<AuthBloc>(),
    child: BlocListener<AuthBloc, AuthState>(
      listener: (final BuildContext context, final AuthState state) {
        if (state is AuthSuccessful) {
          onLoggedIn?.call();
          context.read<SettingsBloc>().add(const RefreshUserData());
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              AppAssets.loginBg,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            LoginPageBody(onLoggedIn: onLoggedIn),
          ],
        ),
      ),
    ),
  );
}
