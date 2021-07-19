import 'package:Dictionary/model/search_response.dart';

class ApiState {
  
}

class Loading implements ApiState {

}

// class Result extends ApiState {
//   SearchResponse searchResponse;
//   Result(this.searchResponse);
// }

class Result<T> implements ApiState {
  T response;
  Result(this.response);
}

class Error implements ApiState {

}