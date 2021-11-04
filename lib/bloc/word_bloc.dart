import 'dart:math';

import 'package:Dictionary/bloc/word_states.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';
import 'FetchWordEvent.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final Repository repository;
  List<SearchResponse> responses =[];

  WordBloc({required this.repository}) : super(WordEmpty());

  @override
  Stream<WordState> mapEventToState(WordEvent event) async* {
    if (event is RequestWord) {
      yield WordLoading();
      try {
        final word = _randomWord();
        final SearchResponse response = await repository.search(word);
        responses.add(response);
        yield WordLoaded(response: responses);
      } catch (exception) {
        yield WordError();
      }
    }
  }

  String _randomWord() {
    final index = Random().nextInt(nouns.length - 1);
    return nouns[index];
  }
}
