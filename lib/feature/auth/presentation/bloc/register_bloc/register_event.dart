part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => <Object>[];
}

class OnEmailRegisterEvent extends RegisterEvent {
  const OnEmailRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

class OnGoogleRegisterEvent extends RegisterEvent {
  const OnGoogleRegisterEvent();
}
