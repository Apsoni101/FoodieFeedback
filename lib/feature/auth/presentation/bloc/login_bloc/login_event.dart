part of 'login_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object>[];
}

final class OnEmailLoginEvent extends AuthEvent {
  const OnEmailLoginEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => <String>[email, password];
}

final class OnGoogleLoginEvent extends AuthEvent {
  const OnGoogleLoginEvent();

  @override
  List<Object?> get props => <Object>[];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
