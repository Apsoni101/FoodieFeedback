import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:foodiefeedback/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:foodiefeedback/feature/auth/presentation/widgets/google_sign_in_button.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key, this.onLoggedIn});

  final VoidCallback? onLoggedIn;

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocConsumer<AuthBloc, AuthState>(
    listener: (final BuildContext context, final AuthState state) {
      switch (state) {
        case LogoutSuccess():
        case AuthInitial():
        case AuthLoading():
          break;
        case InvalidEmail():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localisation.invalidEmail)),
          );
        case InvalidPassword():
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localisation.passwordTooShort)),
          );
        case AuthSuccessful():
          _emailController.clear();
          _passwordController.clear();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(context.localisation.welcome)));
          widget.onLoggedIn?.call();

        case AuthFailure():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
      }
    },
    builder: (final BuildContext context, final AuthState state) {
      switch (state) {
        case AuthLoading():
        case InvalidEmail():
        case InvalidPassword():
        case LogoutSuccess():
        case AuthSuccessful():
        case AuthInitial():
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  context.localisation.login,
                  style: AppTextStyles.headline0.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                CustomTextField(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  textEditingController: _emailController,
                  labelText: context.localisation.email,
                  hintText: context.localisation.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                ),

                CustomTextField(
                  prefixIcon: Icon(
                    Icons.password,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  textEditingController: _passwordController,
                  labelText: context.localisation.password,
                  hintText: context.localisation.enterPassword,
                  obscureText: true,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redGradientMiddle,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 44,
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      OnEmailLoginEvent(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                  },
                  child: Text(
                    context.localisation.login,
                    style: AppTextStyles.title.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                Text(
                  context.localisation.orSignInUsing,
                  style: AppTextStyles.subtitle.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                GoogleSignInButton(
                  text: context.localisation.googleSignIn,
                  onPressed:
                      () => context.read<AuthBloc>().add(
                        const OnGoogleLoginEvent(),
                      ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      context.localisation.dontHaveAccount,
                      style: AppTextStyles.subtitle.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextButton(
                      onPressed:
                          () => context.router.push(
                            RegisterRoute(
                              onRegistered: widget.onLoggedIn
                            ),
                          ),
                      child: Text(
                        context.localisation.register,
                        style: AppTextStyles.subtitle.copyWith(
                          color: AppColors.redGradientMiddle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        case AuthFailure():
          return Center(child: Text(state.message));
      }
    },
  );
}
