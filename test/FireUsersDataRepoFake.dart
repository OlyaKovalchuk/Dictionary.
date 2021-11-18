import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/repository/user_repository.dart';

class FireUsersDataRepoFake implements FireUsersDataRepo {

  bool shouldSetUserFail = false;

  @override
  Future<bool> existsByPhone(String phone) {
    // TODO: implement existsByPhone
    throw UnimplementedError();
  }

  @override
  Future<UserData?> getUser(String uid) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserData>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  setNumber(String number) {
    // TODO: implement setNumber
    throw UnimplementedError();
  }

  @override
  setUser(UserData userData) {
    if (shouldSetUserFail) {
      throw Exception("fake exception");
    }
  }

}