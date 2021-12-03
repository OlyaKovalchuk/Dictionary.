import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  ProfileState();
  @override
  List<Object?> get props => [];
}

class LoadingProfile extends ProfileState {}

class SuccessProfile extends ProfileState {}

class ErrorProfile extends ProfileState {}

class EmptyProfile extends ProfileState {}
