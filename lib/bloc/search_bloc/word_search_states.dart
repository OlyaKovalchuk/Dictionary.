import 'package:Dictionary/model/search_response.dart';
import 'package:equatable/equatable.dart';

abstract class WordSearchState extends Equatable {
  WordSearchState([List props = const []]) : super();
}

class WordSearchEmpty extends WordSearchState {
  @override
  List<Object?> get props => [];
}

class WordSearchLoading extends WordSearchState {
  @override
  List<Object?> get props => [];
}

class WordSearchLoaded extends WordSearchState {
  @override
  List<Object?> get props => [response];

  final SearchResponse response;

  WordSearchLoaded({required this.response}) : super([response]);
}

class WordSearchError extends WordSearchState {
  @override
  List<Object?> get props => [];
}
