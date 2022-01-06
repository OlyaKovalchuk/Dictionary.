import 'package:Dictionary/favorite_words/model/favorite_words_model.dart';
import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/repository/user_repository.dart';
import 'package:Dictionary/favorite_words/repository/favorite_words_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRepository {
  Future signInWithCredentials(String email, String password);

  singUp(
      {required String email, required String name, required String password});

  Future<User?> signInWithGoogle();

  Future<User?> signInWithFacebook();

  Future signOut();

  Future<bool> isSignedIn();

  Future<User?> getUser();
}

class UserRepositoryImpl implements UserRepository {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FireUsersDataRepo _fireUsersDataRepo = FireUsersDataRepoImpl();
  FireFavWordsRepoImpl _fireFavWordsRepoImpl = FireFavWordsRepoImpl();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInWithCredentials(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    print(userCredential);
  }

  Future<void> singUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      User? user = userCredential.user;
      print('User: $user');
      _createNewUser(user, name);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    User? _user;
    final UserCredential _userCredential;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        _userCredential = await _firebaseAuth.signInWithCredential(credential);
        _user = _userCredential.user;
        _createNewUser(_user);
      } catch (e) {
        print(e);

        return Future.error(e);
      }
    }

    return _user;
  }

  Future<User?> signInWithFacebook() async {
    User? _user;
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    UserCredential _userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    _user = _userCredential.user;

    _createNewUser(_user);

    return _user;
  }

  Future signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }

  _createNewUser(User? user, [String? name]) async {
    if (user != null) {
      final UserData? _getUser = await _fireUsersDataRepo.getUser(user.uid);
      print(user.email);
      if (_getUser == null) {
        print(_getUser);
        if (user.displayName == null) {
          _firebaseAuth.currentUser!.updateDisplayName(name);
        }
        if (user.photoURL == null) {
          _firebaseAuth.currentUser!.updatePhotoURL(
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
        }
        UserData _userData = UserData(
          uid: user.uid,
          name: name ?? user.displayName!,
          email: user.email!,
          photoURL: user.photoURL ??
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
        );

        FavoriteWordsData _favoriteWords =
            FavoriteWordsData(words: [], uid: _userData.uid);
        _fireUsersDataRepo.setUser(_userData);
        _fireFavWordsRepoImpl.setFavoriteWord(_favoriteWords);
      }
    }
  }
}
