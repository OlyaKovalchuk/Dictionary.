import 'package:dictionary/favorite_words/bloc/favorite_words_event.dart';
import 'package:dictionary/favorite_words/bloc/favorite_words_state.dart';
import 'package:dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:dictionary/favorite_words/model/words_model.dart';
import 'package:dictionary/favorite_words/service/favorite_words_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavWordsBloc extends Bloc<FavWordsEvent, FavWordsState> {
  final FavWordsService _favWordsService;
  List<WordData>? favWords;


  FavWordsBloc(FavWordsService favWordsService, [this.favWords])
      : _favWordsService = favWordsService,
        super(InitialState());

  Stream<FavWordsState> mapEventToState(FavWordsEvent event) async* {
    if (event is AddToFavWordsEvent) {
      yield* addEventToState(event.word);
    } else if (event is GetFavWordsEvent) {
      yield* getEventToState();
    } else if (event is InitialEvent) {
      yield* getEventToState();
    } else if (event is DeleteFavWordsEvent) {
      yield* deleteEventToState(event.word);
    }
  }

  Stream<FavWordsState> addEventToState(WordData word) async* {
    yield LoadingState();
    try {
      await _favWordsService.addToFavWords(word);
      yield SuccessState();
    } catch (e) {
      yield FailureState();
      print('Add User: $e');
    }
  }

  Stream<FavWordsState> getEventToState() async* {
    yield LoadingState();
    try {
    FavoriteWords? favoriteWords =  await _favWordsService.getFavWords();
    favWords = favoriteWords!.words;
      yield SuccessState();
    } catch (e) {
      yield FailureState();
      print('Get User: $e');
    }
  }

  Stream<FavWordsState> deleteEventToState(WordData word) async* {
    yield LoadingState();
    try {
      await _favWordsService.deleteToFavWords(word);
      yield SuccessState();
    } catch (e) {
      yield FailureState();
      print(e);
    }
  }
}
