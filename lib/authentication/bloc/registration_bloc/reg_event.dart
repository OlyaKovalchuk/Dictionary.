import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable{
  @override
  List<Object?> get props => [];

}

class RegWithCredentialsPressed extends RegEvent{
  final String name;
  final String email;
  final String password;

RegWithCredentialsPressed({required this.password,required this.email,required this.name});

  @override
  List<Object?> get props => [email, password,name];
}

class RegWithGoogle extends RegEvent{}

class RegWithFacebook extends RegEvent{}