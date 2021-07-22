import 'package:Dictionary/model/search_response.dart';
import 'package:equatable/equatable.dart';

abstract class WordState extends Equatable {
  WordState([List props = const []]) : super();
}

class WordEmpty extends WordState {
  @override
  List<Object?> get props => [];
}

class WordLoading extends WordState {
  @override
  List<Object?> get props => [];
}

class WordLoaded extends WordState {
  @override
  List<Object?> get props => [response];
  final SearchResponse response;

  WordLoaded({required this.response}) : super([response]);
}

class WordError extends WordState {
  @override
  List<Object?> get props => [];
}
