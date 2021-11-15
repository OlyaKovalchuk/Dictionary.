import 'dart:convert';
import 'package:uuid/uuid.dart';

class UserData {
  final String uid;
  final String name;
  final String email;
  final List<String>? favoriteWord;
  UserData({
    String? uid,
    required this.name,
    required this.email,
    required this.favoriteWord,
  }) : this.uid = uid ?? Uuid().v1();

  UserData copyWith({
    String? uid,
    String? name,
    String? email,
    List<String>? favoriteWord
  }) {
    return UserData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      favoriteWord: favoriteWord ?? this.favoriteWord??null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,

    };
  }

  Map<String, dynamic> onlyTextMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      favoriteWord: map['favoriteWord']??null
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(uid: $uid, name: $name, email: $email, favoriteWord: $favoriteWord)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
    other.favoriteWord == favoriteWord;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
    name.hashCode ^
    email.hashCode ^
    favoriteWord.hashCode;
  }
}