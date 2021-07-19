import 'dart:async';
import 'dart:convert';
import 'package:Dictionary/model/ApiState.dart';
import 'package:Dictionary/model/search_response.dart';
import 'package:http/http.dart';
import 'package:random_words/random_words.dart';

class DictionaryApi {
  DictionaryApi();

  late StreamController<SearchResponse> streamController;
  late Stream<SearchResponse> stream;

  Future<SearchResponse> search(String word) async {
//https://api.dictionaryapi.dev/api/v2/entries/en_US/hello
//https://owlbot.info/api/v4/dictionary/
//    var _token = '4bd03a763bbfcee32307619bcf6a2a8ed49349e1';
    var url =
    Uri.http('api.dictionaryapi.dev', 'api/v2/entries/en_US/${word.trim()}');
    Response response = await get(url);
    var body = json.decode(response.body) as List;
    SearchResponse searchResponse = SearchResponse.fromJson(body[0]);
    return searchResponse;
  }
}
