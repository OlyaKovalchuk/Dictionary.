import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUser extends ProfileEvent {}

class SingOut extends ProfileEvent {}
