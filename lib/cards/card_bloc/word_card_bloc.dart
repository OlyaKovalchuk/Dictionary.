import 'dart:math';
import 'package:Dictionary/cards/card_bloc/word_card_event.dart';
import 'package:Dictionary/cards/card_bloc/word_card_states.dart';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:bloc/bloc.dart';
import 'package:Dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:english_words/english_words.dart';

class WordCardBloc extends Bloc<WordEvent, WordCardStackState> {
  final Repository? repository;
  List<WordCardState> cardStates = [];
  final FavWordsService favWordsService;

  List<SearchResponse> favWords = [];

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
    } else if (event is WordSwipeFavWords) {
      for (int i = 0; i < event.words!.length; i++)
        yield* fetchFavWords(event.words![i]);
    }
  }

  Stream<WordCardStackState> fetchWord() async* {
    try {
      final word = _randomWord();
      final SearchResponse response = await repository!.search(word);
      final favWord = WordData(
          word: response.word, audio: response.phonetics?[0].audio ?? '');
      print(favWord);
      final bool isFavorited = await favWordsService.isFavWord(favWord);
      cardStates.add(Ready(word: response, isFavorited: isFavorited));
      yield WordCardStackState(wordCardStates: cardStates);
    } catch (exception) {
      print(exception);
      cardStates.add(Error());
      yield WordCardStackState(wordCardStates: cardStates);
    }
  }

  Stream<WordCardStackState> fetchFavWords(WordData word) async* {
    try {
      final SearchResponse response = await repository!.search(word.word);
      final favWord = WordData(
          word: response.word, audio: response.phonetics?[0].audio ?? '');
      print(favWord);
      final bool isFavorited = await favWordsService.isFavWord(favWord);
      favWords.add(response);
      cardStates.add(Ready(word: response, isFavorited: isFavorited));
      yield WordCardStackState(wordCardStates: cardStates);
    } catch (e) {
      print(e);
      cardStates.add(Error());
      yield WordCardStackState(wordCardStates: cardStates);
    }
  }

  _randomWord() {
    final index = Random().nextInt(nouns.length - 1);
    return nouns[index];
  }
}
