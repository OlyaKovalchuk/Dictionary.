import 'package:Dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FireFavoriteWordsDataRepo {
  setFavoriteWord(FavoriteWords words);

  Future<FavoriteWords?> getUsersFavWords(String uid);
}

class FireFavWordsRepoImpl implements FireFavoriteWordsDataRepo {
  CollectionReference _favoriteWordsCollection =
      FirebaseFirestore.instance.collection('favoriteWords');

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  setFavoriteWord(FavoriteWords words) async {
    try {
      await _favoriteWordsCollection.doc(words.uid).set(words.onlyTextMap());
      await _favoriteWordsCollection.doc(words.uid).set(words.toMap());
    } catch (e) {
      print(e);
    }
  }

  updateFavoriteWords(FavoriteWords favoriteWords) async {
    await _favoriteWordsCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .update(favoriteWords.toMap());
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

  deleteFavoriteWord(FavoriteWords words) async {
    try {
      await _favoriteWordsCollection
          .doc(_firebaseAuth.currentUser!.uid)
          .delete();
    } catch (e) {}
  }
}
