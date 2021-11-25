import 'package:dictionary/favorite_words/model/words_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavWordsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends FavWordsEvent {}

class AddToFavWordsEvent extends FavWordsEvent {
  final WordData word;

  AddToFavWordsEvent({required this.word});
}

class GetFavWordsEvent extends FavWordsEvent {}

class DeleteFavWordsEvent extends FavWordsEvent {
  final WordData word;

  DeleteFavWordsEvent({required this.word});
}
