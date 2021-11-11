import 'package:Dictionary/blocs/request_word.dart';
import 'package:Dictionary/blocs/search_bloc/word_search_states.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:Dictionary/service/definition.api.dart';
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