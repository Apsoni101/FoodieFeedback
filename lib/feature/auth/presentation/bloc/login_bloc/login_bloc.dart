import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';
import 'package:foodiefeedback/feature/auth/domain/use_cases/auth_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authUseCase}) : super(AuthInitial()) {
    on<OnEmailLoginEvent>(_onEmailLoginEvent);
    on<OnGoogleLoginEvent>(_onGoogleLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  AuthUseCase authUseCase;

  Future<void> _onEmailLoginEvent(
    final OnEmailLoginEvent event,
    final Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    final RegExp passwordRegex = RegExp(r'^.{6,}$');

    if (!emailRegex.hasMatch(event.email)) {
      emit(InvalidEmail());
      return;
    }

    if (!passwordRegex.hasMatch(event.password)) {
      emit(InvalidPassword());
      return;
    }

    final Either<Failure, UserEntity> result = await authUseCase
        .signInWithEmail(event.email, event.password);

    result.fold(
      (final Failure failure) => emit(AuthFailure(message: failure.message)),
      (final UserEntity user) => emit(AuthSuccessful()),
    );
  }

  Future<void> _onGoogleLoginEvent(
    final OnGoogleLoginEvent event,
    final Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final Either<Failure, UserEntity> result =
        await authUseCase.signInWithGoogle();

    result.fold(
      (final Failure failure) => emit(AuthFailure(message: failure.message)),
      (final UserEntity user) => emit(AuthSuccessful()),
    );
  }

  Future<void> _onLogoutEvent(
    final LogoutEvent event,
    final Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final Either<Failure, void> result = await authUseCase.signOut();

    result.fold(
      (final Failure failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }
}
