import 'package:Dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireUsersDataRepo {
  Future<List<UserData>> getUsers();

  Future<UserData?> getUser(String uid);

  setUser(UserData userData);
}

class FireUsersDataRepoImpl implements FireUsersDataRepo {
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  CollectionReference _favoriteWordsCollection =
      FirebaseFirestore.instance.collection('favoriteWords');

  Future<List<UserData>> getUsers() async {
    QuerySnapshot usersSnap = await _usersCollection.get();
    List usersList = usersSnap.docs
        .map((e) => UserData.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return usersList as List<UserData>;
  }

  Future<UserData?> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await _usersCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      return UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  setUser(UserData userData) async {
    print(userData);
    try {
      // yes
      await _usersCollection.doc(userData.uid).set(userData.onlyTextMap());

      // Prevent errors on large or corrupted data
      await _usersCollection.doc(userData.uid).update(userData.toMap());
    } catch (e) {
      print(e);
    }
  }

  setFavoriteWord(FavoriteWords words) async {
    try {
      await _favoriteWordsCollection.doc(words.uid).set(words.onlyTextMap());
      await _favoriteWordsCollection.doc(words.uid).set(words.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<FavoriteWords?> getUsersFavWords(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _favoriteWordsCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      return FavoriteWords.fromMap(
          documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
