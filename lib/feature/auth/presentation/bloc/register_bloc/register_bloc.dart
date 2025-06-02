import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/feature/auth/domain/entities/user_entity.dart';
import 'package:foodiefeedback/feature/auth/domain/use_cases/auth_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authUseCase}) : super(const RegisterInitial()) {
    on<OnEmailRegisterEvent>(_onEmailRegisterEvent);
    on<OnGoogleRegisterEvent>(_onGoogleRegisterEvent);
  }

  final AuthUseCase authUseCase;

  Future<void> _onEmailRegisterEvent(
    final OnEmailRegisterEvent event,
    final Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterLoading());

    final Either<Failure, UserEntity> result = await authUseCase
        .signUpWithEmail(event.name,event.email, event.password);

    result.fold(
      (final Failure failure) =>
          emit(RegisterFailure(message: failure.message)),
      (final UserEntity user) => emit(const RegisterSuccessful()),
    );
  }

  Future<void> _onGoogleRegisterEvent(
    final OnGoogleRegisterEvent event,
    final Emitter<RegisterState> emit,
  ) async {
    emit(const RegisterLoading());

    final Either<Failure, UserEntity> result =
        await authUseCase.signInWithGoogle();

    result.fold(
      (final Failure failure) =>
          emit(RegisterFailure(message: failure.message)),
      (final UserEntity user) => emit(const RegisterSuccessful()),
    );
  }
}
