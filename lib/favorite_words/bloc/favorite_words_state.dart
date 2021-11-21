import 'package:equatable/equatable.dart';

abstract class FavWordsState extends Equatable {
  FavWordsState();

  @override
  List<Object?> get props => [];
}

class InitialState extends FavWordsState {}

class LoadingState extends FavWordsState {}

class SuccessState extends FavWordsState {}

class FailureState extends FavWordsState {}
