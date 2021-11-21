import 'dart:convert';
import 'package:uuid/uuid.dart';

class UserData {
  final String uid;
  final String name;
  final String email;

  UserData({
    String? uid,
    required this.name,
    required this.email,
  }) : this.uid = uid ?? Uuid().v1();

  UserData copyWith(
      {String? uid, String? name, String? email, List? favoriteWord}) {
    return UserData(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,);
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
        email: map['email']);
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(uid: $uid, name: $name, email: $email,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode;
  }
}
