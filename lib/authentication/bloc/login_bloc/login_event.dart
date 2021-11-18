import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable{
  @override
  List<Object?> get props => [];

}

class LoginEmailChange extends RegEvent{
  final String email;

  LoginEmailChange({required this.email});

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChange extends RegEvent{
  final String password;

  LoginPasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class LoginWithCredentialsPressed extends RegEvent{
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.password,required this.email});

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogle extends RegEvent{}

class LoginWithFacebook extends RegEvent{}