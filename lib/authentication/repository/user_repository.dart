import 'package:Dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireUsersDataRepo {
  Future<List<UserData>> getUsers();

  Future<UserData?> getUser(String uid);

  Future<void> setUser(UserData userData);
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

 Future<void> setUser(UserData userData) async {
    print(userData);
    try {
      await _usersCollection.doc(userData.uid).set(userData.onlyTextMap());

      await _usersCollection.doc(userData.uid).update(userData.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<FavoriteWordsData?> getUsersFavWords(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _favoriteWordsCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      return FavoriteWordsData.fromMap(
          documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}
