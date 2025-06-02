part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => <Object>[];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccessful extends RegisterState {
  const RegisterSuccessful();
}

class RegisterFailure extends RegisterState {
  const RegisterFailure({required this.message});
  final String message;

  @override
  List<Object> get props => <Object>[message];
}

final class InvalidEmail extends RegisterState {}

final class InvalidPassword extends RegisterState {}
