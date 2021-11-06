import 'dart:math';

import 'package:Dictionary/bloc/card_bloc/word_card_states.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/service/definition.api.dart';
import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';
import '../request_word.dart';

class WordCardBloc extends Bloc<WordEvent, WordCardState> {
  final Repository repository;
  List<SearchResponse> responses =[];

  WordCardBloc({required this.repository}) : super(WordCardEmpty());

  @override
  Stream<WordCardState> mapEventToState(WordEvent event) async* {
    if (event is RequestWord) {
      try {
        final word = _randomWord();
        final SearchResponse response = await repository.search(word);
        responses.add(response);
        yield WordCardLoaded(wordList: responses);
      } catch (exception) {
        yield WordCardError();
      }
    }
  }

  String _randomWord() {
    final index = Random().nextInt(nouns.length - 1);
    return nouns[index];
  }
}
