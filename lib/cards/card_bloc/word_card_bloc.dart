import 'dart:math';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_states.dart';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';

class WordCardBloc extends Bloc<WordEvent, WordCardStackState> {
  final Repository? repository;
  List<WordCardState> cardStates = [];

  WordCardBloc({this.repository})
      : super(WordCardStackState(wordCardStates: []));

  @override
  Stream<WordCardStackState> mapEventToState(WordEvent event) async* {
    if (event is WordSwipe) {
      yield* fetchWord();
    } else if (event is InitView) {
      for (int i = 0; i < 3; i++) {
        yield* fetchWord();
      }
    }
  }

  Stream<WordCardStackState> fetchWord() async* {
    try {
      final word = _randomWord();
      final SearchResponse response = await repository!.search(word);
      cardStates.add(Ready(word: response));
      yield WordCardStackState(wordCardStates: cardStates);
    } catch (exception) {
      cardStates.add(Error());
      yield WordCardStackState(wordCardStates: cardStates);
    }
  }

  String _randomWord() {
    final index = Random().nextInt(nouns.length - 1);
    return nouns[index];
  }
}
