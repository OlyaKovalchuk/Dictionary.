import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryFake implements UserRepository {
  bool shouldSignUpFail = false;

  @override
  Future<User?> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithCredentials(String email, String password) {
    // TODO: implement signInWithCredentials
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> singUp(
      {required String email, required String name, required String password}) async {
    if (shouldSignUpFail) {
      Future.error(Exception("fake exception"));
    }
  }
}
