import 'package:Dictionary/search/bloc/word_search_event.dart';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/search/bloc/word_search_states.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  final Repository? repository;

  WordSearchBloc({this.repository}) : super(WordSearchEmpty());

  @override
  Stream<WordSearchState> mapEventToState(WordSearchEvent event) async* {
    if (event is InitView) {
      yield WordSearchEmpty();
    } else if (event is WordSearch) {
      yield WordSearchLoading();
      try {
        final SearchResponse response = await repository!.search(event.word!);
        yield WordSearchLoaded(response: response);
      } catch (exception) {
        print(exception);
        yield WordSearchError();
      }
    }
  }
}
