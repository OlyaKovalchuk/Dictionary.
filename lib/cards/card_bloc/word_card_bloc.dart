import 'dart:math';
import 'package:dictionary/cards/card_bloc/word_card_event.dart';
import 'package:dictionary/cards/card_bloc/word_card_states.dart';
import 'package:dictionary/cards/model/search_response.dart';
import 'package:dictionary/cards/repository/word_data.dart';
import 'package:bloc/bloc.dart';
import 'package:dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:english_words/english_words.dart';

class WordCardBloc extends Bloc<WordEvent, WordCardStackState> {
  final Repository? repository;
  List<WordCardState> cardStates = [];
  final FavWordsService favWordsService;

  WordCardBloc({this.repository, required this.favWordsService})
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
      final bool isFavorited = await favWordsService.isFavWord(word);
      cardStates.add(Ready(word: response, isFavorited: isFavorited));
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
