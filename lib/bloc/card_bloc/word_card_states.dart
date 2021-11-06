import 'package:Dictionary/model/search_response.dart';
import 'package:equatable/equatable.dart';

abstract class WordCardState extends Equatable {
  WordCardState([List props = const []]) : super();
}

class WordCardEmpty extends WordCardState {
  @override
  List<Object?> get props => [];
}

class WordCardLoading extends WordCardState {
  @override
  List<Object?> get props => [];
}

class WordCardLoaded extends WordCardState {
  @override
  List<Object?> get props => [wordList];

  final List<SearchResponse> wordList;

  WordCardLoaded({required this.wordList}) : super([wordList]);
}

class WordCardError extends WordCardState {
  @override
  List<Object?> get props => [];
}
