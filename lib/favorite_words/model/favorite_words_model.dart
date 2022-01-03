import 'dart:convert';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:uuid/uuid.dart';

class FavoriteWords {
  final String uid;
  final List<WordData> words;

  FavoriteWords({
    String? uid,
    required this.words,
  }) : this.uid = uid ?? Uuid().v1();

  FavoriteWords copyWith({String? uid, List<WordData>? words}) {
    return FavoriteWords(uid: uid ?? this.uid, words: words ?? []);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'words': words.map((word) => word.toMap()).toList(),
    };
  }

  Map<String, dynamic> onlyTextMap() {
    return {
      'uid': uid,
      'words': words.map((word) => word.toMap()).toList(),
    };
  }

  factory FavoriteWords.fromMap(Map<String, dynamic> map) {
    return FavoriteWords(
        uid: map['uid'],
        words: List<WordData>.from(
            map['words']?.map((word) => WordData.fromMap(word))));
  }

  String toJson() => json.encode(toMap());

  factory FavoriteWords.fromJson(String source) =>
      FavoriteWords.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavWordData(uid: $uid, words: $words)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteWords && other.uid == uid && other.words == words;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ words.hashCode;
  }
}
