import 'dart:convert';
import 'package:uuid/uuid.dart';

class UserData {
  final String uid;
  final String name;
  final String email;
  final String photoURL;

  UserData(
      {String? uid,
      required this.name,
      required this.email,
      required this.photoURL})
      : this.uid = uid ?? Uuid().v1();

  UserData copyWith(
      {String? uid,
      String? name,
      String? email,
      List? favoriteWord,
      String? photoURL}) {
    return UserData(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        photoURL: photoURL ?? this.photoURL);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': name,
      'email': email,
      'photoURL': photoURL,
    };
  }

  Map<String, dynamic> onlyTextMap() {
    return {
      'uid': uid,
      'displayName': name,
      'email': email,
      'photoURL': photoURL
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'],
      name: map['displayName'],
      email: map['email'],
      photoURL: map['photoURL'] ??
          'https://firebasestorage.googleapis.com/v0/b/point-citi.appspot.com/o/avatars%2Fempty_logo.svg?alt=media&token=c21ab355-6c25-4109-adc7-c0769926eac2',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(uid: $uid, name: $name, email: $email, photoURL: $photoURL )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ photoURL.hashCode;
  }
}
