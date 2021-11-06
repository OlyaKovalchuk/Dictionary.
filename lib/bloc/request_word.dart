import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable {
  WordEvent([List props = const []]) : super();
}

 class RequestWord extends WordEvent {
  String? word;

  RequestWord({this.word});

  @override
  List<Object?> get props => [];
}
