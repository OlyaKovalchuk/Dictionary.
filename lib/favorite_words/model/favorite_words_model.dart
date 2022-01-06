import 'dart:convert';
import 'package:Dictionary/favorite_words/model/words_model.dart';
import 'package:uuid/uuid.dart';

class FavoriteWordsData {
  final String uid;
  final List<WordData> words;

  FavoriteWordsData({
    String? uid,
    required this.words,
  }) : this.uid = uid ?? Uuid().v1();

  FavoriteWordsData copyWith({String? uid, List<WordData>? words}) {
    return FavoriteWordsData(uid: uid ?? this.uid, words: words ?? []);
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

  factory FavoriteWordsData.fromMap(Map<String, dynamic> map) {
    return FavoriteWordsData(
        uid: map['uid'],
        words: List<WordData>.from(
            map['words']?.map((word) => WordData.fromMap(word))));
  }

  String toJson() => json.encode(toMap());

  factory FavoriteWordsData.fromJson(String source) =>
      FavoriteWordsData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavWordData(uid: $uid, words: $words)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteWordsData && other.uid == uid && other.words == words;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ words.hashCode;
  }
}
