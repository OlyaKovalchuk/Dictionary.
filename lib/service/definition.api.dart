import 'dart:async';
import 'dart:convert';
import 'package:Dictionary/model/search_response.dart';
import 'package:http/http.dart';

class DictionaryApi {
  DictionaryApi();

  Future<SearchResponse> search(String word) async {
//https://api.dictionaryapi.dev/api/v2/entries/en_US/hello
    var url = Uri.http(
        'api.dictionaryapi.dev', 'api/v2/entries/en_US/${word.trim()}');
    Response response = await get(url);
    var body = json.decode(response.body) as List;
    SearchResponse searchResponse = SearchResponse.fromJson(body[0]);
    return searchResponse;
  }
}
