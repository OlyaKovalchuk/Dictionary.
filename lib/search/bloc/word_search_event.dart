import 'package:equatable/equatable.dart';

abstract class WordSearchEvent extends Equatable {
  WordSearchEvent([List props = const []]) : super();
}

class WordSearch extends WordSearchEvent {
  final String? word;

  WordSearch({this.word});

  @override
  List<Object?> get props => [];
}

class InitView extends WordSearchEvent {
  @override
  List<Object?> get props => [];
}
