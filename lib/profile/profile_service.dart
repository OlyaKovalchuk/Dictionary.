import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileService {
  Future<UserData?> getUserData() async {}

  Future singOut() async {}
}

class ProfileServiceImpl extends ProfileService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 UserRepositoryImpl _userRepositoryImpl = UserRepositoryImpl();

  Future<UserData?> getUserData() async {
    User? user = _firebaseAuth.currentUser;
    return UserData(
        name: user!.displayName!, email: user.email!, photoURL: user.photoURL!);
  }

  Future<User?> signOut() async {
   await _userRepositoryImpl.signOut();
  }
}
