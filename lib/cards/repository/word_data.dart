
import 'dart:convert';
import 'package:Dictionary/cards/model/search_response.dart';
import 'package:http/http.dart';

class Repository {
  Repository();
  search(String word) async {
//https://api.dictionaryapi.dev/api/v2/entries/en_US/hello
   try {
      var url = Uri.http(
          'api.dictionaryapi.dev', 'api/v2/entries/en_US/${word.trim()}');
      Response response = await get(url);
      var body = json.decode(response.body) as List;
      SearchResponse searchResponse = SearchResponse.fromJson(body[0]);
      return searchResponse;
    }catch(e) {
     print(e);
   }
  }
}
