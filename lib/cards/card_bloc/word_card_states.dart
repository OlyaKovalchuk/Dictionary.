import 'package:Dictionary/cards/model/search_response.dart';
import 'package:equatable/equatable.dart';

class WordCardStackState extends Equatable {
  final List<WordCardState> wordCardStates;

  WordCardStackState({required this.wordCardStates}) : super();

  @override
  List<Object?> get props => [wordCardStates];
}

abstract class WordCardState extends Equatable {
  WordCardState([List props = const []]) : super();
}

class Loading extends WordCardState {
  @override
  List<Object?> get props => [];
}

class Ready extends WordCardState {
  @override
  List<Object?> get props => [word];

  final SearchResponse word;

  Ready({required this.word}) : super([word]);
}

class Error extends WordCardState {
  @override
  List<Object?> get props => [];
}
