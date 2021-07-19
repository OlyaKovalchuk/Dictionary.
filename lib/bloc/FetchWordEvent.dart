import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super();
}

class FetchWord extends WordEvent {
  final String word;

  FetchWord({required this.word});

  @override
  List<Object?> get props => [word];
}
