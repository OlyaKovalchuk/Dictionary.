import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileService {
  Future<UserData?> getUserData();

  Future<void> singOut();
}

class ProfileServiceImpl extends ProfileService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late UserRepository _userRepositoryImpl;

  @override
  Future<UserData?> getUserData() async {
    User? user = _firebaseAuth.currentUser;
    return UserData(
        name: user!.displayName!, email: user.email!, photoURL: user.photoURL!);
  }

  @override
  Future<void> singOut() async {
    try{
    await _userRepositoryImpl.signOut();
  }catch(e){
      throw Exception(e);
    }
    }
}
