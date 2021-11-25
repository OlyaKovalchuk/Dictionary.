import 'package:dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:dictionary/favorite_words/model/words_model.dart';
import 'package:dictionary/favorite_words/repository/favorite_words_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavWordsService {
  Future<FavoriteWords?> getFavWords();

  Future<bool> isFavWord(String word);

  Future addToFavWords(WordData word);

  Future deleteToFavWords(WordData word);
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
  @override
  Future<bool> isFavWord(String word) async {
    FavoriteWords? _favoriteWords = await getFavWords();
    return _favoriteWords != null && _favoriteWords.words.contains(word);
  }
  @override
  Future addToFavWords(WordData word) async {
    try {
      FavoriteWords? _favoriteWords = await getFavWords();
      print(word);
      if (_favoriteWords != null && !_favoriteWords.words.contains(word.word)) {
        _favoriteWords.words.add(word);
        await _fireFavoriteWordsDataRepo.updateFavoriteWords(_favoriteWords);
        print(word);
        print('FavWords: ${_favoriteWords.words}');
      }
    } catch (e) {
      print('Update: $e');
    }
  }

  @override
  Future deleteToFavWords(WordData word) async {
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
