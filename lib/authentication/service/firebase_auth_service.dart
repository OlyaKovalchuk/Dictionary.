import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future signInWithCredentials(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future singUp(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Future.error(e);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future signOut() async {
    return Future.wait([_firebaseAuth!.signOut()]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth?.currentUser;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth?.currentUser;
  }
}
