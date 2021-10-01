import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCloud {
  final userRef = FirebaseFirestore.instance.collection('users');


  getFavoriteWords() {
    final favoriteWords = userRef.where(
        'favoriteWords', isEqualTo: 'favoriteWords').get();
    return favoriteWords;
  }


  updateFavoriteWords() {
    final updateFavoriteWords = userRef.parent!.update(
        {'favoriteWords': userRef});

    return updateFavoriteWords;
  }


  deleteFavoriteWords() {
    final deleteFavoriteWords = userRef.parent!.delete();
    return deleteFavoriteWords;
  }

}
