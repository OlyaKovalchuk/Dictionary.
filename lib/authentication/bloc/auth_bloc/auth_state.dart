import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthOnSuccess extends AuthState {
  late final User? user;

  AuthOnSuccess({required this.user});

  List<Object?> get props => [user];
}

class AuthFailed extends AuthState {}
