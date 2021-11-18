import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryFake  implements UserRepository {
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
  Future signInWithCredentials(String email, String password) {
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
  Future signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  singUp(String email, String password, String name) {
    if (shouldSignUpFail) {
      return Future.error(Exception("fake exception"));
    }
  }
}
