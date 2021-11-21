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

class InitView extends WordEvent {

  InitView();

  @override
  List<Object?> get props => [];
}
