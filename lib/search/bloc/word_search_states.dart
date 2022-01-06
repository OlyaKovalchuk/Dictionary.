import 'package:Dictionary/cards/model/search_response.dart';
import 'package:equatable/equatable.dart';

abstract class WordSearchState extends Equatable {
  WordSearchState([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class WordSearchEmpty extends WordSearchState {}

class WordSearchLoading extends WordSearchState {}

class WordSearchLoaded extends WordSearchState {
  @override
  List<Object?> get props => [response];

  final SearchResponse response;

  WordSearchLoaded({required this.response}) : super([response]);
}

class WordSearchError extends WordSearchState {}
