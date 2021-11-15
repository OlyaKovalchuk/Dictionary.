import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable{
  @override
  List<Object?> get props => [];

}

class RegWithCredentialsPressed extends RegEvent{
  final String email;
  final String password;
  final UserData userData;

RegWithCredentialsPressed({required this.password,required this.email, required this.userData});

  @override
  List<Object?> get props => [email, password];
}