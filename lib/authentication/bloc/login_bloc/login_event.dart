import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEmailChange extends LoginEvent {
  final String email;

  LoginEmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChange extends LoginEvent {
  final String password;

  LoginPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.password, required this.email});

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogle extends LoginEvent {}

class LoginWithFacebook extends LoginEvent {}
