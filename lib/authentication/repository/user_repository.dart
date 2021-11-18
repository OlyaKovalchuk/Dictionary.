import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireUsersDataRepo {

  Future<List<UserData>> getUsers();

  Future<UserData?> getUser(String uid);

  Future<bool> existsByPhone(String phone);

  setUser(UserData userData);

  setNumber(String number);
}

class FireUsersDataRepoImpl implements FireUsersDataRepo {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  CollectionReference _phoneNumbers =
  FirebaseFirestore.instance.collection('phoneNumbers');

  Future<List<UserData>> getUsers() async {
    QuerySnapshot usersSnap = await _usersCollection.get();
    List usersList = usersSnap.docs
        .map((e) => UserData.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    return usersList as List<UserData>;
  }

  Future<UserData?> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await _usersCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      return UserData.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<bool> existsByPhone(String phone) async {
    try {
      DocumentSnapshot documentSnapshot = await _phoneNumbers.doc(phone).get();
      return documentSnapshot.exists;
    } catch (e) {
      print('numcheckerr > $e');
      return false;
    }
  }

  setUser(UserData userData) async {
    print(userData);
    try {
      // yes
      await _usersCollection.doc(userData.uid).set(userData.onlyTextMap());

      // Prevent errors on large or corrupted data
      await _usersCollection.doc(userData.uid).update(userData.toMap());

    } catch (e) {
      print(e);
    }
  }

  setNumber(String number) async {
    print(number);
    try {
      await _phoneNumbers.doc(number).set({'nember': number});
    } catch (e) {
      print(e);
    }
  }
}