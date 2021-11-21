import 'dart:convert';
import 'package:uuid/uuid.dart';

class FavoriteWords {
  final String uid;
  final List words;

  FavoriteWords({
    String? uid,
    required this.words,
  }) : this.uid = uid ?? Uuid().v1();

  FavoriteWords copyWith({String? uid, List? words}) {
    return FavoriteWords(
        uid: uid ?? this.uid, words: words ?? this.words);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'words': words};
  }

  Map<String, dynamic> onlyTextMap() {
    return {'uid': uid, 'words': words};
  }

  factory FavoriteWords.fromMap(Map<String, dynamic> map) {
    return FavoriteWords(uid: map['uid'], words: map['words'] ?? []);
  }

  String toJson() => json.encode(toMap());

  factory FavoriteWords.fromJson(String source) =>
      FavoriteWords.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(uid: $uid, words: $words)';
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
