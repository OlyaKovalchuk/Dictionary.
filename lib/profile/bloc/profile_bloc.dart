import 'package:Dictionary/authentication/model/user_data_model.dart';
import 'package:Dictionary/authentication/service/firebase_auth_service.dart';
import 'package:Dictionary/profile/bloc/profile_event.dart';
import 'package:Dictionary/profile/bloc/profile_state.dart';
import 'package:Dictionary/profile/service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileService) : super(EmptyProfile());
  UserData? userData;
  final ProfileService profileService;
  UserRepository _userRepositoryImpl = UserRepositoryImpl();

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetUser) {
      yield* _getUserEventToState();
    } else if (event is SingOut) {
      yield* _singOutEventToState();
    }
    LoadingProfile();
  }

  Stream<ProfileState> _getUserEventToState() async* {
    try {
      User? user = await _userRepositoryImpl.getUser();
      userData = UserData(
          name: user!.displayName!,
          email: user.email!,
          photoURL: user.photoURL!);
      print(user);
      yield SuccessProfile();
    } on FirebaseException catch (error) {
      print(error);
      yield ErrorProfile();
    }
  }

  Stream<ProfileState> _singOutEventToState() async* {
    try {
      await _userRepositoryImpl.signOut();
      yield SuccessSignOut();
    } on FirebaseException catch (e) {
      print(e);
      yield ErrorProfile();
    }
  }
}
