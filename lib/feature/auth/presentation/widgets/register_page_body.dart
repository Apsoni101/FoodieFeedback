import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/constants/app_colors.dart';
import 'package:foodiefeedback/core/constants/app_text_styles.dart';
import 'package:foodiefeedback/core/extensions/context_extensions/context_extensions.dart';
import 'package:foodiefeedback/core/navigation/app_router.gr.dart';
import 'package:foodiefeedback/feature/auth/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:foodiefeedback/feature/auth/presentation/widgets/custom_text_field.dart';

import 'package:foodiefeedback/feature/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:foodiefeedback/feature/settings/presentation/bloc/settings_bloc.dart';

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key, this.onRegistered});

  final VoidCallback? onRegistered;

  @override
  State<RegisterPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<RegisterPageBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) =>
      BlocConsumer<RegisterBloc, RegisterState>(
        listener: (final BuildContext context, final RegisterState state) {
          if (state is RegisterSuccessful) {
            widget.onRegistered?.call();
            context.read<SettingsBloc>().add(const RefreshUserData());
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (final BuildContext context, final RegisterState state) {
          switch (state) {
            case RegisterInitial():
            case RegisterLoading():
            case InvalidEmail():
            case InvalidPassword():
            case RegisterSuccessful():
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      context.localisation.register,
                      style: AppTextStyles.headline0.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    CustomTextField(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      textEditingController: _nameController,
                      labelText: context.localisation.name,
                      hintText: context.localisation.enterName,
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
                        context.read<RegisterBloc>().add(
                          OnEmailRegisterEvent(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      },
                      child: Text(
                        context.localisation.register,
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
                          () => context.read<RegisterBloc>().add(
                            const OnGoogleRegisterEvent(),
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
                          onPressed: () async {
                            await context.router.push(
                              LoginRoute(
                                onLoggedIn: () async {
                                  await context.router.replaceAll(
                                    <PageRouteInfo<Object?>>[
                                      const RestaurantsListingRoute(),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            context.localisation.login,
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
            case RegisterFailure():
              return Center(child: Text(state.message));
          }
        },
      );
}
