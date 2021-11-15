import 'package:Dictionary/search/search_bloc/word_search_event.dart';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:Dictionary/search/search_bloc/word_search_states.dart';
import 'package:Dictionary/cards/repository/word_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordSearchBloc extends Bloc<WordEvent, WordSearchState>{

  final Repository? repository;
  WordSearchBloc({this.repository}) : super(WordSearchEmpty());

  @override
  Stream<WordSearchState> mapEventToState(WordEvent event) async* {
    if (event is WordSwipe) {
      yield WordSearchLoading();
      try {
        final SearchResponse response = await repository!.search(event.word!);
        yield WordSearchLoaded(response: response);
      } catch (exception) {
        yield WordSearchError();
      }
    }
  }

}