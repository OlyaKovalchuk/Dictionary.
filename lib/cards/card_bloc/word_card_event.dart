import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super();
}

class WordSwipe extends WordEvent {
  final String? word;

  WordSwipe({this.word});

  @override
  List<Object?> get props => [];
}

class WordSwipeFavWords extends WordEvent {
  final List<WordData>? words;

  WordSwipeFavWords([this.words]);

  @override
  List<Object?> get props => [];
}

class InitView extends WordEvent {
  @override
  List<Object?> get props => [];
}
