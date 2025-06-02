part of 'login_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => <Object>[];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccessful extends AuthState {}

class LogoutSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  const AuthFailure({required this.message});

  final String message;
}

final class InvalidEmail extends AuthState {}

final class InvalidPassword extends AuthState {}
