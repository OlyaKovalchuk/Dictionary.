import 'package:dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:dictionary/favorite_words/repository/favorite_words_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavWordsService {
  Future<FavoriteWords?> getFavWords();

  Future<bool> isFavWord(String word);

  Future addToFavWords(String word);

  Future deleteToFavWords(String word);
}

class FavWordsServiceImpl implements FavWordsService {
  FireFavWordsRepoImpl _fireFavoriteWordsDataRepo = FireFavWordsRepoImpl();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FavoriteWords?> getFavWords() async {
    try {
      return await _fireFavoriteWordsDataRepo
          .getUsersFavWords(firebaseAuth.currentUser!.uid);
    } catch (e) {
      print('Get User: $e');
    }
  }

  Future<bool> isFavWord(String word) async {
    FavoriteWords? _favoriteWords = await getFavWords();
    return _favoriteWords != null && _favoriteWords.words.contains(word);
  }

  Future addToFavWords(String word) async {
    try {
      FavoriteWords? _favoriteWords = await getFavWords();
      print(word);
      if (_favoriteWords != null && !_favoriteWords.words.contains(word)) {
        _favoriteWords.words.add(word);
        await _fireFavoriteWordsDataRepo.updateFavoriteWords(_favoriteWords);
        print(word);
        print('FavWords: ${_favoriteWords.words}');
      }
    } catch (e) {
      print('Update: $e');
    }
  }

  Future deleteToFavWords(String word) async {
    try {
      FavoriteWords? _favoriteWords = await getFavWords();
      if (_favoriteWords != null && _favoriteWords.words.contains(word)) {
        _favoriteWords.words.remove(word);
        await _fireFavoriteWordsDataRepo.updateFavoriteWords(_favoriteWords);
        print(word);
        print('FavWords: ${_favoriteWords.words}');
      }
    } catch (e) {
      print('Delete: $e');
    }
  }
}
