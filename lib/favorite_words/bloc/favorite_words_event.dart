import 'package:equatable/equatable.dart';

abstract class FavWordsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends FavWordsEvent {}

class AddToFavWords extends FavWordsEvent {
  final String word;

  AddToFavWords({required this.word});
}

class GetFavWords extends FavWordsEvent {}

class DeleteFavWords extends FavWordsEvent {
  final String word;

  DeleteFavWords({required this.word});
}
